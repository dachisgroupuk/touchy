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
      
      context "when called on the User model" do
        class User < ActiveRecord::Base; acts_as_touchy; end
        let(:user) { create(:user) }
        
        context "when nothing has changed" do
          it "should do nothing" do
            expect{
              Timecop.freeze(time){ user.be_touchy }
            }.not_to change{ user.last_active_at }
          end
        end
        
        context "when last_active_at has changed" do
          before{ user.last_active_at = Time.now + 60 }
          
          it "should do nothing" do
            expect{
              Timecop.freeze(time){ user.be_touchy }
            }.not_to change{ user.last_active_at }
          end
        end
        
        context "when an attribute other than last_active_at has changed" do
          before{ user.username = 'foo' }
          
          it "should set last_active_at for the user" do
            expect{
              Timecop.freeze(time){ user.be_touchy }
            }.to change{ user.last_active_at }.to(time)
          end
        end
      end
    end
  end
end
