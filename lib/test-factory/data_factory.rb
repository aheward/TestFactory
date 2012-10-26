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
  # requires :site :assignment
  #
  def requires(*elements)
    elements.each do |inst_var|
      raise "You must explicitly define the #{inst_var} variable for the #{self}." if inst_var==nil
    end
  end

  # Transform for use with data object instance variables
  # that refer to checkboxes or radio buttons.
  # @param checkbox [Watir::CheckBox] The checkbox on the page that you want to inspect
  # @returns :set or :clear
  def checkbox_setting(checkbox)
    checkbox.set? ? :set : :clear
  end
  alias radio_setting checkbox_setting

end