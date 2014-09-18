require 'spec_helper'

describe V1::UsersController do
  include Devise::TestHelpers

  describe "#create" do
    it 'does not need an access token when creating a user' do
      post :create, { user: { username: "test", password: "12345678", phone_number: '2145555555', email: 'test@test.local' }}, format: :json
      expect(response).to be_success
    end
  end
end
