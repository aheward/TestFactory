# This module provides methods that instantiate the page and data classes.
module Foundry

  # Using the page_url defined in the provided page_class,
  # this method will enter that url into the browser's address bar, then run the block of
  # code that you specify.
  # @param page_class [Class] the name of the page class that you want to instantiate
  # @param &block [C] this is the block of code that you want to run while on the given page
  def visit page_class, &block
    on page_class, true, &block
  end

  # Instantiates the supplied page class, then runs the supplied block of code. Use this
  # method when you are already on the site page you want to interact with.
  # @param page_class [Class] the name of the page class that you want to instantiate
  # @param visit [TrueClass, FalseClass] Essentially you will never have to specify this explicitly
  # @param &block [C] this is the block of code that you want to run while on the given page
  def on page_class, visit=false, &block
    @current_page = page_class.new @browser, visit
    block.call @current_page if block
    @current_page
  end
  alias on_page on

  # Use this for making a data object in your test steps
  #
  # @param data_object_class [Class] The name of the class you want to use to build a data object for testing
  # @param opts [Hash] The list of attributes you want to give to your data object
  def make data_object_class, opts={}
    data_object_class.new @browser, opts
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
  def wait_until(timeout=30, message=nil, &block)
    Object::Watir::Wait.until(timeout, message, &block)
  end

end