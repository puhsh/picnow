require 'spec_helper'

describe Invite do
  it { should belong_to(:user) }
  it { should belong_to(:joined_user) }
  it { should belong_to(:group) }
end
