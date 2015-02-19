require 'spec_helper'

describe GroupUser do
  it { should belong_to(:user) }
  it { should belong_to(:group) }
  it { should belong_to(:added_by_user) }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:group) { FactoryGirl.create(:group) }
  let!(:group_user) { FactoryGirl.create(:group_user, group: group, user: user) }
  let!(:group_user2) { FactoryGirl.build(:group_user, group: group, user: user2) }

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

  describe '.notify_user' do
    it 'notifies a user that they were added to a group' do
      expect(group_user2).to receive(:notify_user)
      group_user2.save
    end
  end
end
