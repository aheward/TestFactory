# Copyright 2012-2013 The rSmart Group, Inc.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#   http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# The PageFactory class provides a set of methods that allow the rapid creation of page element definitions--known
# colloquially as "page objects". These elements are defined using Watir syntax. Please see www.watir.com if you are
# not familiar with Watir.
#
class PageFactory

  # As the PageFactory will be the superclass for all your page classes, having this initialize
  # method here means it's only written once.
  #
  def initialize browser, visit = false
    @browser = browser
    goto if visit
    expected_element if respond_to? :expected_element
    has_expected_title? if respond_to? :has_expected_title?
  end

  # Catches any "missing" methods and passes them to the browser object--which means
  # that Watir will take care of parsing them, so the assumption is that the method being
  # passed is a valid method for the browser object.
  #
  def method_missing sym, *args, &block
    @browser.send sym, *args, &block
  end

  class << self

    # Define this in a page class and when you use the "visit" method to instantiate the class
    # it will enter the URL in the browser's address bar.
    #
    def page_url url
      define_method 'goto' do
        @browser.goto url
      end
    end

    # Define this in a page class and when that class is instantiated it will wait until that
    # element appears on the page before continuing with the script.
    # @param element_name [Symbol] The method name of the element that must be present on the page
    #
    def expected_element element_name, timeout=30
      define_method 'expected_element' do
        self.send(element_name).wait_until_present timeout
      end
    end

    # Define this in a page class and when the class is instantiated it will verify that
    # the browser's title matches the expected title. If there isn't a match, it raises an
    # error and halts the script.
    # @param expected_title [String] The exact text that is expected to appear in the Browser title when the page loads
    #
    def expected_title expected_title
      define_method 'has_expected_title?' do
        has_expected_title = expected_title.kind_of?(Regexp) ? expected_title =~ @browser.title : expected_title == @browser.title
        raise "Expected title '#{expected_title}' instead of '#{@browser.title}'" unless has_expected_title
      end
    end

    # The basic building block for defining and interacting with
    # elements on a web page. # Use in conjunction with
    # Watir to define all elements on a given page that are important to validate.
    #
    # Methods that take one or more parameters can be built with this as well.
    #
    # @example
    #   element(:title) { |b| b.text_field(:id=>"title-id") }
    #   value(:page_header) { |b| b.h3(:class=>"page_header").text }
    #   action(:continue) { |b| b.frm.button(:value=>"Continue").click } => Creates a #continue method that clicks the Continue button
    #   p_element(:select_style) { |stylename, b| b.div(:text=>/#{Regexp.escape(stylename)}/).link(:text=>"Select").click } => #select_style(stylename)
    #
    def element name, &block
      raise "#{name} is being defined twice in #{self}!" if self.instance_methods.include?(name.to_sym)
      define_method name.to_s do |*thing|
        Proc.new(&block).call *thing, self
      end
    end
    alias_method :action, :element
    alias_method :value, :element
    alias_method :p_element, :element
    alias_method :p_action, :element
    alias_method :p_value, :element

    # Use this for links that are safe to define by their text string.
    # This method will return two methods for interacting with the link:
    # one that refers to the link itself, and one that clicks on it.
    # Since it's assumed that the most common thing done with a link is to click it,
    # the method for clicking it will be named according to the text of the link,
    # and the method for the link itself will have "_link" appended to it. Any special
    # characters are stripped from the string. Capital letters are made lower case.
    # And spaces and dashes are converted to underscores.
    #
    # @example
    #   link("Click Me For Fun!") => Creates the methods #click_me_for_fun and #click_me_for_fun_link
    #
    # The last parameter in the method is optional. Use it when
    # you need the method name to be different from the text of
    # the link--for example if the link text is something unhelpful,
    # like "here", or else the link text gets updated (e.g., what was
    # "Log In" is now "Sign In", instead) and you don't
    # want to have to go through all your data objects and step
    # definitions to update them to the new method name.
    #
    # @example
    #   link("Click Me For Fun!", :click_me) => Creates the methods #click_me and #click_me_link
    #
    def link(link_text, *alias_name)
      elementize(:link, link_text, *alias_name)
    end

    # Use this for buttons that are safe to define by their value attribute.
    # This method will return two methods for interacting with the button:
    # one that refers to the button itself, and one that clicks on it.
    # Since it's assumed that the most common thing done with a button is to click it,
    # the method for clicking it will be named according to the value of the button,
    # and the method for the button itself will have "_button" appended to it. Any special
    # characters are stripped from the string. Capital letters are made lower case.
    # And spaces and dashes are converted to underscores.
    # @param button_text [String] The contents of the button's value tag in the HTML
    #
    # @example
    #   button("Click Me For Fun!") => Creates the methods #click_me_for_fun and #click_me_for_fun_button
    #
    # The last parameter in the method is optional. Use it when
    # you need the method name to be different from the text of
    # the button--for example if the button text is unhelpful, like "Go", or else
    # it changes (e.g., from "Update" to "Edit") and you don't
    # want to have to go through all your data objects and step
    # definitions to update them to the new method name.
    #
    # @example
    #   link("Click Me For Fun!", :click_me) => Creates the methods #click_me and #click_me_link
    #
    def button(button_text, *alias_name)
      elementize(:button, button_text, *alias_name)
    end

    private
    # A helper method that converts the passed string into snake case. See the StringFactory
    # module for more info.
    #
    def damballa(text)
      StringFactory::damballa(text)
    end

    def elementize(type, text, *alias_name)
      hash={:link=>:text, :button=>:value}
      if alias_name.empty?
        el_name=damballa("#{text}_#{type}")
        act_name=damballa(text)
      else
        el_name="#{alias_name[0]}_#{type}".to_sym
        act_name=alias_name[0]
      end
      element(el_name) { |b| b.send(type, hash[type]=>text) }
      action(act_name) { |b| b.send(type, hash[type]=>text).click }
    end

  end

end # PageFactory