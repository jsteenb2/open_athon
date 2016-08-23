require 'api_talker'

class Search < ApplicationRecord
  validates_length_of :zipcode, in: 5..8

  def zips
    APITalker.new.get_zips[0..-2].map do |hsh|
      hsh["business_postal_code"][0..4].to_i
    end.reject{|i| i == 0}.uniq
  end

  def self.map_food(foods)
    return if foods.nil?
    map = GoogleStaticMap.new
    foods.each do |food|
      next unless food.business_latitude && food.business_longitude && food.avg_score.to_i > 0
      if food.avg_score.to_i >= 92
        map.markers << gen_marker("blue", food)
      elsif food.avg_score.to_i >= 86
        map.markers << gen_marker("yellow", food)
      else
        map.markers << gen_marker("red", food)
      end
    end
    image = map.get_map
    map.url(:http)
  end
  # helper_method :map_food

  def self.map_a_food(food)
    return if food.nil?
    map = GoogleStaticMap.new
    if food.avg_score.to_i >= 92
      map.markers << gen_marker("blue", food)
    elsif food.avg_score.to_i >= 86
      map.markers << gen_marker("yellow", food)
    else
      map.markers << gen_marker("red", food)
    end
    image = map.get_map
    map.url(:http)
  end

  def self.gen_marker(color, food)
    MapMarker.new(:color => color, location: MapLocation.new(:latitude => food.business_latitude, :longitude => food.business_longitude ))
  end
end
