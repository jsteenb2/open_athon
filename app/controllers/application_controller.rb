class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def zipcode_options
    APITalker.new.get_zips[0..-2].map do |hsh|
      hsh["business_postal_code"][0..4].to_i
    end.reject{|i| i == 0}.uniq
  end

  def in_zipcode(zipcode)
    Food.results_by_zip(zipcode).map do |restaurant|
      food = Food.new(zipcode: zipcode) unless restaurant.nil?
      restaurant.each do |key, value|
        food.send("#{key}=".to_sym, value)
      end
      food.save
    end
    Food.where(zipcode: zipcode).order(avg_score: :desc)
  end
end
