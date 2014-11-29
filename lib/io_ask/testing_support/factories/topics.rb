FactoryGirl.define do
  factory :topic, :class => IoAsk::Topic do |t|
    t.title "This is a title"
    t.content "This is a content"

    t.user {|u| u.association(:user) }
    t.category {|u| u.association(:category) }


    factory :approved_post, :traits => [:approved]
  end

end
