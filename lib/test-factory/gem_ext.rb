module Watir
  module UserEditable

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
    def fit(str_or_rx)
      select_by :text, str_or_rx unless str_or_rx==nil
    end
  end

end