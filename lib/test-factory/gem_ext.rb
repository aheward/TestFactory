module Watir
  module UserEditable

    # Extends Watir's methods.
    # Use when the argument you are passing to a text field
    # may be nil, in which case you don't
    # want to do anything with the page element.
    def fit(*args)
      unless args==nil
        assert_exists
        assert_writable

        @element.clear
        @element.send_keys(*args)
      end
    end
  end

  class Select
    # Extends Watir's methods.
    # Use when the argument you are passing to a text field
    # may be nil, in which case you don't
    # want to do anything with the page element.
    def fit(str_or_rx)
      select_by :text, str_or_rx unless str_or_rx==nil
    end
  end

end