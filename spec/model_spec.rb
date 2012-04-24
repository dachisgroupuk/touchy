require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Touchy::Model do
  let(:blog_post) { create(:blog_post) }
  
  describe "be_touchy" do
    let(:time) { Time.now + 3600 }
    
    context "without a current_user" do
      it "should do nothing" do
        expect{
          blog_post.be_touchy
        }.not_to raise_error
      end
    end
    
    context "with a current_user" do
      let(:user) { create(:user) }
      before{ Touchy.current_user = user }
      
      it "should set last_active_at for the user" do
        expect{
          Timecop.freeze(time){ blog_post.be_touchy }
        }.to change{ user.last_active_at }.to(time)
      end
      
      it "should not set updated_at" do
        expect{
          Timecop.freeze(time){ blog_post.be_touchy }
        }.not_to change{ user.updated_at }
      end
      
      it "should not set created_at" do
        expect{
          Timecop.freeze(time){ blog_post.be_touchy }
        }.not_to change{ user.created_at }
      end
    end
  end
end
