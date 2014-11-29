namespace :notifications do
  task :install_certs => :environment do
    app = Rpush::Apns::App.new
    app.name = "pic_now_#{Rails.env}"
    app.certificate = File.read("config/certs/#{Rails.env}.pem")
    app.environment = Rails.env.production? ? "production" : "sandbox"
    # app.environment = "sandbox"
    app.password = nil
    app.connections = 1
    app.save!
  end

  task :install_certs_android => :environment do
    app = Rpush::Gcm::App.new
    app.name = "pic_now_#{Rails.env}_android"
    app.auth_key = "AIzaSyCWKWIqzZwOGBmrhecvZkP0ugel3HqB6us"
    app.connections = 1
    app.save!
  end
end
