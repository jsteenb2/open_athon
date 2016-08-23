require 'api_talker'

class Food < ApplicationRecord

  validates :business_id, uniqueness: true

  def self.results_by_zip(zipcode)
    APITalker.new(zip=zipcode).get_scores
  end

end
