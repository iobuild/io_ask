module IoAsk
  class Category < IoAsk.category_class

    def slug
      name.downcase.gsub(" ", "-")  
    end

    def to_param
      "#{id}-#{slug}"
    end

  end
end