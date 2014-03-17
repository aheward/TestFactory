# Copyright 2012-2014 The rSmart Group, Inc.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#   http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# We are extending Watir's element methods here with the #fit method,
# which can be used with text fields, select lists, radio buttons,
# and checkboxes.
#
# The purpose of +#fit+ is to allow the creation, in your Data Object classes,
# of a minimal number of +#edit+ methods (ideally only one) written as
# concisely as possible.
#
# Without the +#fit+ method, you would either have to write separate edit
# methods for every possible field you want to edit, or else your
# edit method would have to contain lots of repetitive conditional code
# to prevent making inadvertent updates to those fields that don't need it.
#
# Proper use of the +#fit+ method requires following a particular coding
# pattern, however:
#
# * In your Page Classes, define your text field, select list, radio button, and
#   checkbox elements directly. Do not define +#select+, +#set+ and/or +#clear+
#   actions there.
# * Your data object's instance variables for radio buttons and checkboxes, when
#   not +nil+, should have the values of +:set+ or +:clear+. If they *need* to be
#   something else, then define a Hash transform method to easily convert the
#   custom values back to +:set+ or +:clear+, then pass that transform to the +#fit+ method.
# * Always remember to end your +#edit+ methods with the +#set_options()+
#   method (a.k.a. +#update_options+), from the DataFactory module. It
#   automatically takes care of updating your data object's instance variables
#   with any new values.
#
# ==Example
#
# Let's take a look at how the proper use of +#fit+ in your code can significantly
# clean things up, using a checkbox field for our example. Remember that +#fit+
# works with radio buttons, text fields, and select lists, too.
#
# First, here's some code written without using +#fit+, and using
# actions for the checkbox page objects, and a Data Object
# instance variable, +@option+, that is either "YES" or "NO"...
#
#   class MyPage < BasePage
#     # ...
#     action(:check_checkbox) { |b| b.checkbox(id: "checkbox").set }
#     action(:clear_checkbox) { |b| b.checkbox(id: "checkbox").clear }
#     # ...
#   end
#
#   class DataObject
#     # ...
#     def edit opts={}
#       # ...
#       if opts[:option] != @option
#         on MyPage do |page|
#           if opts[:option] == "NO"
#             page.clear_checkbox
#           else
#             page.check_checkbox
#           end
#         end
#         @option = opts[:option]
#       end
#       # ...
#     end
#     # ...
#   end
#
# That's just nasty! Your Page Class has two element definitions that are nearly identical.
# And the nested conditional in the Data Object's #edit method hurts the eyes!
#
# Now, let's take that same code, but this time use the +#fit+ method. We'll assume that
# the data object's +@option+ instance variable will be +:set+, +:clear+, or +nil+, and
# end the +#edit+ with the DataFactory's +#set_options+ helper method...
#
#   class MyPage < BasePage
#     # ...
#     element(:checkbox) { |b| b.checkbox(id: "checkbox") }
#     # ...
#   end
#
#   class DataObject
#     # ...
#     def edit opts={}
#       # ...
#       on MyPage do |page|
#         # ...
#         page.checkbox.fit opts[:option]
#         # ...
#       end
#       # ...
#       update_options opts
#     end
#     # ...
#   end
#
# Much cleaner!
#
# If you absolutely _must_ have your data object's instance variable be something
# other than +:set+ or +:clear+, then consider writing a private transform method
# in your data object class, like this:
#
#   def checkbox_trans
#     { "YES" => :set, "NO" => :clear }
#   end
#
# Then use that transform with your +#fit+ method, like this:
#
#   page.checkbox.fit checkbox_trans[opts[:option]]
#
module Watir

  class CheckBox
    def fit(arg)
      self.send(arg) unless arg==nil
    end
  end

  class Radio
    def fit(arg)
      self.set if arg==:set
    end
  end

  module UserEditable

    # Extends Watir's methods.
    # Use when the argument you are passing to a text field
    # may be nil, in which case you don't
    # want to do anything with the page element.
    #
    def fit(args)
      unless args==nil
        assert_exists
        assert_writable

        @element.clear
        @element.send_keys(args)
      end
    end
  end

  class Select

    # Extends Watir's methods.
    # Use when the argument you are passing to a text field
    # may be nil, in which case you don't
    # want to do anything with the page element.
    # @example
    #   page.select_list.fit @my_selection
    #
    def fit(str_or_rx)
      select_by :text, str_or_rx unless str_or_rx==nil
    end

    # Allows you to select a specific item in a
    # select list, or, if desired, it will pick an item from
    # the list at random.
    #
    # If you pass this method the string '::random::' then
    # it will select an item at random from the select
    # list and, assuming what you passed it was a class instance
    # variable, it will be updated to contain the
    # selected value (hence the ! in the method name).
    # Note that this method will be slow with large selection lists.
    #
    # @example
    #   @my_selection='::random::'
    #   page.select_list.pick! @my_selection
    #   puts @my_selection # => <Value of randomly selected item from list>
    #
    def pick!(item)
      if item=='::random::'
        item.replace(select_at_random)
      else
        fit item
      end
    end

    # Same as #pick!, except it does not change the
    # value of 'item'
    #
    def pick(item)
      if item=='::random::'
        select_at_random
      else
        fit item
      end
    end

    private

    def select_at_random
      ar = options.map(&:text)
      sel = ar.sample
      while sel=~/^select(.?)$/i || sel==''
        sel = ar.sample
      end
      select sel
      sel
    end

  end

end