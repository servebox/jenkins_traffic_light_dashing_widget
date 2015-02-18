require 'net/http'
require 'json'

JENKINS_HOST = 'your_host'
PATH = 'your_path'
USERNAME = 'your_username'
PASSWORD = 'your_password'
SSL_ENABLED = true
PORT = 'your_port'

COLORS = {
  'blue'=>:green,
  'yellow'=>:green,
  'red'=>:red,
  'blue_anime'=>:orange,
  'yellow_anime'=>:orange,
  'red_anime'=>:orange
}

SCHEDULER.every '5s', :first_in => 0 do |job|
  status = :green
  actual = pull
  if actual == :red
    status = :red
  elsif actual == :orange && @previous != :green
    status = :orange
  end
  @previous = status
  send_event('jenkins', { status: status})
end

def fetch_response
  connection = ::Net::HTTP.new(JENKINS_HOST, PORT)
  connection.use_ssl = SSL_ENABLED
  request = Net::HTTP::Get.new(PATH, {'Accept'=>'*'})
  request.basic_auth USERNAME, PASSWORD
  connection.request(request)
end

def handle_response(body)
  json = JSON.parse(body)
  status = :green
  json['jobs'].each do |job|
    if COLORS.keys.include?(job['color'])
      status = prioritize(to_status(job['color']), status)
    end
  end
  status
end

def to_status(color)
  COLORS[color]
end

def prioritize(current_status, former_status)
  [:red, :orange].each do |status|
    return status if status == former_status
  end
  current_status
end

def pull
  response = fetch_response
  case response
  when Net::HTTPSuccess
    handle_response(response.body)
  when Net::HTTPRedirection
    puts "The request has been redirected to #{response['location']}"
    :red
  else
    puts "The request has failed #{response.error}"
    :red
  end
rescue Exception => e
  puts "Unable to fetch data : #{e.message}"
  :red
end