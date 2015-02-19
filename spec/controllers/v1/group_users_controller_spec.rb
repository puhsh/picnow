require 'spec_helper'

describe V1::GroupUsersController do
  describe '#create' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }
    let!(:group) { FactoryGirl.create(:group, admin: user) }

    it 'sets who added the user propery' do
      sign_in user
      post :create, { user_id: user.id, group_id: group.id, user_ids: [user2.id] }
      expect(assigns[:group_users].first.added_by_user_id).to eql(user.id)
    end

    it 'returns an array of group users' do
      sign_in user
      post :create, { user_id: user.id, group_id: group.id, user_ids: [user2.id] }
      expect(assigns[:group_users]).to_not be_empty
    end

    it 'adds multiple users to the group based on an array of user ids' do
      sign_in user
      post :create, { user_id: user.id, group_id: group.id, user_ids: [user2.id] }
      expect(assigns[:group_users].map(&:user)).to include(user2)
    end

    it 'adds a single user to the group based on a single group user param' do
      sign_in user
      post :create, { user_id: user.id, group_id: group.id, group_user: { user_id: user2.id } }
      expect(assigns[:group_users].map(&:user)).to include(user2)
    end
  end
end
