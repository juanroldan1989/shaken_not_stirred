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

Ruby client for [Cocktails API](https://juanroldan.com.ar/cocktails-api-landing)

API Docs [here](https://juanroldan.com.ar/cocktails-api-docs)

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
gem "shaken_not_stirred", "~> 0.0.7"
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

then call API methods, for instance:


### `Cocktails` endpoint

To fetch cocktails with `ginger` on its name:

```ruby
filter.by_name("ginger")
```

To fetch cocktails with `amazing` on its description:

```ruby
filter.by_description("amazing")
```

To fetch cocktails with `rum` on their ingredients:

```ruby
filter.by_ingredients(["rum"])
```

To fetch cocktails with `classic` on their categories:

```ruby
filter.by_categories(["classic"])
```

To fetch cocktails with `dinner` on their timing:

```ruby
filter.by_timing("dinner")
```

To fetch cocktails that belong to the `International Bartender Association`:

```ruby
filter.by_iba("true")
filter.by_iba(true)
```

To fetch cocktails that don't belong to the `International Bartender Association`:

```ruby
filter.by_iba("false")
filter.by_iba(false)
```

To fetch cocktails that contain `ice` on many fields:

```ruby
filter.by_multiple("ice")

# fields included are: `name`, `description`, `ingredients`, `categories` & `timing`
```

To fetch cocktails randomnly:

```ruby
# get a random cocktail on every request
filter.by_random
filter.by_random(1) # same behavior as `by_random`

# get 2 random cocktails on every request
filter.by_random(2)

# get N random cocktails on every request
filter.by_random(n)
```

#### All filters are chainable

To fetch cocktails that:

- contain `classic` on their categories **AND**
- belong to the `International Bartender Association` **AND**
- contain `rum` on their ingredients

```ruby
filter = ShakenNotStirred.new

filter.by_categories(["classic"]).by_iba(true).by_ingredients(["rum"])

filter.results
```

Once applied all the filters you need, make the API call to get the quotes:

```ruby
filter.results
```

### `Categories` endpoint

Cocktails API also provides an endpoint with all `categories` available to search by.

```ruby
filter = ShakenNotStirred.new

filter.categories

filter.results
```

### `Ingredients` endpoint

Cocktails API also provides an endpoint with all `ingredients` available to search by.

```ruby
filter = ShakenNotStirred.new

filter.ingredients

filter.results
```

### Pagination

Pagination behavior is present in all 3 endpoints: `cocktails`, `categories` and `ingredients`.

```ruby
filter = ShakenNotStirred.new

# fetch `cocktail` results from page `2`
filter.by_page(2)

filter.results
```

```ruby
filter = ShakenNotStirred.new

# fetch `category` results from page `4`
filter.categories.by_page(4)

filter.results
```

```ruby
filter = ShakenNotStirred.new

# fetch `ingredient` results from page `5`
filter.ingredients.by_page(5)

filter.results
```

## 2. Response
The response format is JSON by default. Results are provided as an array of objects with the following structure:

<div align="left">
  <img src="https://ramshacklepantry.com/wp-content/uploads/2017/08/new_feature.jpg" width="375px" alt="shaken_not_stirred cocktails api" />
</div>

```ruby
filter = ShakenNotStirred.new
filter.by_name("mojito")
filter.results
=> [
  {
    "id": 174,
    "name": "Mojito",
    "description": "Mojito (Spanish: [moˈxito]) is a traditional Cuban highball. Traditionally, a mojito is a cocktail that consists of five ingredients: white rum, sugar (traditionally sugar cane juice), lime juice, soda water, and mint. Its combination of sweetness, citrus, and herbaceous mint flavors is intended to complement the rum, and has made the mojito a popular summer drink.When preparing a mojito, fresh lime juice is added to sugar (or to simple syrup) and mint leaves. The mixture is then gently mashed with a muddler. The mint leaves should only be bruised to release the essential oils and should not be shredded. Then rum is added and the mixture is briefly stirred to dissolve the sugar and to lift the mint leaves up from the bottom for better presentation. Finally, the drink is topped with crushed ice and sparkling soda water. Mint leaves and lime wedges are used to garnish the glass.  The mojito is one of the most famous rum-based highballs. There are several versions of the mojito.",
    "ingredients": [
      "4 cl white rum",
      "3 cl fresh lime juice",
      "6 sprigs of Mentha|mint",
      "2 teaspoons sugar (or 2 cl of sugar syrup)"
    ],
    "categories": [
      "Cuban cocktails",
      "Cocktails with white rum",
      "Cold drinks",
      "Cuban alcoholic drinks",
      "Articles containing video clips",
      "Cuban inventions",
      "Cocktails with lime juice",
      "Cocktails with carbonated water",
      "Mint drinks",
      "Contemporary classics"
    ],
    "preparation": "Muddler|Muddle mint leaves with sugar and lime juice. Add a splash of soda water and fill the glass with cracked ice. Pour the rum and top with soda water. Garnish with sprig of mint leaves and lemon slice. Serve with straw.",
    "served": "On the rocks",
    "standard_drinkware": "collins",
    "standard_garnish": "lime & mint",
    "timing": "All day",
    "iba": true, # belongs to `International Bartenders Association`
    "rating": 9,
    "image_thumb_url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKsDEZWJhQTVBt5y9u-2gQgLXAB9EuUE6u5krAVZ9tmuCbQwnpOGTvwDtEoA&s",
    "image_large_url": "https://ramshacklepantry.com/wp-content/uploads/2017/08/new_feature.jpg",
    "video_url": "https://www.youtube.com/watch?v=_9v34KLET0g"
  }
...
]
```

## 3. Development

Questions or problems? Please post them on the [issue tracker](https://github.com/juanroldan1989/shaken_not_stirred/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests are passing by running `bundle` and `rake`.

## 4. Copyright

Copyright © 2020 Juan Roldan. See [LICENSE.txt](https://github.com/juanroldan1989/shaken_not_stirred/blob/master/LICENSE.txt) for further details.
