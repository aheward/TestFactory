spec = Gem::Specification.new do |s|
  s.name = 'test-factory'
  s.version = '0.1.7'
  s.summary = %q{rSmart's framework for creating automated testing scripts}
  s.description = %q{This gem provides a set of modules and methods to help quickly and DRYly create a test automation framework using Ruby and Watir (or watir-webdriver).}
  s.files = Dir.glob("**/**/**")
  s.test_files = Dir.glob("test/*test_rb")
  s.authors = ["Abraham Heward"]
  s.email = %w{"aheward@rsmart.com"}
  s.homepage = 'https://github.com/rSmart'
  s.add_dependency 'watir-webdriver', '>= 0.6.1'
  s.required_ruby_version = '>= 1.9.2'
end