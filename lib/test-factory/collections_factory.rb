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
#
# =================
# CollectionsFactory
# =================
#
# Use this as the superclass for your data object collection classes.
class CollectionsFactory < Array

  def initialize(browser)
    @browser=browser
  end

  # Defines the class of objects contained in the collection
  #
  def self.contains klass

    # Creates a method called "add" that will create the specified data
    # object and then add it as an item in the collection.
    #
    # Note that it's assumed that the target data object will have a
    # create method defined. If not, this will not work properly.
    define_method 'add' do |opts={}|
      element = klass.new @browser, opts
      element.create
      self << element
    end

  end

  # Makes a "deep copy" of the Collection. See the #data_object_copy
  # method description in the DataObject class for more information.
  #
  def copy
    new_collection = self.class.new(@browser)
    self.each do |item|
      new_collection << item.data_object_copy
    end
    new_collection
  end

  # Used in conjunction with the Parent object containing
  # the collection.
  #
  # The parent sends updated information to the collection(s)
  # using #notify_collections
  #
  def notify_members *updates
    self.each { |member| member.update_from_parent *updates }
  end

end

# Just an alias class name.
class CollectionFactory < CollectionsFactory; end