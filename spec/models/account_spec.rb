require 'spec_helper'

describe Account do
  before(:each) do 
    @user = FactoryGirl.build :client
    @account = @user.account
  end

  it "should have first and last names" do
    @account.firstname.should_not be_nil
    @account.lastname.should_not be_nil
  end
  
  it "should have a valid cellphone number" do
    @account.cellphone = "asdasdasdasd"
    @account.should_not be_valid
  end

  it "should have a valid birth date" do
    @account.birthday = 1241241241251512
    @account.should_not be_valid
  end
end
