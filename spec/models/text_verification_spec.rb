require 'spec_helper'

describe TextVerification do
  it { should belong_to(:user) }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:text_verification) { FactoryGirl.create(:text_verification, user: user, code: SecureRandom.hex(3)) }

  describe ".verified?" do
    it 'returns false if there is no confirmed_at' do
      expect(text_verification).to_not be_verified
    end
    
    it 'returns true if there is no confirmed_at' do
      text_verification.confirmed_at = DateTime.now
      text_verification.save
      expect(text_verification.reload).to be_verified
    end
  end

  describe '.verify!' do
    it 'verifies the text verification' do
      text_verification.verify!(user, text_verification.code)
      expect(text_verification.reload).to be_verified
    end

    it 'does not verify the user if they pass in an invalid code' do
      text_verification.verify!(user, "abc")
      expect(text_verification.reload).to_not be_verified
    end
  end
end
