# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{four_bites_aes}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Percival"]
  s.date = %q{2009-12-09}
  s.description = %q{Useful for URL shortners and places where you don't want guessed ID's}
  s.email = %q{mark@mpercival.com}
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["README.markdown", "Rakefile", "VERSION", "examples/example.rb", "four_bites_aes.gemspec", "lib/four_bites_aes.rb", "spec/basic_spec.rb"]
  s.homepage = %q{http://github.com/markpercival/four_bites_aes}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Obsfuscate your ID's}
  s.test_files = ["spec/basic_spec.rb", "examples/example.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
