<div align="left">
  <a href="https://github.com/juanroldan1989/shaken_not_stirred"><img src="https://static1.fashionbeans.com/wp-content/uploads/2019/03/martinimain.jpg" alt="shaken_not_stirred ruby logo" /></a>
</div>

# ShakenNotStirred
[![Gem Version](https://badge.fury.io/rb/shaken_not_stirred.svg)](https://badge.fury.io/rb/shaken_not_stirred)
[![Code Climate](https://codeclimate.com/github/juanroldan1989/shaken_not_stirred/badges/gpa.svg)](https://codeclimate.com/github/juanroldan1989/shaken_not_stirred)
[![Build Status](https://travis-ci.org/juanroldan1989/shaken_not_stirred.svg?branch=master)](https://travis-ci.org/juanroldan1989/shaken_not_stirred)
[![Coverage Status](https://coveralls.io/repos/github/juanroldan1989/shaken_not_stirred/badge.svg?branch=master)](https://coveralls.io/github/juanroldan1989/shaken_not_stirred?branch=master)
[![Downloads](http://ruby-gem-downloads-badge.herokuapp.com/shaken_not_stirred/0.1.3?type=total&color=brightgreen)](https://rubygems.org/gems/shaken_not_stirred)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
<!-- [![Dependency Status](https://gemnasium.com/badges/github.com/juanroldan1989/shaken_not_stirred.svg)](https://gemnasium.com/github.com/juanroldan1989/shaken_not_stirred) -->

Ruby client for **Cocktails API**

Docs [here](https://juanroldan.com.ar/cocktails-api-docs)

[Example app](https://juanroldan.com.ar/cocktails-api-landing)

## Features

* Providing developers with THE best dataset of cocktails & drinks from all over the world.
* Search through well known cocktails by `name`, `description`, `ingredients`, `categories`, `timing`, `rating` and more.
* Intuitive API interface navigation.
* URL generation process fully tested when applying filters for each request.
* API integration tests recorded and fully tested using [VCR](https://github.com/vcr/vcr) gem: fast tests (first HTTP request is real and it's response is stored for future runs), deterministic (tests will continue to pass, even if you are offline, or API goes down for maintenance) and accurate (responses will contain the same headers and body you get from a real request).

## Installation

Install the gem by running:

```ruby
gem install shaken_not_stirred
```

or put it in your Gemfile and run `bundle install`:

```ruby
gem "shaken_not_stirred", "~> 0.0.1"
```

## 1. Usage

All `Free`, `Basic`, `Advanced` and `Premium` plans available [here](https://juanroldan.com.ar/cocktails-api-landing)

Once completed this quick [form](https://docs.google.com/forms/d/e/1FAIpQLSeavfLgmnF2haKsaNlp8hYA4DSqdwb1ZMg5Xse7a-mFW4bZIg/viewform) the API Key will be sent to you by Juan Roldan (`juanroldan1989@gmail.com`)

Setup the API Key within an initializer:

```ruby
# shaken_not_stirred_initializer.rb

ShakenNotStirred.configure do |config|
  config.api_key = "abcd1234"
end
```

Create a new filter instance like so:

```ruby
filter = ShakenNotStirred.new
```

then call API methods, for instance, to fetch well known cocktails with `rum` as ingredient:

```ruby
filter.by_ingredients(["rum"])
```

or cocktails containing `brown` within their names:

```ruby
filter.by_name(["brown"])
```
