require 'spec_helper'

describe Device do
  it { should belong_to(:user) }
  before do
    app = Rpush::Gcm::App.new
    app.name = "pic_now_#{Rails.env}_android"
    app.auth_key = "test"
    app.connections = 1
    app.save!
  end


  describe '.token' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:device) { FactoryGirl.build(:device, user: user, brand: :ios, token: '') }

    it 'is required' do
      device.save
      expect(device).to_not be_valid
    end
  end

  describe '.fire_notification!' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:iphone) { FactoryGirl.build(:device, user: user, brand: :ios, token: 'test 1 2') }
    let!(:android) { FactoryGirl.build(:device, user: user, brand: :android, token: 'test 1 4') }

    it 'does not send a notification if there is no message' do
      iphone.save
      expect(iphone).to_not receive(:send_apn_notification)
      iphone.reload.fire_notification!(nil, :test_event)
    end

    it 'does not send a notification if there is no event' do
      iphone.save
      expect(iphone).to_not receive(:send_apn_notification)
      iphone.reload.fire_notification!("This is a test", nil)
    end

    it 'sends a notification if there is an event and message' do
      iphone.save
      expect(iphone).to receive(:send_apn_notification)
      iphone.reload.fire_notification!("This is a test", :test_event)
    end

    it 'sends an APN notification for an iOS device' do
      iphone.save
      expect(iphone).to receive(:send_apn_notification)
      expect(iphone).to_not receive(:send_gcm_notification)
      iphone.reload.fire_notification!("This is a test", :test_event)
    end

    it 'sends an GCM notification for an Android device' do
      android.save
      expect(android).to_not receive(:send_apn_notification)
      expect(android).to receive(:send_gcm_notification)
      android.reload.fire_notification!("This is a test", :test_event)
    end
  end
end
