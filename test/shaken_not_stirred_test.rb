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

  describe "#url" do
    describe "by default" do
      it "should allow to see default URL" do
        @filter.url.must_equal "#{ShakenNotStirred::BASE_URL}/cocktails?"
      end
    end
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
    describe "with string value" do
      it "should contain 'iba' param inside URL" do
        @filter.by_iba("true")
        @filter.url.must_include "iba=true"
      end
    end

    describe "with boolean value" do
      it "should contain 'iba' param inside URL" do
        @filter.by_iba(true)
        @filter.url.must_include "iba=true"
      end
    end
  end

  describe "#by_rating" do
    it "should contain 'rating' param inside URL" do
      @filter.by_rating(8)
      @filter.url.must_include "rating=8"
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
      @filter.by_random(4)
      @filter.url.must_include "random=4"
    end
  end

  describe "#categories" do
    it "should set URL properly" do
      @filter.categories
      @filter.url.must_equal "#{ShakenNotStirred::BASE_URL}/categories?"
    end
  end

  describe "#ingredients" do
    it "should set URL properly" do
      @filter.ingredients
      @filter.url.must_equal "#{ShakenNotStirred::BASE_URL}/ingredients?"
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
        VCR.use_cassette("cocktails_valid_api_key") do
          cocktails = @filter.by_name('vodka').results
          cocktail  = cocktails.first

          cocktail["name"].must_equal               "Vodka Martini"
          cocktail["description"].must_equal        "A vodka martini, also known as a vodkatini or kangaroo cocktail, is a cocktail made with vodka and vermouth, a variation of a martini. A vodka martini is made by combining vodka, dry vermouth and ice in a cocktail shaker or mixing glass. The ingredients are chilled, either by stirring or shaking, then strained and served \"straight up\" (without ice) in a chilled cocktail glass.  The drink may be garnished with an olive, a \"twist\" (a strip of lemon peel squeezed or twisted), capers, or cocktail onions (with the onion garnish specifically yielding a vodka Gibson). The vodka martini has become a common and popular cocktail. Some purists maintain that, while it is a perfectly fine drink, it is not a true martini; which is traditionally made with gin."
          cocktail["ingredients"].must_equal        ["6 cl (6 parts) vodka", "1 cl (1 parts) dry vermouth"]
          cocktail["categories"].must_equal         ["Cocktails with vodka"]
          cocktail["preparation"].must_equal        "Straight: Pour all ingredients into mixing glass with ice cubes. Shake well. Strain in chilled martini cocktail glass. Squeeze oil from lemon peel onto the drink, or garnish with olive."
          cocktail["served"].must_equal             "On the rocks"
          cocktail["standard_drinkware"].must_equal "cocktail"
          cocktail["standard_garnish"].must_equal   "olive (fruit)|Olive or lemon twist"
          cocktail["timing"].must_equal             "All day"
          cocktail["iba"].must_equal                false
          cocktail["rating"].must_equal             9
          cocktail["image_thumb_url"].must_equal    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Vodka_Martini%2C_Macaroni_Grill%2C_Dunwoody_GA.jpg/200px-Vodka_Martini%2C_Macaroni_Grill%2C_Dunwoody_GA.jpg"
          cocktail["image_large_url"].must_equal    "https://upload.wikimedia.org/wikipedia/commons/9/92/Vodka_Martini%2C_Macaroni_Grill%2C_Dunwoody_GA.jpg"
          cocktail["video_url"].must_equal          "https://www.youtube.com/watch?v=8SMZ_g044To"
        end
      end
    end

    describe "with invalid api_key" do
      before do
        ShakenNotStirred.configure do |config|
          config.api_key = "invalid_api_key"
        end
      end

      it "should return error message" do
        VCR.use_cassette("cocktails_invalid_api_key") do
          cocktails = @filter.results

          cocktails["status"].must_equal  "error"
          cocktails["message"].must_equal "Bad credentials"
        end
      end
    end
  end
end
