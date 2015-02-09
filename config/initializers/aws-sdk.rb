# General Config
AWS.config({
  access_key_id: '',
  access_key_secret: ''
})

# SES
AWS::Rails.add_action_mailer_delivery_method(:ses, {
  access_key_id: Rails.application.secrets[:ses]['access_key_id'],
  access_key_secret: Rails.application.secrets[:ses]['access_key_secret']
})
