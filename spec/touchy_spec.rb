require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Touchy do
  let(:user) { create(:user) }
  
  describe ".current_user" do
    context "with a user saved in the current thread" do
      before{ Thread.current[:touchy] = { :current_user => user } }
      
      it{ Touchy.current_user.should == user }
    end
  end
  
  describe ".current_user=" do
    it "should save the user in the current thread" do
      expect{
        Touchy.current_user = user
      }.to change{ Thread.current[:touchy][:current_user] }.from(nil).to(user)
    end
  end
end
