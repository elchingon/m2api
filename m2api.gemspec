lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "m2api/version"

Gem::Specification.new do |spec|
  spec.name          = "m2api"
  spec.version       = M2api::VERSION
  spec.authors       = ["Alexii Carey"]
  spec.email         = ["ciegoproductions@gmail.com"]

  spec.summary       = %q{Ruby Magento 2 API Wrapper.}
  spec.description   = %q{Provides a simple Ruby Interface to interact with the Magento 2 API. Initial commit adapted from https://github.com/Arkad82x/magentwo }
  spec.homepage      = "https://github.com/elchingon/m2api.git"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "https://github.com/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/elchingon/m2api.git"
  spec.metadata["changelog_uri"] = "https://github.com/elchingon/m2api.git"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.4"
end
