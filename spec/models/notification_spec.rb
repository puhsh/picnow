require 'spec_helper'

describe Notification do
  it { should belong_to(:user) }
  it { should belong_to(:group) }
  it { should belong_to(:trigger) }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:group) { FactoryGirl.create(:group, admin: user) }
  let!(:group2) { FactoryGirl.create(:group, admin: user) }
  let!(:group_user) { FactoryGirl.create(:group_user, user: user, group: group) }
  let!(:notification) { FactoryGirl.create(:notification, user: user, group: group) }
  let!(:notification2) { FactoryGirl.create(:notification, user: user2, group: group) }
  let!(:notification3) { FactoryGirl.create(:notification, user: user, group: group2) }

  describe '.mark_all_as_read!' do
    it 'marks all notifications as read for a given user' do
      notification.mark_all_as_read!(user)
      expect(notification.reload).to be_read
      expect(notification3.reload).to be_read
    end

    it 'does not mark a notification as read for another user' do
      notification.mark_all_as_read!(user)
      expect(notification.reload).to be_read
      expect(notification2.reload).to_not be_read
    end

    it 'marks all notifications as read for a given group for a user' do
      notification.mark_all_as_read!(user, group)
      expect(notification.reload).to be_read
      expect(notification3.reload).to_not be_read
    end
  end

end
