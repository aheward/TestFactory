class PageFactory

  def initialize browser, visit = false
    @browser = browser
    goto if visit
    expected_element if respond_to? :expected_element
    has_expected_title? if respond_to? :has_expected_title?
  end

  def method_missing sym, *args, &block
    @browser.send sym, *args, &block
  end

  class << self

    def page_url url
      define_method 'goto' do
        @browser.goto url
      end
    end

    def expected_element element_name, timeout=30
      define_method 'expected_element' do
        self.send(element_name).wait_until_present timeout
      end
    end

    def expected_title expected_title
      define_method 'has_expected_title?' do
        has_expected_title = expected_title.kind_of?(Regexp) ? expected_title =~ @browser.title : expected_title == @browser.title
        raise "Expected title '#{expected_title}' instead of '#{@browser.title}'" unless has_expected_title
      end
    end

    def element element_name
      raise "#{element_name} is being defined twice in #{self}!" if self.instance_methods.include?(element_name.to_sym)
      define_method element_name.to_s do
        yield self
      end
    end
    alias :value :element
    alias :thing :element

    def action method_name, &block
      define_method method_name.to_s do |*thing|
        Proc.new(&block).call *thing, self
      end
    end
    alias :pgmd :action

  end

end # PageMaker