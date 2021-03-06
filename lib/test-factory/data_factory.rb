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

# The Superclass for all of your data objects.
class DataFactory

  include Foundry
  extend Forwardable

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
                      begin
                        Marshal::load(Marshal.dump(orig_val))
                      rescue TypeError
                        raise %{\nKey: #{key.inspect}\nValue: #{orig_val.inspect}\nClass: #{orig_val.class}\n\nThe copying of the Data Object has thrown a TypeError,\nwhich means the object detailed above is not "Marshallable".\nThe most likely cause is that you have put\na Data Object inside an\nArray or Hash.\nIf possible, put the Data Object into a Collection.\n\n}
                      end
                    when orig_val.kind_of?(DataFactory)
                      orig_val.data_object_copy
                    else
                      orig_val
                  end
    end
    self.class.new(@browser, opts)
  end

  # Add this to the bottom of your Data Object's initialize method.
  # This method does 2 things:
  # 1) Converts the contents of the hash into the class's instance variables.
  # 2) Grabs the names of your collection class instance variables and stores
  #    them in an Array. This is to allow for the data object class to send
  #    any needed updates to its children. See #notify_coolections for more
  #    details.
  # @param hash [Hash] Contains all options required for creating the needed Data Object
  #
  def set_options(hash)
    @collections ||= []
    hash.each do |key, value|
      instance_variable_set("@#{key}", value)
      @collections << key if value.kind_of?(CollectionsFactory)
    end
  end
  alias update_options set_options

  # Use for setting a data object's class instance variable as a nested collection class.
  #
  # This method assumes your collection class name ends with "Collection". Therefore,
  # the string you pass in its parameter is the first part of the class name.
  #
  # E.g., your collection class is called "DataObjectCollection", so, inside your
  # parent object's defaults, you'd set the instance variable like this:
  #
  # @example
  #   data_objects: collection('DataObject')
  #
  def collection(name)
    Kernel.const_get("#{name}Collection").new(@browser)
  end

  # Items passed to this method are checked to ensure that the associated class instance variable
  # is not nil. If it is, the script is aborted and an error is thrown. Use symbols separated
  # by commas with this method. The symbol(s) should exactly match the name of the instance
  # variable that must not be empty.
  #
  # NOTE: Currently this is backwards compatible with prior versions, which took the instance
  # variables directly in the parameter. This backwards compatibility will be removed in
  # some future update of the gem.
  #
  # @param elements [Array] the list of items that are required.
  #
  # @example
  #   requires :site, :assignment, :document_id
  #
  def requires(*elements)
    elements.each do |inst_var|
      if inst_var.kind_of? Symbol
        string="@#{inst_var.to_s}"
        if instance_variable_get(string)==nil
          raise "You've neglected to define a required variable for your #{self.class}.\n\nPlease ensure you always specify a value for #{string} when you create the data object."
        end
      elsif inst_var.kind_of? String
        warn "<<<<WARNING!>>>>\n\nPlease update the requires method in your\n#{self.class} class to refer to symbols\ninstead of directly referencing the class'\ninstance variables.\n\n  Example:\n\n    This...\n      requires @document_id\n    Should be updated to...\n      requires :document_id\n\nIn future versions of TestFactory the 'requires'\nmethod will only support symbolized references\nto the instance variables. The backwards\ncompatibility will be removed.\n\n<<<<WARNING!>>>>"
      elsif inst_var==nil
        raise "You've neglected to define a required variable for your #{self.class}.\n\n<<<<WARNING!>>>>\n\nPlease update the requires method in your #{self} class to refer to symbols\ninstead of directly referencing the class'\ninstance variables.\n\nIn future versions of TestFactory the 'requires' method\nwill only support symbolized references\nto the instance variables. The backwards\ncompatibility will be removed.\n\n<<<<WARNING!>>>>"
      end
    end
  end

  # A shortcut method for filling out fields on a page. The
  # method's first parameter is the page class that contains the fields
  # you want to fill out. That is followed by the list of field name(s)
  # (as Symbols).
  #
  # This method has a number of requirements:
  #
  # 1) The field name and the instance variable name in your data object
  # must be identical. For this reason, this method can only
  # be used in your data objects' create methods.
  #
  # 2) Your checkbox and radio button data object instance variables are
  # either +nil+, +:set+, or +:clear+. Any other values will not be handled
  # correctly.
  #
  # 3) Since the listed fields get filled out in random order, be sure that
  # this is okay in the context of your page--in other words, if field A
  # needs to be specified before field B then having them both in your
  # fill_out step would be inappropriate. If you need a specific order,
  # use #ordered_fill instead.
  #
  # 4) This method supports text fields, select lists, check boxes, and
  # radio buttons, but only if their element definitions don't take a
  # parameter. Please use the +#fill_out_item+ with elements that do need
  # a parameter defined.
  #
  # @example
  #   on PageClass do |page|
  #     fill_out page, :text_field_name, :radio_name, :select_list_name, :checkbox_name
  #   end
  #
  def fill_out(page, *fields)
    f_o_i true, nil, page, *fields
  end

  # Use when you need to specify the order that the fields should be
  # updated.
  #
  # @example
  #   on PageClass do |page|
  #     ordered_fill page, :text_field_name, :radio_name, :select_list_name, :checkbox_name
  #   end
  #
  def ordered_fill(page, *fields)
    f_o_i false, nil, page, *fields
  end

  # Same as #fill_out, but used with methods that take a
  # parameter to identify the target element...
  #
  # @example
  #   on PageClass do |page|
  #     fill_out_item 'Joe Schmoe', page, :text_field_name, :radio_name, :select_list_name, :checkbox_name
  #   end
  #
  def fill_out_item(name, page, *fields)
    f_o_i true, name, page, *fields
  end

  # Use instead of #fill_out_item when you need to
  # specify the order that the fields should be
  # updated.
  #
  # @example
  #   on PageClass do |page|
  #     ordered_item_fill 'Joe Schmoe', page, :text_field_name, :radio_name, :select_list_name, :checkbox_name
  #   end
  #
  def ordered_item_fill(name, page, *fields)
    f_o_i false, name, page, *fields
  end

  # Equivalent to #ordered_fill, except that it's used
  # in the context of a Data Object's #edit method(s). As such, it
  # requires the #edit method's hash to be passed as its own
  # first parameter.
  #
  # @example
  #   on PageClass do |page|
  #     edit_fields opts, page, :text_field_name, :radio_name, :select_list_name, :checkbox_name
  #   end
  #
  def edit_fields(opts, page, *fields)
    edit_item_fields opts, nil, page, *fields
  end

  # Equivalent to #ordered_item_fill, except that it's used
  # in the context of a Data Object's #edit method(s). As such, it
  # requires the #edit method's hash to be passed as its own
  # first parameter.
  #
  # @example
  #   on PageClass do |page|
  #     edit_item_fields opts, 'Joe Schmoe', page, :text_field_name, :radio_name, :select_list_name, :checkbox_name
  #   end
  #
  def edit_item_fields(opts, name, page, *fields)
    parse_fields(opts, name, page, *fields)
  end

  # This is a specialized method for use with any select list boxes
  # that exist in the site you're testing and will contain
  # unpredictable default values.
  #
  # Admittedly, this is a bit unusual, but one example would be
  # be a "due date" list that changes its default selection based
  # on today's date. You're going to want to do one of two things
  # with that select list:
  #
  # 1) Retrieve and store the select list's value
  # 2) Specify a custom value to select
  #
  # Enter: +#get_or_select!+
  #
  # Assuming you just want to store the default value, then your
  # Data Object's instance variable for the field will--initially--be
  # nil. In that case, +#get_or_select!+ will grab the select list's
  # current value and store it in your instance variable.
  #
  # On the other hand, if you want to update that field with your
  # custom value, then your instance variable will not be nil, so
  # +#get_or_select!+ will take that value and use it to update the
  # select list.
  #
  # Note that this method *only* works with select lists that take
  # a single selection. Multi-selects are not supported.
  #
  # Also note that the first parameter is *not* the instance variable
  # you need to use/update. It is a *symbol* that otherwise matches
  # the instance variable.
  #
  # @param inst_var_sym [Symbol] A Symbol that _must_ match the instance variable that
  # will either be set or be used to update the page
  # @param select_list [Watir::Select] The relevant select list element on the page
  #
  # @example
  #   get_or_select! :@num_resubmissions, page.num_resubmissions
  #
  def get_or_select!(inst_var_sym, select_list)
    value = instance_variable_get inst_var_sym
    if value==nil
      instance_variable_set inst_var_sym, select_list.selected_options[0].text
    else
      select_list.select value
    end
  end

  # This method accomplishes the same thing as #get_or_select! but
  # is used specifically when the instance variable being used/updated
  # is a Hash and you only need to update one of its key/value pairs.
  #
  # Pay close attention to the syntax differences between
  # this method and #get_or_select!
  #
  # First, note that the returned value of this method must be explicitly
  # passed to the relevant key in the Hash instance variable. Note also that, unlike
  # #get_or_select!, this method does *not* take a symbolized representation
  # of the instance variable.
  #
  # @example
  #   @open[:day] = get_or_select(@open[:day], page.open_day)
  #
  def get_or_select(hash_inst_var, select_list)
    if hash_inst_var==nil
      select_list.selected_options[0].text
    else
      select_list.select hash_inst_var
      hash_inst_var
    end
  end

  # Define this method in your data object when
  # it has a parent, and that parent
  # may periodically need to send
  # it updated information about itself.
  #
  def update_from_parent(update)
    raise %{
    This method must be implemented in your data object
    class if you plan to pass updates from a
    parent object to the members of its
    collections.
           }
  end

  # =======
  private
  # =======

  # Do not use this method directly.
  #
  def f_o_i(shuffle, name, page, *fields)
    shuffle ? fields.shuffle! : fields
    parse_fields(nil, name, page, *fields)
  end

  # Do not use this method directly.
  #
  def parse_fields(opts, name, page, *fields)
    fields.each do |field|
      lmnt = page.send(*[field, name].compact)
      var = opts.nil? ? instance_variable_get("@#{field}") : opts[field]
      lmnt.class.to_s == 'Watir::Select' ? lmnt.pick!(var) : lmnt.fit(var)
    end
  end

  # Use this method in conjunction with your nested
  # collection classes. The collections will notify
  # their members about the passed parameters.
  #
  # Note: You must write a custom #update_from_parent
  # method in your data object that will know what to
  # do with the parameter(s) passed to it.
  #
  def notify_collections *updates
    @collections.each {|coll| instance_variable_get("@#{coll}").notify_members *updates }
  end

end