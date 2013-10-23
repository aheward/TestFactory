rSmart's TestFactory Gem
=========================

Overview
--------

This gem contains the basic framework for [dryly](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself) creating test scripts for the web site that needs testing.

Use it to abstract away from the underlying [Watir](http://www.watir.com) code and create your own [DSL](http://en.wikipedia.org/wiki/Domain_specific_language).

With TestFactory you have the ability to...

1. Easily instantiate page classes (described below) in a consistent and readable manner
2. Concisely describe elements on a page, keeping it DRY by avoiding repetition of element
   identifiers that may (will) change
3. Provide higher-level methods that use customizable (and default) data, along with the
   page classes and elements, to perform user-oriented--i.e., behavioral--functions
   with minimal lines of code

Tremendous thanks is due to [Alister Scott](http://watirmelon.com), whose [custom page object code](https://github.com/alisterscott/wmf-custom-page-object) for the Wikimedia Foundation provided the inspiration for this gem.

Summary
-------

Using the TestFactory properly involves three distinct steps:

1. Creating page classes that contain references to the elements on your web page. For this
   you use the PageFactory class. Working on page classes requires that you have a strong
   command of Watir and basic skills with Ruby.
2. Creating "data objects" that utilize your page classes and elements to build methods that
   perform user-oriented tasks. For this you use the DataFactory module. Working on data
   objects requires you have good familiarity with Watir and strong Ruby skills.
3. Creating test scenarios using your favorite test framework (like Cucumber or Rspec) and
   your data objects. The methods in the Foundry class are useful here. Working at this
   level requires only basic skills with Ruby and Watir, but a strong command of your DSL
   (the thing you're building with TestFactory).

These three steps can all be accomplished by a single person. However, ideally, they should be done by three or four people, as the design philosophy of TestFactory allows for specialization:

 - A Watir specialist works on defining page elements and actions inside of page classes
 - A Ruby specialist uses the output of the Watir specialist to build the data objects and their helper methods, creating the DSL for the project
 - A non-programmer--say, a business analyst or a manual tester with domain expertise--writes test scenarios, in English
 - A more junior automation engineer translates the English into Ruby code, via the DSL created by the Ruby specialist (if you're using Cucumber, these would be your step definitions)

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
      element(:administration_link) { |b| b.link(title: "Administration") }

      action(:main_menu) { |p| p.main_menu_link.click }
      action(:provide_feedback) { |b| b.link(title: "Provide Feedback").click }
      action(:administration) { |p| p.administration_link.click }
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

    requires :id # This line allows you to specify any class instance variables that must
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

The TestFactory was written assuming the following guiding principles. Any code that does not
follow them probably [smells](http://en.wikipedia.org/wiki/Code_smell), and should be refactored.

*  Page Classes contain methods relating to interactions with page elements only--meaning
   the getting or setting of values, or the clicking of links or buttons. Any more
   complicated page interactions are handled in the Data Object classes, or in the test
   step definitions.
*  Data Objects represent definable data structure entities in the system being tested.
   As data, they fit into the [CRUD Model](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete)
   and thus have methods that correspond to those basic functions.
*  Data Objects have a single method for each of the CRUD functions, and additional
   custom methods are avoided, unless there are _compelling_ arguments for their inclusion in the class.
*  When a Data Object is executing its `edit` method, first the data in the
   system under test is updated, then the data object's instance variables
   are updated--using DataFactory's `set_options`.
*  Site navigation is handled using conditional methods (meaning they only navigate if
   necessary) inside the Data Object--and preferably inside the data object's CRUD methods
   themselves--unless there are specific reasons to explicitly navigate in a step
   definition. This keeps step definitions from being unnecessarily cluttered.
*  Specifying non-default test variables for data objects is done using key/value hash
   pairs that are parameters of the data object's CRUD methods. It is _not_
   done by explicitly assigning values to the instance variables. Examples:

```ruby
# During object creation, following the name of the class
@data_object = make DataObject, :attrib1 => "Custom Value 1", :attrib2 => "Custom Value 2" # etc...

# When an object is edited (using Ruby v1.9.3's Hash syntax is optional)
@data_object.edit attrib1: "Updated Value 1", attrib2: "Updated Value 2"

# This is frowned upon because it can easily lead to
# the data object and the data in the test site being
# out of sync, leading to a false negative test result:
@data_object.attrib1="Another Value"

```

*  Except in very rare cases, updates to a data object's instance variables should be handled *only* by the `set_options` method, *not* explicitly.

```ruby
# This is good
def edit opts={}
  #...
  page.element.fit opts[:value]
  #...
  update_options(opts)
end

# This is not good
def edit opts={}
  #...
  page.element.fit opts[:value]
  #...
  @value=opts[:value] unless @value==opts[:value]
end
```

*  The setting of random values for select lists in a data object is determined by passing
   the string '::random::' in the instance variable, or as the value in the key/value pair
   passed in an `#edit` method's `opts` parameter. The `#create` and `#edit` methods will
   handle the necessary logic. The purpose is to prevent the need for custom randomizing
   CRUD methods in the data object.
*  See the gem_ext.rb file's discussion of the Watir `#fit` method for additional
   design pattern rules to follow (If you're reading this on rubydoc.info then click the Watir module link)
*  Please make an effort to follow the [Ruby Style Guidelines](http://www.caliban.org/ruby/rubyguide.shtml#style).
