module IoAsk
  class Category < IoAsk.category_class
    scope :for_ask, -> { where(:name => 'Ask') }
  end
end