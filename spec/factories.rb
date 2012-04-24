FactoryGirl.define do
  
  factory :user do
    sequence(:username) { |n| "john_doe_#{n}" }
  end
  
  factory :blog_post do
    title "A Blog Post"
  end
  
end
