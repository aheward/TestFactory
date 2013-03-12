# Provides a set of tools used to create your Data Object classes.
module DataFactory

  # Add this to the bottom of your Data Object's initialize method.
  # Converts the contents of the hash into the class's instance variables.
  # @param hash [Hash] Contains all options required for creating the needed Data Object
  #
  def set_options(hash)
    hash.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
  alias update_options set_options

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
  #
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

  # Transform for use with data object instance variables
  # that refer to checkboxes or radio buttons. Instead of returning a boolean value, it returns
  # the symbols :set or :clear -- This can be useful because those symbols can then in turn
  # be passed directly as methods for updating or validating the checkbox later.
  #
  # @param checkbox [Watir::CheckBox] The checkbox on the page that you want to inspect
  #
  def checkbox_setting(checkbox)
    checkbox.set? ? :set : :clear
  end
  alias radio_setting checkbox_setting

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
  # Enter: #get_or_select!
  #
  # Assuming you just want to store the default value, then your
  # Data Object's instance variable for the field will--initially--be
  # nil. In that case, #get_or_select! will grab the select list's
  # current value and store it in your instance variable.
  #
  # On the other hand, if you want to update that field with your
  # custom value, then your instance variable will not be nil, so
  # #get_or_select! will take that value and use it to update the
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
  #
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
  #
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

end