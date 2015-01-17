# S3
AWS::S3.new(
  access_key_id: Rails.application.secrets[:s3]['access_key_id'],
  secret_access_key: Rails.application.secrets[:s3]['secret_access_key'])

# SES
AWS::SimpleEmailService.new(
  access_key_id: Rails.application.secrets[:ses]['access_key_id'],
  secret_access_key: Rails.application.secrets[:ses]['secret_access_key'])
