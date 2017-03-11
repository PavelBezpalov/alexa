server '139.59.133.227', user: fetch(:user).to_s, roles: %w(app db web), primary: true
set :nginx_server_name, 'fop.everlabs.com'
