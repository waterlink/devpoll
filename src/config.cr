require "mysql_adapter"
require "uri"

if database_uri = ENV["DATABASE_URL"]?
  uri = URI.parse(database_uri)
  ENV["MYSQL_HOST"] = uri.host.to_s
  ENV["MYSQL_USER"] = uri.user.to_s
  ENV["MYSQL_PASSWORD"] = uri.password.to_s
  ENV["MYSQL_DATABASE"] = uri.path.to_s[1..-1]
  ENV["MYSQL_PORT"] = uri.port.to_s if uri.port
end

ActiveRecord::Registry.register_adapter("configured", MysqlAdapter::Adapter)
