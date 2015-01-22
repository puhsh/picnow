ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  access_key_id: Rails.application.secrets[:ses]['access_key_id'],
  secret_access_key: Rails.application.secrets[:ses]['secret_access_key']
