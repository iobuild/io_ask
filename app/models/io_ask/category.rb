module IoAsk
  class Category < IoAsk.category_class
    scope :ask_root, -> { where(:name => 'Ask').first }

    def self.has_ask_categories?
      self.where(:name => 'Ask').exists?
    end

  end
end