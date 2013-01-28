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

  # Your data object has to know about Watir's browser object, so it's passed to it here, along
  # with a hash containing all the attributes you want the data object to have
  def initialize(browser, opts={})
    @browser = browser

    # Put any attributes here that you don't want to always have to define explicitly...
    defaults = {
      :title=>"My Data Title",
      :description=>"My Data's Description"
      # ...
    }

    # The set_options line combines the defaults
    # with any options you passed explicitly in opts,
    # then turns all the contents of the options
    # Hash into YourDataObject's class instance variables
    set_options(defaults.merge(opts))

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

Design Pattern
--------------

The TestFactory was written assuming that the following rules would be followed, to the maximum extent practical. Any code that does not follow these rules is probably not DRY.

1.  Page Classes contain methods relating to interactions with page elements only--meaning the getting or setting of values, or the clicking of links or buttons. Any more complicated page interactions are handled in the Data Object classes, or in the test step definitions.
2.  Data Objects represent definable data structure entities in the system being tested. As data, they fit into the [CRUD Model](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) and thus have methods that correspond to those basic functions.
3.  Data Objects have a single method for each of the CRUD functions, and additional custom methods are avoided without compelling arguments for their inclusion in the class.
4.  When editing Data Objects, first the data in the system under test is updated, then the data object's instance variables--using `set_options`.
5.  Navigation within the system under test is handled conditionally inside the Data Object methods unless there are specific reasons to explicitly navigate in a step definition.
6.  Specifying non-default test variables for data objects is done using key/value hash pairs, as follows:
    ```ruby
    # During object creation, following the name of the class
    @data_object = make DataObject, :attrib1 => "Custom Value 1", :attrib2 => "Custom Value 2" # etc...

    # When an object is edited (Ruby v1.9.3 Hash syntax optional)
    @data_object.edit attrib1: "Updated Value 1", attrib2: "Updated Value 2"

    ```
7.  Updates to a data object's instance variables is handled *only* by the `set_options` method, *not* explicitly.
    ```ruby
    # This is allowed
    def edit opts={}
      #...
      page.element.fit opts[:value]
      #...
      update_options(opts)
    end

    # This is not
    def edit opts={}
      #...
      page.element.fit opts[:value]
      #...
      @value=opts[:value] unless @value==opts[:value]
    end
    ```
8.  The setting of random values for select lists in a data object is determined by passing the symbol `:random` in the instance variable or as the value in the key/value pair passed in an `#edit` method's `opts` parameter. The `#create` and `#edit` methods will handle the necessary logic. The purpose is to prevent the need for custom randomizing CRUD methods in the data object.
9.  See the gem_ext.rb file's discussion of the Watir `#fit` method for additional design pattern rules to follow.

Notice
------

Copyright 2013 rSmart, Inc., Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

[http://www.osedu.org/licenses/ECL-2.0](http://www.osedu.org/licenses/ECL-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.