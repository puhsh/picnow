class V1::PasswordsController < Devise::PasswordsController
  include ApiResponses
  skip_before_filter :verify_authenticity_token, only: [:create], if: :json_request?
  respond_to :json

   def create
     self.resource = resource_class.send_reset_password_instructions(resource_params)

     if successfully_sent?(resource)
       render json: {}
     else
      unprocessable_entity!({meta: 'Invalid/unknown email'})
     end
   end
end
