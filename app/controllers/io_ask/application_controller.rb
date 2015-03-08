module IoAsk
  class ApplicationController < ActionController::Base
    layout IoAsk.layout

    before_filter :pre_extend

    def pre_extend
      # @ask_categories = IoAsk::Category.all
      @ask_categories = IoAsk::Category.by_ask
    end

  end
end
