# Provides a set of tools used to create your Data Object classes.
module DataFactory

  # Add this to the bottom of your Data Object's initialize method.
  # Converts the contents of the hash into the class's instance variables.
  # @param hash [Hash] Contains all options required for creating the needed Data Object
  def set_options(hash)
    hash.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
  alias update_options set_options

  # Items passed to this method are checked to ensure that the associated class instance variable
  # is not nil. If it is, the script is aborted and an error is thrown, describing what information
  # the Data Object requires before the script can run.
  # @param elements [Array] the list of items that are required.
  #
  # @example
  #
  #   requires @site, @assignment
  #
  def requires(*elements)
    elements.each do |inst_var|
      raise "You've neglected to define a required variable for the #{self}." if inst_var==nil
    end
  end

  # Transform for use with data object instance variables
  # that refer to checkboxes or radio buttons. Instead of returning a boolean value, it returns
  # the symbols :set or :clear -- This can be useful because those symbols can then in turn
  # be passed directly as methods for updating or validating the checkbox later.
  #
  # @param checkbox [Watir::CheckBox] The checkbox on the page that you want to inspect
  def checkbox_setting(checkbox)
    checkbox.set? ? :set : :clear
  end
  alias radio_setting checkbox_setting

  # Use this method in your data object class for select list boxes that will have
  # default values you may be interested in. The method will either set the select
  # box to the value specified, or, if no value exists for the given variable in your
  # data object, it will get the value from the UI and set the data object's
  # variable to that value. Note that this only supports select lists that allow
  # a single selection.
  #
  # @example
  #
  #   @num_resubmissions = get_or_set(@num_resubmissions, page.num_resubmissions)
  def get_or_select(var, select_list)
    if var==nil
      select_list.selected_options[0].text
    else
      select_list.select var
    end
  end

end