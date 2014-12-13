require 'spec_helper'


describe IoAsk::TopicsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:topic) { FactoryGirl.create(:topic, :user => user) }

  before :each do
    
    # sign_in(user)

  end

  it "signs me in" do

    delete :destroy, :id => topic.id

    response.should redirect_to('/users/sign_in')

  end

  


end