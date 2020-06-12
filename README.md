<img src="https://media.giphy.com/media/zd1VtTAjLRHNe/giphy.gif" width="100%" />

# ShakenNotStirred
[![Gem Version](https://badge.fury.io/rb/shaken_not_stirred.svg)](https://badge.fury.io/rb/shaken_not_stirred)
[![Code Climate](https://codeclimate.com/github/juanroldan1989/shaken_not_stirred/badges/gpa.svg)](https://codeclimate.com/github/juanroldan1989/shaken_not_stirred)
[![Downloads](http://ruby-gem-downloads-badge.herokuapp.com/shaken_not_stirred/0.0.7?type=total&color=brightgreen)](https://rubygems.org/gems/shaken_not_stirred)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
<!-- [![Build Status](https://travis-ci.com/juanroldan1989/shaken_not_stirred.svg?branch=master)](https://travis-ci.com/juanroldan1989/shaken_not_stirred) -->
<!-- [![Coverage Status](https://coveralls.io/repos/github/juanroldan1989/shaken_not_stirred/badge.svg?branch=master)](https://coveralls.io/github/juanroldan1989/shaken_not_stirred?branch=master) -->

Ruby client for [Cocktails API](https://cocktailsapi.xyz)

<!-- API Docs [here](https://juanroldan.com.ar/cocktails-api-docs) -->

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

All `Free`, `Basic`, `Advanced` and `Premium` plans available [here](https://cocktailsapi.xyz)

Once completed this quick [form](https://docs.google.com/forms/d/12Ofvx3wg3fIwiS2u41JAv5CNtIExjenU7KVpqyIwMi8/viewform) the API Key will be sent to you by Juan Roldan (`juanroldan1989@gmail.com`)

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


### `Cocktails` endpoint (Library vs. REST)

To fetch cocktails with `ginger` on its name:

```ruby
filter.by_name("ginger")
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?name=ginger" -H "Authorization: Token token=your_api_key"
```

To fetch cocktails with `amazing` on its description:

```ruby
filter.by_description("amazing")
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?description=amazing" -H "Authorization: Token token=your_api_key"
```

To fetch cocktails with `rum` on their ingredients:

```ruby
filter.by_ingredients(["rum"])
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?ingredients[]=rum" -H "Authorization: Token token=your_api_key"

# cocktails with `rum` OR `gin` within their ingredients
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?ingredients[]=rum,gin" -H "Authorization: Token token=your_api_key"

# cocktails with `tequila` AND `vodka` within their ingredients
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?ingredients_only[]=tequila,vodka" -H "Authorization: Token token=your_api_key"
```

To fetch cocktails with `classic` on their categories:

```ruby
filter.by_categories(["classic"])
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?categories[]=classic" -H "Authorization: Token token=your_api_key"

# cocktails with `drinks` OR `inventions` within their categories
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?categories[]=drinks,inventions" -H "Authorization: Token token=your_api_key"

# cocktails with `inventions` AND `brandy` within their categories
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?categories_only[]=inventions,brandy" -H "Authorization: Token token=your_api_key"
```

To fetch cocktails with `dinner` on their timing:

```ruby
filter.by_timing("dinner")
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?timing=dinner" -H "Authorization: Token token=your_api_key"
```

To fetch cocktails that belong to the `International Bartender Association`:

```ruby
filter.by_iba("true")
# OR
filter.by_iba(true)
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?iba=true" -H "Authorization: Token token=your_api_key"
```

To fetch cocktails that don't belong to the `International Bartender Association`:

```ruby
filter.by_iba("false")
# OR 
filter.by_iba(false)
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?iba=false" -H "Authorization: Token token=your_api_key"
```

To fetch cocktails that contain `ice` on many fields:

```ruby
filter.by_multiple("ice")
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?multiple=ice" -H "Authorization: Token token=your_api_key"
```

PS: fields searched by are: `name`, `description`, `ingredients`, `categories` & `timing`.

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

```ruby
# get a random cocktail on every request
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?random=1" -H "Authorization: Token token=your_api_key"

# get 2 random cocktails on every request
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?random=2" -H "Authorization: Token token=your_api_key"

# get N random cocktails on every request
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?random=n" -H "Authorization: Token token=your_api_key"
```

#### All filters are chainable

To fetch cocktails that:

- contain `classic` on their categories **AND**
- belong to the `International Bartender Association` **AND**
- contain `rum` on their ingredients

```ruby
filter = ShakenNotStirred.new

filter.by_categories(["classic"]).by_iba(true).by_ingredients(["rum"])
```

Once applied all the filters you need, make the API call to get the quotes:

```ruby
filter.results
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?categories[]=classic&iba=true&ingredients[]=rum" -H "Authorization: Token token=your_api_key"
```

### `Categories` endpoint

Cocktails API also provides an endpoint with all `categories` available to search by.

```ruby
filter = ShakenNotStirred.new

filter.categories

filter.results
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/categories" -H "Authorization: Token token=your_api_key"
```

### `Ingredients` endpoint

Cocktails API also provides an endpoint with all `ingredients` available to search by.

```ruby
filter = ShakenNotStirred.new

filter.ingredients

filter.results
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/ingredients" -H "Authorization: Token token=your_api_key"
```

### Pagination

Results returned per page: 20.

Pagination behavior is present in all 3 endpoints

#### Cocktails

```ruby
filter = ShakenNotStirred.new

# fetch `cocktail` results from page `2`
filter.by_page(2)

filter.results
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/cocktails?page=2" -H "Authorization: Token token=your_api_key"
```


#### Categories

```ruby
filter = ShakenNotStirred.new

# fetch `category` results from page `4`
filter.categories.by_page(4)

filter.results
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/categories?page=4" -H "Authorization: Token token=your_api_key"
```

#### Ingredients

```ruby
filter = ShakenNotStirred.new

# fetch `ingredient` results from page `5`
filter.ingredients.by_page(5)

filter.results
```

```ruby
$ curl "http://api-cocktails.herokuapp.com/api/v1/ingredients?page=5" -H "Authorization: Token token=your_api_key"
```

## 2. Implementation
Setting up this gem to work is really easy. Even more if you use `has_scope` gem:

```ruby
class CocktailsController < ApplicationController

  has_scope :by_name,        as: :name
  has_scope :by_rating,      as: :rating
  has_scope :by_ingredients, as: :ingredients, type: :array
  has_scope :by_categories,  as: :categories, type: :array

  helper_method :collection

  def index
  end

  private

  def collection
    @collection ||= cocktails_filter.results
  end

  def cocktails_filter
    @cocktails_filter ||= apply_scopes(filter)
  end

  def filter
    @filter ||= ShakenNotStirred.new
  end
end
```

## 3. Response
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

## 4. Development

Questions or problems? Please post them on the [issue tracker](https://github.com/juanroldan1989/shaken_not_stirred/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests are passing by running `bundle` and `rake`.

## 5. Copyright

Copyright © 2020 Juan Roldan. See [LICENSE.txt](https://github.com/juanroldan1989/shaken_not_stirred/blob/master/LICENSE.txt) for further details.
