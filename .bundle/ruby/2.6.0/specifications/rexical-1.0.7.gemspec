# -*- encoding: utf-8 -*-
# stub: rexical 1.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "rexical".freeze
  s.version = "1.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Aaron Patterson".freeze]
  s.date = "2019-08-06"
  s.description = "Rexical is a lexical scanner generator that is used with\nRacc to generate Ruby programs.\nRexical is written in Ruby.".freeze
  s.email = ["aaronp@rubyforge.org".freeze]
  s.executables = ["rex".freeze]
  s.extra_rdoc_files = ["CHANGELOG.rdoc".freeze, "DOCUMENTATION.en.rdoc".freeze, "DOCUMENTATION.ja.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.files = ["CHANGELOG.rdoc".freeze, "DOCUMENTATION.en.rdoc".freeze, "DOCUMENTATION.ja.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "bin/rex".freeze]
  s.homepage = "http://github.com/tenderlove/rexical/tree/master".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Rexical is a lexical scanner generator that is used with Racc to generate Ruby programs".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.74.0"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
      s.add_development_dependency(%q<hoe>.freeze, ["~> 3.18"])
    else
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.74.0"])
      s.add_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
      s.add_dependency(%q<hoe>.freeze, ["~> 3.18"])
    end
  else
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.74.0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
    s.add_dependency(%q<hoe>.freeze, ["~> 3.18"])
  end
end
