require 'spec_helper'

describe Photo do
  it { should belong_to(:user) }
  it { should have_many(:groups).through(:group_photos) }
  it { should have_many(:events) }
  it { should have_many(:notifications) }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:photo) { FactoryGirl.create(:photo, user: user) }
  let!(:group) { FactoryGirl.create(:group, admin: user) }
  let!(:group2) { FactoryGirl.create(:group, admin: user) }
  let!(:group_user) { FactoryGirl.create(:group_user, group: group, user: user) }
  let!(:group_user2) { FactoryGirl.create(:group_user, group: group, user: user2) }
  let!(:group_photo) { FactoryGirl.create(:group_photo, group: group, photo: photo) }


  describe '.user' do
    it 'is required' do
      photo.user = nil
      photo.save
      expect(photo).to_not be_valid
    end
  end

  describe '.touch_group_last_photo_sent_at' do 
    it 'sets the group\'s last photo sent at after a photo is created' do
      last_photo_sent_at = group.last_photo_sent_at
      photo.send(:touch_group_last_photo_sent_at)
      expect(group.reload.last_photo_sent_at).to_not eql(last_photo_sent_at)
    end
  end

  describe '.image_urls' do
    it 'returns a hash of image urls' do
      expect(photo.image_urls.class).to eql(Hash)
    end

    it 'has the correct sizes' do
      expect(photo.image_urls.keys).to include(:original)
      expect(photo.image_urls.keys).to include(:small)
      expect(photo.image_urls.keys).to include(:medium)
      expect(photo.image_urls.keys).to include(:large)
      expect(photo.image_urls.keys).to include(:thumbnail)
    end
  end

  describe '.notify_group_users' do
    it 'creates notifications when a photo is created and there are other people in the group' do
      photo.send(:notify_group_users)
      expect(photo.notifications).to_not be_empty
    end

    it 'does not create notifications when a photo is created and there is no one else in the group' do
      group_user2.destroy
      photo.send(:notify_group_users)
      expect(photo.notifications).to be_empty
    end

    it 'does not send a notification to the user who took the photo' do
      photo.send(:notify_group_users)
      expect(photo.notifications.map(&:user)).to_not include(user)
    end

    it 'does not send a notification to groups that did not receive the photo' do
      photo.send(:notify_group_users)
      expect(photo.notifications.map(&:group)).to_not include(group2)
    end

    it 'sets the notification trigger to the photo' do
      photo.send(:notify_group_users)
      expect(photo.notifications.map(&:trigger)).to include(photo)
    end
  end
end
