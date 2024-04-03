require 'uri'
require 'net/http'
require 'json'

class EasyBrokerAPI
  def initialize
    @url = URI("https://api.stagingeb.com/v1/properties?page=1&limit=20")
    @http = Net::HTTP.new(@url.host, @url.port)
    @http.use_ssl = true
    @request = Net::HTTP::Get.new(@url)
    @request["accept"] = 'application/json'
    @request["X-Authorization"] = 'COLOCAR EL TOKEN SI NO: NO FNNCIONA'
  end

  def fetch_properties
    response = @http.request(@request)
    JSON.parse(response.read_body)
  end

  def extract_titles
    properties = fetch_properties
    properties['content'].map { |property| property['title'] }
  end
end

if __FILE__ == $PROGRAM_NAME
  api = EasyBrokerAPI.new
  titles = api.extract_titles
  titles.each { |title| puts title }
end
