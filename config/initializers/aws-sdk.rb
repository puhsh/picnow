# General Config
AWS.config({
  access_key_id: '',
  access_key_secret: ''
})

# SES
AWS::Rails.add_action_mailer_delivery_method(:ses, {
  access_key_id: 'AKIAIIZUHZAMMOZFHLGA',
  access_key_secret: 'Aljf7UCs4An1JH8zzgsGfJfCtdBckUH2rzSpF9wyYGzB'
})
