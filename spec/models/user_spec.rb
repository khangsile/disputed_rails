require 'spec_helper'

describe User do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user) { FactoryGirl.build :user}
  it { expect{ user.ensure_authentication_token! }.to change(user, :authentication_token) }
end
