# Keypic

It just client fot Keypic API http://ws.keypic.com/?op=help

## Installation

Add this line to your application's Gemfile:

    gem 'keypic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install keypic

## Configuration

    Keypic.configure do |config|
      config.endpoint = "http://ws.keypic.com"
      config.form_id = "secret_token_here"
    end

## Usage

    @keypic = Keypic::Proxy.new(env)
    
    @keypic.token

    @keypic.valid?({email: "", message: "", name: ""})

You can provide a numeric value (%):

    @keypic.spam?({email: "", message: "", name: ""}, 90)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
