# SqlDumper

Add the ability to dump an model object to a sql insert by including SqlDumper
in the model and calling #to_sql.

## Installation

Add this line to your application's Gemfile:

    gem 'sql_dumper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sql_dumper

## Usage

### Add to Specific model:

    class User < ActiveRecord::Base
      include SqlDumper
    end

### Add to All ActiveRecord instances

    class ActiveRecord::Base
      include SqlDumper
    end

### Dumping object to sql

    User.new.to_sql
    User.new.to_sql(excluded_columns: [:foo])

## Contributing

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog