require 'spec_helper'

describe User do
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
    it 'is required' do
      user.date_of_birth = nil
      user.save
      expect(user).to_not be_valid
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
end