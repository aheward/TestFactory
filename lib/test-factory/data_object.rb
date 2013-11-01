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

# The Superclass for all of your data objects.
class DataObject

  include Foundry
  include DataFactory

  # Since Data Objects are not "Marshallable", and they generally
  # contain lots of types of data in their instance variables,
  # we have this method. This will create and return a 'deep copy' of
  # the data object as well as any and all nested data objects
  # and collections it contains.
  #
  # Please note that this method will fail if you are putting
  # Data Objects into Arrays or Hashes instead
  # of into Collection classes
  #
  def data_object_copy
    opts = {}
    self.instance_variables.each do |var|
      key = var.to_s.gsub('@','').to_sym
      orig_val = instance_variable_get var
      opts[key] = case
                    when orig_val.kind_of?(CollectionsFactory)
                      orig_val.copy
                    when orig_val.instance_of?(Array) || orig_val.instance_of?(Hash)
                      Marshal::load(Marshal.dump(orig_val))
                    when orig_val.kind_of?(DataObject)
                      orig_val.data_object_copy
                    else
                      orig_val
                  end
    end
    self.class.new(@browser, opts)
  end

end