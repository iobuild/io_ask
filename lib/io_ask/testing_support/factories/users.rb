FactoryGirl.define do
  factory :user do |f|
    f.login "io_ask_user"
    f.email { "bob#{rand(100000)}@boblaw.com" }
    f.password "password"
    f.password_confirmation "password"
  end
end

