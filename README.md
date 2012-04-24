# Touchy

Touch an attribute of the Rails current user every time models are updated.

## Installation

Add this line to your application's Gemfile:

    gem 'touchy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install touchy

### Rails Migration

To generate the migration file in Rails, run:

    $ rails generate touchy

This will generate a file in your db/migrate/ folder. You will need to run rake db:migrate afterwards.

The migration will add a field called `last_active_at` to the `users` table, so make sure your database schema includes such a table.

## Usage

Add a call to `acts_as_touchy` to the models that should be monitored. Every time one of the models is created/updated/destroyed the `last_active_at` attribute of the current user will be updated with the current timestamp.

Note that the `updated_at` attribute for the current user *will not* be updated.

Example:

    class BlogPost < ActiveRecord::Base
      acts_as_touchy
    end

Every change to an instance of `BlogPost` will update the current user.

## Testing

Run:

    $ rspec

## Acknowledgements

This gem is based on a very similar functionality in the [`paper_trail` gem](https://github.com/airblade/paper_trail).
Although the code has been adapted to suit a different need, most of it comes directly from `paper_trail`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
