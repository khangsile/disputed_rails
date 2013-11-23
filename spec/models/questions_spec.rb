require 'spec_helper'

describe Question do

  it { should respond_to(:content) }
  it { should respond_to(:category_id) }

  it { expect(FactoryGirl.build(:question)).to be_valid }

end
