module IoAsk
  class Category < IoAsk.category_class
    scope :ask_root, -> { where(:name => 'Ask').first }
    scope :for_ask, -> { where(:parent_id => self.ask_root.id) }
  end
end