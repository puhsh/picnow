require 'spec_helper'

describe GroupPhoto do
  it { should belong_to(:user) }
  it { should belong_to(:group) }
  it { should belong_to(:photo) }
  it { should have_one(:notification) }
end
