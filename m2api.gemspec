# -*- encoding: utf-8 -*-
# stub: m2api 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "m2api".freeze
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://github.com/", "changelog_uri" => "https://github.com/elchingon/m2api.git", "homepage_uri" => "https://github.com/elchingon/m2api.git", "source_code_uri" => "https://github.com/elchingon/m2api.git" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alexii Carey".freeze]
  s.bindir = "exe".freeze
  s.date = "2025-11-20"
  s.description = "Provides a simple Ruby Interface to interact with the Magento 2 API. Initial commit adapted from https://github.com/Arkad82x/magentwo ".freeze
  s.email = ["ciegoproductions@gmail.com".freeze]
  s.files = [".gitignore".freeze, ".rspec".freeze, ".ruby-gemset".freeze, ".ruby-version".freeze, ".travis.yml".freeze, "CODE_OF_CONDUCT.md".freeze, "Gemfile".freeze, "Gemfile.lock".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "bin/console".freeze, "bin/setup".freeze, "lib/adapter.rb".freeze, "lib/connection.rb".freeze, "lib/dataset.rb".freeze, "lib/filter.rb".freeze, "lib/m2api.rb".freeze, "lib/m2api/version.rb".freeze, "lib/model/attribute_set.rb".freeze, "lib/model/base.rb".freeze, "lib/model/cart.rb".freeze, "lib/model/category.rb".freeze, "lib/model/coupon.rb".freeze, "lib/model/customer.rb".freeze, "lib/model/order.rb".freeze, "lib/model/product.rb".freeze, "lib/model/product_attribute.rb".freeze, "lib/model/product_attribute_option.rb".freeze, "lib/model/sales_rule.rb".freeze, "lib/model/stock_item.rb".freeze, "lib/util/validator.rb".freeze, "m2api.gemspec".freeze]
  s.homepage = "https://github.com/elchingon/m2api.git".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.9".freeze
  s.summary = "Ruby Magento 2 API Wrapper.".freeze

  s.installed_by_version = "2.7.9" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.10.4"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.10.4"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.10.4"])
  end
end
