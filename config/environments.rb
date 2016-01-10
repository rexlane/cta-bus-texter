@environment = ENV['RACK_ENV'] || 'development'
@dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection @dbconfig[@environment]

# configure :development do
#   db = URI.parse(ENV['DATABASE_URL'])

#   ActiveRecord::Base.establish_connection(
#       :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
#       :host     => db.host,
#       :username => db.user,
#       :password => db.password,
#       :database => db.path[1..-1],
#       :encoding => 'utf8'
#   )
# end
