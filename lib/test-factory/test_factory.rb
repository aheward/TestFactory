module TestFactory

  def self.binary_transform(var)
    case(var)
      when nil
        nil
      when /yes/i, /on/i, :set, true
        :set
      when /no/i, /off/i, :clear, false
        :clear
      else
        raise "The value of your DataObject's checkbox/radio ('#{var}') instance variable is not supported.\nPlease make sure the value conforms to one of the following patterns:\n\n - :set or :clear (Symbol)\n - 'yes', 'no', 'on', or 'off' (String; case insensitive)\n - true or false (Boolean)"
    end
  end

end