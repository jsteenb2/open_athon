class SearchesController < ApplicationController

  def index
    @zips = zipcode_options
  end

  def create
    white_listed_search_params
  end

  private

    def white_listed_search_params
      params.require(:search).permit(:zipcode)
    end
end
