require 'spec_helper'

describe V1::UsersController do
  include Devise::TestHelpers

  describe "#create" do
    it 'creates a user with just a username and password' do
      post :create, { user: { username: "test", password: "12345678" }}, format: :json
      expect(assigns[:user]).to be_valid
    end

    it 'does not need an access token when creating a user' do
      post :create, { user: { username: "test", password: "12345678" }}, format: :json
      expect(response).to be_success
    end
  end
end
