module IoAsk
  module ApplicationHelper

    def show_sidebar_categories(ask_categories)

      content_tag :div do
        ask_categories.map do |item| 
          href = "/ask/topics?cid=#{item.id}"
          concat(content_tag(:a, item.name, :class => 'btn', :href => href))
        end
      end

    end

  end
end
