require 'spec_helper'

describe GroupUser do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:group) { FactoryGirl.create(:group) }
  let!(:group_user) { FactoryGirl.create(:group_user, group: group, user: user) } 

  describe ".group" do
    it 'is required' do
      group_user.group = nil
      group_user.save
      expect(group_user).to_not be_valid
    end
  end

  describe ".user" do
    it 'is required' do
      group_user.user = nil
      group_user.save
      expect(group_user).to_not be_valid
    end
  end
end
