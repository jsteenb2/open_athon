class FoodsController < ApplicationController
  def index
    zipcode = params[:food][:zipcode]
    @foods = in_zipcode(zipcode.to_i)
  end

  def show
    @food = Food.find(params[:id])
  end

  private

    def white_listed_food_params
      params.require(:food).permit(:zipcode)
    end
end
