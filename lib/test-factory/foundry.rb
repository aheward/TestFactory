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

# This module provides methods that instantiate the page and data classes.
module Foundry

  # Using the page_url defined in the provided page_class,
  # this method will enter that url into the browser's address bar, then run the block of
  # code that you specify.
  # @param page_class [Class] the name of the page class that you want to instantiate
  # @param &block [C] this is the block of code that you want to run while on the given page
  #
  def visit page_class, &block
    on page_class, true, &block
  end

  # Instantiates the supplied page class, then runs the supplied block of code. Use this
  # method when you are already on the site page you want to interact with.
  # @param page_class [Class] the name of the page class that you want to instantiate
  # @param visit [TrueClass, FalseClass] Essentially you will never have to specify this explicitly
  # @param &block [C] this is the block of code that you want to run while on the given page
  #
  def on page_class, visit=false, &block
    @current_page = page_class.new @browser, visit
    block.call @current_page if block
    @current_page
  end
  alias_method :on_page, :on

  # Use this for making a data object in your test steps
  #
  # @param data_object_class [Class] The name of the class you want to use to build a data object for testing
  # @param opts [Hash] The list of attributes you want to give to your data object
  #
  def make data_object_class, opts={}
    data_object_class.new @browser, opts
  end

  # An extension of the #make method that simplifies and improves
  # the readability of your "create" step definitions by
  # combining the make with the create. Of course, this
  # requires that your data object classes properly follow the design
  # pattern and have a #create method available.
  #
  def create data_object_class, opts={}
    data_object = make data_object_class, opts
    data_object.create
    data_object
  end

  # A helper method that takes a block of code and waits until it resolves to true.
  # Useful when you need to wait for something to be on a page that's a little more
  # involved than a simple element (for those, you should use the #expected_element
  # method found in the PageFactory class)
  # @param timeout [Fixnum] Defaults to 30 seconds
  # @param message [String] The text thrown if the timeout is reached
  #
  # @example
  #   page.wait_until { |b| b.processing_message=="Done" }
  #
  def wait_until(timeout=30, message=nil, &block)
    Object::Watir::Wait.until(timeout, message, &block)
  end

end