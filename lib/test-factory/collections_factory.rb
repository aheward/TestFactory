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
  def self.contains klass

    # Creates a method called "add" that will create the specified data
    # object and then add it as an item in the collection.
    #
    # Note that it's assumed that the target data object will have a
    # create method defined. If not, this will not work properly.
    define_method 'add' do |opts|
      element = klass.new @browser, opts
      element.create
      self << element
    end

  end

end

class CollectionFactory < CollectionsFactory
  # Just an alias class name.
end