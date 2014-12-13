module IoAsk
  class ApplicationController < ActionController::Base
    layout IoAsk.layout

    before_filter :pre_extend

    def pre_extend
      @ask_categories = IoAsk::Category.all
    end

  end
end
