require 'spec_helper'

describe Answer do

	it { should respond_to(:question_id) }
	it { should respond_to(:name) }

end
