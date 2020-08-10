require "m2api/version"
require 'uri'
require 'net/http'
require 'json'
require 'time'
require 'logger'

module M2api
  Models = %w(base product customer order coupon sales_rule category cart stock_item)
  @@mutex = Mutex.new
  def self.connect host=nil, user_name=nil, password=nil
    raise ArgumentError, "no host specified" unless host
    raise ArgumentError, "no user_name specified" unless user_name
    raise ArgumentError, "no password specified" unless password
    Base.adapter = Adapter.new host, user_name, password
  end

  def self.with connection
    raise ArgumentError, "no connection specified" unless connection
    @@mutex.synchronize do
      old_connection = M2api::Base.adapter
      begin
        M2api::Base.adapter = connection
        yield
      ensure
        M2api::Base.adapter = old_connection
      end
    end
  end

  def self.logger= logger
    @@logger = logger
  end

  def self.logger
    @@logger ||= Logger.new STDOUT, {:level => Logger::INFO}
  end

  def self.log_level= level
    new_log_level = case level
    when :debug then Logger::DEBUG
    when :info  then Logger::INFO
    when :warn then Logger::WARN
    when :error then Logger::ERROR
    when :fatal then Logger::FATAL
    else
      raise ArgumentError, "invalid log_level"
    end
    self.logger= Logger.new STDOUT, {:level => new_log_level}
  end

  def self.default_page_size
    @@default_page_size ||= 20
  end

  def self.default_page_size= page_size
    @@default_page_size = page_size
  end

  def self.models
    Models.map do |model_file_name|
      model_file_name
      .split('_')
      .map(&:capitalize)
      .join
    end
  end
end

require_relative 'connection.rb'
require_relative 'adapter.rb'
require_relative 'filter.rb'
require_relative 'dataset.rb'
require_relative 'util/validator.rb'

M2api::Models.each do |file_name|
  require_relative("model/#{file_name}.rb")
end
