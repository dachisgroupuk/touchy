require "rubygems"
require "bundler"
Bundler.setup

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'touchy'

require 'active_record'
require 'database_cleaner'
require 'ruby-debug'
require 'factory_girl'
FactoryGirl.find_definitions

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'development.db')

# Fixtures
class User < ActiveRecord::Base; end
ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS users")
ActiveRecord::Base.connection.create_table(:users) do |t|
    t.string :username
    t.timestamps
end

class BlogPost < ActiveRecord::Base
  acts_as_touchy
end
ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS blog_posts")
ActiveRecord::Base.connection.create_table(:blog_posts) do |t|
    t.string :title
    t.timestamps
end

# support
class Time
  class << self
    alias_method :old_now, :now
    def now
      old_now.round(0)
    end
  end
end

RSpec.configure do |config|
  # Prettyfying
  config.color_enabled  = true
  config.formatter      = 'documentation'
  
  # Cleaning database
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    
    Thread.current[:touchy] = {}
  end
  
  # Enable factory girl shorthand (e.g. use create(:model) instead of FactoryGirl.create(:model))
  config.include FactoryGirl::Syntax::Methods
end
