namespace :notifications do
  task :install_certs => :environment do
    app = Rpush::Apns::App.new
    app.name = "pic_now_#{Rails.env}"
    app.certificate = File.read("config/certs/development.pem")
    # app.environment = Rails.env.production? ? "production" : "sandbox"
    app.environment = "sandbox"
    app.password = nil
    app.connections = 1
    app.save!
  end
end
