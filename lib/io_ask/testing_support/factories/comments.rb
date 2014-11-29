FactoryGirl.define do
  factory :comment, :class => IoAsk::Comment do |t|
    t.content "This is a content"

    t.user {|u| u.association(:user) }
    t.topic {|u| u.association(:topic) }

  end

end
