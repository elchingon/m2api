# M2api

Provides a simple Ruby Interface to interact with the Magento 2 API. 
Initial commit adapted from Arkad82x's Magentwo gem. https://github.com/Arkad82x/magentwo 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'm2api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install m2api

## Usage

## How to connect to your magento 2 shop
When only using one connection simply type. The MAgento API Integration Access_token is optional which will skip the request for an admin request_token
```
  M2api.connect "http://example.com", "user_name", "password", "integration_access_token" 
```
When using multiple connections at once you can save the result of `M2api.connect` and use the `M2api.with` method
```
  connection1 = M2api.connect "http://example1.com", "user_name", "password"
  connection2 = M2api.connect "http://example2.com", "user_name", "password", "integration_access_token"
  
  M2api.with (connection1) do
    #do things in the context of connection1
  end
  M2api.with (connection2) do
    #do things in the context of connection2
  end
```

## How to use
In M2api you interact with the API using Models. These are named according the the REST-API specifications of Magento 2
The basic functionality is the same for all Models. For products some simple requests would look like this

```
M2api::Product.all #fetches all Products
M2api::Product.first #fetches the first product
M2api::Product.count #returns the number of available products
M2api::Product.fields #returns an array of productfields
```

## Filtering
You can filter requests to search for specific elements
Here are some examples

Look for all customers whose firstname is Foobar
```
M2api::Customer.filter(:firstname => "Foobar").all
```

Look for all customers whose id is not 42
```
M2api::Customer.exclude(:id => 42).all
```

You can also combine these
```
M2api::Customer.filter(:firstname => "Foobar").exclude(:id => 42).all
```
The `filter` and `exclude` methods can also be used to filter for a set. To Request all Customers whose firstname is either Foo or Bar you could write
```
M2api::Customer.filter(:firstname => ["Foo", "bar"]).all
```

Look for all Products whose name includes the word "Computer"
```
M2api::Product.like(:name => "%Computer%").all
```

Compare using `gt`, `gteq`, `lt` or `lteq`. These methods do not seem to work with dates, please use `from` and `to` when e.g. trying to fetch all Products that changed within a certain period.
```
M2api::Product.lt(:price => 42).all
M2api::Product.gt(:id => 1337).first
```

Compare using `from` and `to`, you may also use both to specify a range.
```
M2api::Product.from(:updated_at => Time.new(2019, 1, 1).all
M2api::Product.to(:created_at => Time.new(2019, 2, 1).all
```

All of these filter-functions can be chained as needed

## Select
If you know which fields you are interested in you can speed up the fetching process by only requesting these fields
```
M2api::Product.filter(...).select(:id, :sku).all
```

## Pagination
On default the pagesize is set to 20, you can change this with
```
M2api.default_page_size=42
```

The pagesize can also be set on the fly
To request page 2 with a pagesize of 100 simply write the following. The second paramter is optional
```
M2api::Product.exclude(:name => "foobar").page(2, 100).all
```

To iterate threw all the pages use `each_page`. Again the pagesize parameter is optional
```
M2api::Product.each_page(512) do |page|
  p page
end
```
You may also want to fetch all pages of products that match a certain criteria
```
M2api::Product.from(:updated_at => my_last_sync_value).each_page(512) do |page|
  p page
end
```

## Order
By default the results are ordered as Magento2 "thinks" its best. At any place you may add the `order_by` to sepcify this to your liking. If you skip the `ASC/DESC` argument, `ASC` will be set.
```
M2api::Product.order_by(:id, "ASC").all
M2api::Product.order_by(:id, "DESC").all
```

## Updates
To update Models back to Magento 2 use the `save` method
This switches the first and last name of the Customer Foo Bar
```
customer = M2api::Customer.filter(:first_name => "Foo", :last_name => "Bar").first
customer.firstname = "Bar"
customer.lastname = "Foo"
customer.save
```

## Delete
To delete a Model use the `delete` method
```
product = M2api::Product.first
product.delete
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/m2api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the M2api project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/m2api/blob/master/CODE_OF_CONDUCT.md).
