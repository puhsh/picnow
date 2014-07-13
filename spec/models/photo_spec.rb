require 'spec_helper'

describe Photo do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:group) { FactoryGirl.create(:group) }
  let!(:group_user) { FactoryGirl.create(:group_user, group: group, user: user) } 
  let!(:photo) { FactoryGirl.create(:photo, user: user, group: group) }
  let!(:photo2) { FactoryGirl.build(:photo, user: user, group: group) }


  describe '.user' do
    it 'is required' do
      photo.user = nil
      photo.save
      expect(photo).to_not be_valid
    end
  end

  describe '.group' do
    it 'is required' do
      photo.group = nil
      photo.save
      expect(photo).to_not be_valid
    end
  end

  describe '.touch_group_last_photo_sent_at' do 
    it 'sets the group\'s last photo sent at after a photo is created' do
      photo2.save
      expect(group.reload.last_photo_sent_at).to eql(photo2.created_at)
    end
  end

  describe '.add_point' do
    it 'adds a point to the user' do
      expect(user.pic_now_count).to eql(1)
      photo2.save
      expect(user.pic_now_count).to eql(2)
    end
  end
end
