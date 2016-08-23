class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def zipcode_options
    APITalker.new.get_zips[0..-2].map do |hsh|
      hsh["business_postal_code"][0..4].to_i
    end.reject{|i| i == 0}.uniq
  end
end
