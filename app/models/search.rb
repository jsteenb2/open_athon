require 'api_talker'

class Search < ApplicationRecord
  validates_length_of :zipcode, in: 5..8

  def zips
    APITalker.new.get_zips[0..-2].map do |hsh|
      hsh["business_postal_code"][0..4].to_i
    end.reject{|i| i == 0}.uniq
  end
end
