uri = URI.parse("redis://localhost:6379/")

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }