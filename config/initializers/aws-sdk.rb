# S3
AWS::S3.new(
  access_key_id: Rails.application.secrets[:s3]['access_key_id'],
  secret_access_key: Rails.application.secrets[:s3]['secret_access_key'])


AWS::Rails.add_action_mailer_delivery_method(:ses, {
    access_key_id: 'AKIAIIZUHZAMMOZFHLGA',
    access_key_secret: 'Aljf7UCs4An1JH8zzgsGfJfCtdBckUH2rzSpF9wyYGzB'
  })
