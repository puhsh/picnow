require 'spec_helper'

describe User do
  it { should have_one(:text_verification) }

  let!(:user) { FactoryGirl.build(:user) }
  let!(:user2) { FactoryGirl.build(:user) }

  describe '.username' do
    it 'is required' do
      user.username = nil
      user.save
      expect(user).to_not be_valid
    end

    it 'must be unique' do
      user.save
      user2.username = user.reload.username
      user2.save
      expect(user2).to_not be_valid
    end
  end

  describe '.email' do
    it 'is required' do
      user.email =  nil
      user.save
      expect(user).to_not be_valid
    end

    it 'must be unique' do
      user.save
      user2.email = user.reload.email
      user2.save
      expect(user2).to_not be_valid
    end
  end

  describe '.phone_number' do
    it 'is required' do
      user.phone_number =  nil
      user.save
      expect(user).to_not be_valid
    end

    it 'must be unique' do
      user.save
      user2.phone_number = user.reload.phone_number
      user2.save
      expect(user2).to_not be_valid
    end
  end

  describe '.date_of_birth' do
    it 'is not required' do
      user.date_of_birth = nil
      user.save
      expect(user).to be_valid
    end
  end

  describe '.valid_age?' do
    it 'is true if a user is over 13' do
      user.save
      expect(user).to be_valid_age
    end

    it 'is false if the user is under 13' do
      user.date_of_birth = 10.years.ago
      user.save
      expect(user.reload).to_not be_valid_age
    end
  end

  describe '.generate_text_verification!' do
    it 'generates a TextVerification record' do
      user.save
      expect(user.reload.text_verification).to_not be_nil
    end

    it 'sets a code for a TextVerification record' do
      user.save
      expect(user.reload.text_verification.code).to_not be_nil
    end
  end

  describe '.generate_access_token!' do
    it 'generates a AccessToken record' do
      user.save
      user.generate_access_token!
      expect(user.reload.access_token).to_not be_nil
    end
  end

  describe '.verified_account?' do
    it 'returns true if the user is verified and has a phone number' do
      user.verified = true
      user.save
      expect(user).to be_verified_account
    end

    it 'returns false if the user is verified but does not have phone number' do
      user.verified = true
      user.phone_number = nil
      user.save
      expect(user).to_not be_verified_account
    end

    it 'returns false if the user is not verified but have phone number' do
      user.verified = false
      user.save
      expect(user).to_not be_verified_account
    end

    it 'returns false if the user is not verified and does not have phone number' do
      user.verified = false
      user.phone_number = nil
      user.save
      expect(user).to_not be_verified_account
    end

    it 'is false by default' do
      user.save
      expect(user).to_not be_verified_account
    end
  end

  describe '.show_progress_bar?' do
    it 'is always true' do
      user.save
      expect(user.show_progress_bar?).to be_true
    end
  end

  describe '.give_first_point' do
    it 'gives the user 99 points for uploading their avatar aka their first selfie' do
      user.save
      expect(user.reload.pic_now_count).to eql(0)
      user.avatar_file_name = "test.png"
      user.save
      expect(user.reload.pic_now_count).to eql(99)
    end
  end

  describe '.text_verification_cache' do
    it 'returns a TextVerification object, assuming from cache' do
      user.save
      expect(user.text_verification_cache).to eql(user.text_verification)
    end
  end

  describe '.access_token_cache' do
    it 'returns a AccessToken object, assuming from cache' do
      user.save
      user.generate_access_token!
      expect(user.access_token_cache).to eql(user.access_token)
    end
  end

  describe '.process_pending_group_invites!' do
    before { user.save } 
    let!(:group) { FactoryGirl.create(:group, admin: user) }
    let!(:invite) { FactoryGirl.create(:invite, user: user, to: '12145551234', group: group) }

    it 'adds invited users to the group they were invited to when they create an account' do
      invited_user = FactoryGirl.build(:user, phone_number: '12145551234')
      invited_user.save
      expect(invited_user.reload.groups).to include(group)
    end

    it 'adds invited users to the group they were invited to when they create an account and use a different formatted number' do
      invited_user = FactoryGirl.build(:user, phone_number: '214-555-1234')
      invited_user.save
      expect(invited_user.reload.groups).to include(group)
    end

    it 'adds invited users to the group they were invited to when they create an account and use a different formatted number with +1' do
      invited_user = FactoryGirl.build(:user, phone_number: '1-214-555-1234')
      invited_user.save
      expect(invited_user.reload.groups).to include(group)
    end

    it 'does not invited users to a group if user signs up with a different phone number' do
      invited_user = FactoryGirl.build(:user, phone_number: '12145551236')
      invited_user.save
      expect(invited_user.reload.groups).to_not include(group)
    end
  end

  describe '.friends' do
    before do 
      user.save
      user2.save
    end
    
    let!(:group) { FactoryGirl.create(:group, admin: user) }
    let!(:group_user1_group_1) { FactoryGirl.create(:group_user, group: group, user: user) }
    let!(:group_user2_group_1) { FactoryGirl.create(:group_user, group: group, user: user2) }
    let!(:group2) { FactoryGirl.create(:group, admin: user) }
    let!(:group_user1_group_2) { FactoryGirl.create(:group_user, group: group2, user: user) }
    let!(:user3) { FactoryGirl.create(:user) }

    it 'returns all your friends that are in any group with you' do
      expect(user.friends).to include(user2)
    end

    it 'returns all your friends that are not in a specific group' do
      expect(user.friends(group2)).to include(user2)
    end

    it 'does not return friends that are already in the group' do
      expect(user.friends(group)).to_not include(user2)
    end

    it 'does not return yourself' do
      expect(user.friends(group)).to_not include(user)
      expect(user.friends).to_not include(user)
    end

    it 'does not return people you aren\'t friends with' do
      expect(user.friends(group)).to_not include(user3)
      expect(user.friends).to_not include(user3)
    end

    it 'does not return duplicates' do
      FactoryGirl.create(:group_user, group: group2, user: user2)
      expect(user.reload.friends.size).to eql(1)
    end
  end
end
