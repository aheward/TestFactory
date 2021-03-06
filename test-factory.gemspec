spec = Gem::Specification.new do |s|
  s.name = 'test-factory'
  s.version = '0.5.4'
  s.summary = %q{rSmart's framework for creating automated testing scripts}
  s.description = %q{This gem provides a set of modules and methods to help quickly and DRYly create a test automation framework using Ruby and Watir.}
  s.files = Dir.glob("**/**/**")
  s.test_files = Dir.glob("test/*test_rb")
  s.authors = ['Abraham Heward']
  s.email = %w{aheward@rsmart.com}
  s.homepage = 'https://github.com/rSmart'
  s.add_dependency 'watir', '>= 6.0.0'
  s.required_ruby_version = '>= 2.0.0'
end
