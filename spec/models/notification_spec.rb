require 'spec_helper'

describe Notification do
  it { should belong_to(:user) }
  it { should belong_to(:group) }
  it { should belong_to(:trigger) }
end
