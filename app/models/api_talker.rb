require 'soda/client'
require 'googlestaticmap'

class APITalker
  attr_reader :food_scores
  attr_accessor :zip

  SF_GOV_DOMAIN = "http://data.sfgov.org/"
  FOOD_INSPC_DATASET = "sipz-fjte"
  EVICTION_DATASET = "93gi-sfd2"
  PROP_TAX_DATASET = "fk72-cxc3"

  def initialize( zip = nil , start_year = 2015, end_year = 2016 )
    @zip = zip
    @start_year = start_year
    @end_year = end_year
    @client = SODA::Client.new({ domain: "data.sfgov.org", app_token: Rails.application.secrets.open_token })
  end

  def get_scores
    @food_scores = violations_per_restaraunt_year_range(@zip)
  end

  def food_inspection_request_high_risk
    @client.get(FOOD_INSPC_DATASET, {"$limit" => 1, "$where" => "business_postal_code = '94108'" ,:risk_category => "High Risk"})
  end

  def violations_per_restaraunt_year_range(zip, start_year = 2015, end_year = 2016)
    @client.get(FOOD_INSPC_DATASET, {
      "$select" => "business_id, business_name, risk_category, business_latitude, business_longitude, avg(inspection_score) AS avg_score, count(violation_id) AS violations",
      "$where" => "date_trunc_y(inspection_date) between '#{start_year}' and '#{end_year}' AND business_postal_code = '#{zip}'",
      "$having" => "avg_score > '0.0'",
      "$group" => "business_id, business_name, risk_category, business_latitude, business_longitude",
       "$order" => "avg_score DESC"
     }
    )
  end

  def descr_violation(bus_id)
    @client.get(FOOD_INSPC_DATASET, {
      "$select" => "violation_description" ,"$where" => "business_id = '#{bus_id}'"
      }
    )
  end

  def get_zips
    @client.get(FOOD_INSPC_DATASET, {
      "$select" => "business_postal_code",
      "$group" => "business_postal_code",
      "$order" => "business_postal_code"
      })
  end

end
