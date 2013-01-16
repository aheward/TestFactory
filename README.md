rSmart's TestFactory Gem
=========================

Overview
--------

This gem contains the basic framework for [dryly](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself) creating test scripts for the web site that needs testing.

Use it to abstract away from the underlying [Watir](http://www.watir.com) code and create your own [DSL](http://en.wikipedia.org/wiki/Domain_specific_language).

With TestFactory you have the ability to...

1. Easily instantiate page classes (described below) in a consistent and readable manner
2. Concisely describe elements on a page, keeping it DRY by avoiding repetition of element identifiers that may (will) change
3. Provide higher-level methods that use customizable (and default) data, along with the page classes and elements, to perform user-oriented functions with minimal lines of code

Tremendous thanks is due to [Alister Scott](http://watirmelon.com), whose [custom page object code](https://github.com/alisterscott/wmf-custom-page-object) for the Wikimedia Foundation provided the inspiration for this gem.

Summary
-------

Using the TestFactory properly involves three distinct steps:

1. Creating page classes that contain references to the elements on your web page. For this you use the PageFactory class. Working on page classes requires that you have a strong command of Watir and basic skills with Ruby.
2. Creating "data objects" that utilize your page classes and elements to build methods that perform user-oriented tasks. For this you use the DataFactory module. Working on data objects requires you have good familiarity with Watir and strong Ruby skills.
3. Creating test scenarios using your favorite test framework (like Cucumber or Rspec) and your data objects. The methods in the Foundry class are useful here. Working at this level requires only basic skills with Ruby and Watir, but a strong command of your DSL (the thing you're building with TestFactory).

How to Start
------------

First install the gem, of course.

    gem install test-factory

Now you'll want to start building your own page classes, using the methods in TestFactory as your tool chest.

Please note that the following example is *very* simplified and contrived, to keep every step as compartmentalized as possible. Once you've read through this, it is strongly recommended that you visit an actual repository that is using the test factory.

[Here](https://github.com/rSmart/sambal-cle) is one such.

Begin by creating a BasePage class. This class should have PageFactory as its superclass and define sets of class elements that are generally common across the pages of your site.

```ruby
require 'test-factory'

class BasePage < PageFactory

  class << self

    def header_elements
      element(:main_menu_link) { |b| b.link(title: "Main Menu") }
      element(:logout) { |b| b.button(value: "Logout") }
      element(:administration) { |b| b.link(title: "Administration") }

      action(:main_menu) { |p| p.main_menu_link.click }
      action(:provide_feedback) { |b| b.link(title: "Provide Feedback").click }
      action(:administration) { |p| p.administration.click }
    end
  end
end

```

Next, you create classes for the individual pages in your web site. These classes should have BasePage as their superclass, and should declare any of the relevant methods defined in the BasePage class.

```ruby
class Home < BasePage

  # This allows the header elements to be defined once
  # in the BasePage class and then reused throughout your web pages...
  header_elements

  expected_element :title # When the Home class is instantiated (using the Foundry),
                          # the script will ensure that the :title element is present
                          # on the page before the script continues

  # Now you define elements that are specific to your Home page...
  element(:title) { |b| b.h3(id: "title") }
  # and on and on...

end
```

Once you've got a bunch of classes set up for your site's various pages, you're going to want to create "data objects" to represent what goes into those pages. For this, you'll use the module DataFactory. Your data classes should follow this basic structure:

```ruby
class YourDataObject

  include DataFactory

  # Define all the things you need to test about your data object.
  # These are some example attributes...
  attr_accessor :title, :id, :link, :status, :description

  # Put any attributes here that you don't want to always have to define explicitly...
  DEFAULTS = {
      :title=>"My Data Title",
      :description=>"My Data's Description"
      # ...
  }

  # Your data object has to know about Watir's browser object, so it's passed to it here, along
  # with a hash containing all the attributes you want the data object to have
  def initialize(browser, opts={})
    @browser = browser

    # The set_options line combines the DEFAULTS
    # with any options you passed explicitly,
    # then turns all the contents of the options
    # Hash into YourDataObject's class instance variables
    set_options(DEFAULTS.merge(opts))

    requires @id # This line allows you to specify any class instance variables that must
                 # be explicitly defined for the data object
  end

  # Now define a bunch of methods that are relevant to your data object.
  # In general these methods will follow the CRUD design pattern

  def create
    # Your code here...
  end

  def view
    # Your code here...
  end

  def edit opts={}
    # Your code here...
    update_options(opts) # This updates all your class instance variables
                         # with any new values specified by the opts Hash.
  end

  def remove
    # Your code here...
  end

end
```

Now you have your basic infrastructure in place, and you can start writing your test cases using these classes.

```ruby
include Foundry # Gives you access to the methods that instantiate your Page and Data classes

# First, make the data object you're going to use for testing...
@my_thing = make YourDataObject :id=>"identifier", :description=>"It's lovely."

# Now, create the data in your site...
@my_thing.create

on MyPage do |page|
  page.title.set "Bla bla"
  # Very contrived example. TestFactory was made to be test-framework-agnostic. You should be using your favorite verification framework here:
  page.description==@my_thing.description ? puts "Passed" : puts "Failed"
end
```

Notice
------

Copyright 2013 rSmart, Inc., Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

[http://www.osedu.org/licenses/ECL-2.0](http://www.osedu.org/licenses/ECL-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.