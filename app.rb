require 'json'
require 'net/http'
require 'openssl'

require 'sinatra'

PARTICLE_API = 'https://api.particle.io/v1/devices/'

get '/' do
 erb :index
end

get '/temps' do
  content_type :json

  device_id = ENV['DEVICE_ID']
  access_token = ENV['ACCESS_TOKEN']

  uri = URI.parse(PARTICLE_API + "#{device_id}/tempC/?access_token=#{access_token}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  response = http.get(uri.request_uri)

  # puts response.code
  if response.code == '200'
    # puts response.body
    body = JSON.parse(response.body)
    result = body['result']
    temp_c = result.to_f.round(2)
    temp_f = ((temp_c * 1.8) + 32).round(2)

    {tempC: temp_c.to_s, tempF: temp_f.to_s}.to_json
  else
    halt 500, {error: 'something went wrong'}.to_json
  end
end
