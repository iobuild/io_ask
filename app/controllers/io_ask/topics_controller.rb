module IoAsk
  class TopicsController < IoAsk::ApplicationController

    def index
      p Topic.all
    end
    
  end
end
