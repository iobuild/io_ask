FactoryGirl.define do
  factory :user do |f|
    f.email { "bob#{rand(100000)}@boblaw.com" }
  end
end

