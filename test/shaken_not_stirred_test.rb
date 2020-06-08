require "test_helper"

describe ShakenNotStirred do
  describe ".configure" do
    before do
      ShakenNotStirred.configure { |config| config.api_key = "abc123" }
    end

    it "should set main class with api_key" do
      ShakenNotStirred.configuration.api_key.must_equal "abc123"
    end
  end

  before do
    @filter = ShakenNotStirred.new
  end

  it "should not have any filter applied" do
    @filter.filters.must_equal({})
  end

  it "should allow to see current URL" do
    @filter.url.must_equal "#{ShakenNotStirred::BASE_URL}/cocktails?"
  end

  describe "#by_name" do
    it "should contain 'name' param inside URL" do
      @filter.by_name("mojito")
      @filter.url.must_include "name=mojito"
    end
  end

  describe "#by_description" do
    it "should contain 'description' param inside URL" do
      @filter.by_description("classic drink for a perfect night")
      @filter.url.must_include "description=classic drink for a perfect night"
    end
  end

  describe "#by_ingredients" do
    describe "filtering by a single ingredient" do
      it "should contain 'ingredients' param inside URL" do
        @filter.by_ingredients("rum")
        @filter.url.must_include "ingredients[]=rum"
      end
    end

    describe "filtering by multiple ingredients" do
      it "should contain 'ingredients' param inside URL" do
        @filter.by_ingredients("rum,tequila")
        @filter.url.must_include "ingredients[]=rum,tequila"
      end
    end
  end

  describe "#by_categories" do
    describe "filtering by a single category" do
      it "should contain 'categories' param inside URL" do
        @filter.by_categories("cocktails with rum")
        @filter.url.must_include "categories[]=cocktails with rum"
      end
    end

    describe "filtering by multiple categories" do
      it "should contain 'categories' param inside URL" do
        @filter.by_categories("classics,cocktails with rum")
        @filter.url.must_include "categories[]=classics,cocktails with rum"
      end
    end
  end

  describe "#by_timing" do
    it "should contain 'timing' param inside URL" do
      @filter.by_timing("before dinner")
      @filter.url.must_include "timing=before dinner"
    end
  end

  describe "#by_iba" do
    context "with string value" do
      it "should contain 'iba' param inside URL" do
        @filter.by_iba("true")
        @filter.url.must_include "iba=true"
      end
    end

    context "with boolean value" do
      it "should contain 'iba' param inside URL" do
        @filter.by_iba(true)
        @filter.url.must_include "iba=true"
      end
    end
  end

  describe "#by_rating" do
    it "should contain 'rating' param inside URL" do
      @filter.by_rating(5)
      @filter.url.must_include "rating=5"
    end
  end

  describe "#by_multiple" do
    it "should contain 'multiple' param inside URL" do
      @filter.by_multiple("cocktail")
      @filter.url.must_include "multiple=cocktail"
    end
  end

  describe "#by_page" do
    it "should contain 'page' param inside URL" do
      @filter.by_page(2)
      @filter.url.must_include "page=2"
    end
  end

  describe "#by_random" do
    it "should default 'random' param to '1' when no value is provided" do
      @filter.by_random
      @filter.url.must_include "random=1"
    end

    it "should contain 'random' param inside URL" do
      @filter.by_random(5)
      @filter.url.must_include "random=5"
    end
  end

  describe "#results" do

    describe "with valid api_key" do
      before do
        ShakenNotStirred.configure do |config|
          config.api_key = "valid_api_key"
        end
      end

      it "should return an array of 'Cocktail' JSON objects" do
      end
    end

    describe "with invalid api_key" do
      before do
        ShakenNotStirred.configure do |config|
          config.api_key = "invalid_api_key"
        end
      end

      it "should return error message" do
      end
    end
  end
end
