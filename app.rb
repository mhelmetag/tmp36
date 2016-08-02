require 'json'
require 'net/http'
require 'openssl'

require 'sinatra'

PARTICLE_API = 'https://api.particle.io/v1/devices/'

get '/' do
  device_id = ENV['DEVICE_ID']
  access_token = ENV['ACCESS_TOKEN']

  uri = URI.parse(PARTICLE_API + "#{device_id}/tempC/?access_token=#{access_token}")
  puts uri
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  response = http.get(uri.request_uri)

  puts response.code
  if response.code == '200'
    puts response.body
    body = JSON.parse(response.body)
    result = body['result']
    temp_c = result.to_i.round(2)
    temp_f = ((temp_c * 1.8) + 32).round(2)

    erb :index, locals: { temp_c: temp_c, temp_f: temp_f }
  end
end
