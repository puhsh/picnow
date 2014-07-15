require 'spec_helper'

describe Group do
  let!(:group) { FactoryGirl.create(:group) }

  describe '.name' do
    it 'is required' do
      group.name = nil
      group.save
      expect(group).to_not be_valid
    end

    it 'cannot be longer than 30 characters' do
      group.name = "Long " * 6
      group.save
      expect(group).to_not be_valid
    end
  end
end
