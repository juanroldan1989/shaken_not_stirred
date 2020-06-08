require "configuration"
require "httparty"

class ShakenNotStirred
  include HTTParty

  # testing purposes
  # BASE_URL = "http://localhost:3000/api/v1".freeze
  BASE_URL = "https://api-cocktails.herokuapp.com/api/v1".freeze

  attr_accessor :filters, :resource

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new

    yield(configuration)
  end

  def initialize
    @filters = {}
    @resource = "cocktails"
  end

  def by_name(query)
    apply_filter "name", query

    self
  end

  def by_description(query)
    apply_filter "description", query

    self
  end

  # "rum" | ["orange", "rum"]
  def by_ingredients(query)
    # "OR" behavior by default
    apply_filter_list "ingredients", query

    self
  end

  # "classic" | ["classic", "new_era"]
  def by_categories(query)
    # "OR" behavior by default
    apply_filter_list "categories", query

    self
  end

  def by_timing(query)
    apply_filter "timing", query

    self
  end

  def by_iba(query)
    apply_filter "iba", query

    self
  end

  def by_rating(query)
    apply_filter "rating", query

    self
  end

  def by_multiple(query)
    apply_filter "multiple", query

    self
  end

  def by_page(page)
    apply_filter "page", page

    self
  end

  def by_random(count=1)
    apply_filter "random", count

    self
  end

  def categories
    @resource = "categories"
    @results = []

    self
  end

  def ingredients
    @resource = "ingredients"
    @results = []

    self
  end

  def results
    @results = HTTParty.get(url, headers: headers)
  end

  def url
    "#{BASE_URL}/#{@resource}?#{get_filters}"
  end

  private

  def api_key
    @api_key ||= ShakenNotStirred.configuration.api_key
  end

  def apply_filter(filter_name, value)
    filters[filter_name] = value
  end

  def apply_filter_list(filter_name, value)
    # categories[]=classic,new_era
    filters["#{filter_name}[]"] = [value].flatten.join(",")
  end

  def get_filters
    filters.map { |k,v| "#{k}=#{v}" }.join("&")
  end

  def headers
    { "Authorization"=>"Token token=\"#{api_key}\"" }
  end
end
