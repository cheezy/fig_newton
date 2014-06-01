# -*- encoding: utf-8 -*-
require File.expand_path('../lib/fig_newton/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeff Morgan", "Steve Jackson"]
  gem.email         = ["jeff.morgan@leandog.com", "steve.jackson@leandogsoftware.com"]
  gem.license       = 'MIT'
  gem.description   = %q{Provides a simple mechanism to maintain and use different configurations stored in yml files.}
  gem.summary       = %q{Provides a simple mechanism to maintain and use different configurations stored in yml files.}
  gem.homepage      = "http://github.com/cheezy/fig_newton"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "fig_newton"
  gem.require_paths = ["lib"]
  gem.version       = FigNewton::VERSION
  
  gem.add_dependency 'yml_reader', '>= 0.3'
  
  gem.add_development_dependency 'rspec', '>= 2.12.0'
  gem.add_development_dependency 'cucumber', '>= 1.2.0'
end
