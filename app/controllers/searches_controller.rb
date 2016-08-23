class SearchesController < ApplicationController

  def index
    @food = Food.new
    @zips = zipcode_options
  end

  def create
    @results = food_results(white_listed_search_params)
  end

  private

    def white_listed_search_params
      params.require(:search).permit(:zipcode)
    end
end
