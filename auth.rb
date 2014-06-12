require 'sinatra'

set :bind, '0.0.0.0'
enable :logging

class Resource

  attr_accessor :type, :name, :permission

  def initialize
    @permission = {}
  end
end

class UserPermission

  attr_accessor :username, :password, :vhost, :resource

  def initialize(username, password)
    @username = username
    @password = password
    @resource = {}
  end

  def auth?(params)
    params[:username] == username && params[:password] == password
  end

  def vhost?(params)
    params[:vhost] == vhost
  end

  def resource?(params)
    r = resource[params[:name]]
    r && params[:resource] == r.type &&
      r.permission[params[:permission]]
  end
end

h = {}
resource1 = Resource.new
resource1.type = 'queue'
resource1.name = 'mqtt-subscription-client1Device1Queueqos1'
resource1.permission['configure'] = true
resource1.permission['read'] = true
resource1.permission['write'] = true

resource2 = Resource.new
resource2.type = 'exchange'
resource2.name = 'vaildChat'
resource2.permission['read'] = true

user = UserPermission.new('test', 'test')
user.vhost = '/'

user.resource[resource1.name] = resource1
user.resource[resource2.name] = resource2

h[user.username] = user

get '/auth/user' do
  user = h[params[:username]]

  if user && (user.auth? params)
    'allow'
  else
    'deny'
  end
end

get '/auth/vhost' do
  user = h[params[:username]]

  if user && (user.vhost? params)
    'allow'
  else
    'deny'
  end
end

get '/auth/resource' do
  user = h[params[:username]]

  if user && (user.resource? params)
    'allow'
  else
    'deny'
  end
end
