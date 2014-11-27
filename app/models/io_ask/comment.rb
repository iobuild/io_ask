module IoAsk
  class Comment < ActiveRecord::Base

    belongs_to :user, :class_name => IoAsk.user_class.to_s, :foreign_key => :user_id
    belongs_to :topic


    validates :topic, :content, :presence => true


    paginates_per 20



    after_create :increase_last_comment
    def increase_last_comment
      topic.last_comment_user = user
      topic.last_commented_at = self.created_at
      topic.comment_count += 1
      topic.save
    end



    after_destroy :decrease_last_comment
    def decrease_last_comment
      comments = topic.comments
      if comments.count > 0
        last_comment = comments.last
        topic.last_comment_user = last_comment.user
        topic.last_commented_at = last_comment.created_at
      else
        topic.last_comment_user = topic.user
        topic.last_commented_at = topic.created_at
      end
      
      topic.comment_count -= 1
      topic.save
    end




    module TopicMethods
      def self.included(base)
        base.has_many :comments
      end
    end


  end
end
