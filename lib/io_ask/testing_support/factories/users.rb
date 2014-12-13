FactoryGirl.define do
  factory :user do |f|

    f.username "ioask_user"
    f.email { "bob#{rand(100000)}@boblaw.com" }
    f.password "password"
    f.password_confirmation "password"

  end
end

