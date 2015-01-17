AWS::SimpleEmailService.new(
  access_key_id: Rails.application.secrets[:ses]['access_key_id'],
  secret_access_key: Rails.application.secrets[:ses]['secret_access_key'])
