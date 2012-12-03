class PageFactory

  # As the PageFactory will be the superclass for all your page classes, having this initialize
  # method here means it's only written once.
  def initialize browser, visit = false
    @browser = browser
    goto if visit
    expected_element if respond_to? :expected_element
    has_expected_title? if respond_to? :has_expected_title?
  end

  # Catches any "missing" methods and passes them to the browser object--which means
  # that Watir will take care of parsing them.
  def method_missing sym, *args, &block
    @browser.send sym, *args, &block
  end

  class << self

    # Define this in a page class and when you use the "visit" method to instantiate the class
    # it will enter the URL the browser's address bar.
    def page_url url
      define_method 'goto' do
        @browser.goto url
      end
    end

    # Define this in a page class and when that class is instantiated it will wait until that
    # element appears on the page before continuing with the script.
    def expected_element element_name, timeout=30
      define_method 'expected_element' do
        self.send(element_name).wait_until_present timeout
      end
    end

    # Define this in a page class and when the class is instantiated it will verify that
    # the browser's title matches the expected title. If there isn't a match, it raises an
    # error and halts the script.
    def expected_title expected_title
      define_method 'has_expected_title?' do
        has_expected_title = expected_title.kind_of?(Regexp) ? expected_title =~ @browser.title : expected_title == @browser.title
        raise "Expected title '#{expected_title}' instead of '#{@browser.title}'" unless has_expected_title
      end
    end

    # The basic building block of the page object classes.
    # Use in conjunction with Watir to define all elements on a given page that are important to validate.
    #
    # @example
    #   element(:title) { |b| b.text_field(:id=>"title-id") }
    #   value(:page_header) { |b| b.h3(:class=>"page_header").text }
    def element element_name
      raise "#{element_name} is being defined twice in #{self}!" if self.instance_methods.include?(element_name.to_sym)
      define_method element_name.to_s do
        yield self
      end
    end
    alias :value :element

    # The basic building block for interacting with elements on a page, such as links and buttons.
    # Methods that take one or more parameters can be built with this as well.
    #
    # @example
    #   action(:continue) { |b| b.frm.button(:value=>"Continue").click }
    #   action(:select_style) { |stylename, b| b.div(:text=>/#{Regexp.escape(stylename)}/).link(:text=>"Select").click }
    #
    def action method_name, &block
      define_method method_name.to_s do |*thing|
        Proc.new(&block).call *thing, self
      end
    end

  end

end # PageMaker