module IoAsk
  class Topic < ActiveRecord::Base

    belongs_to :user, :class_name => IoAsk.user_class.to_s, :foreign_key => :user_id

    belongs_to :category, 
               :class_name => IoAsk.category_class.to_s, :foreign_key => :category_id

    belongs_to :last_comment_user, 
               :class_name => IoAsk.user_class.to_s, :foreign_key => 'last_comment_user_id'



    default_scope -> { order('created_at desc') }

    scope :last_commented, -> {  unscoped.order('last_commented_at desc') }
    scope :by_category, ->(category_id) { where("category_id = ?", category_id) }


    validates :title, :content, :category, :user, :presence => true


    paginates_per 12


    def slug
      title.downcase.gsub(" ", "-")  
    end

    def to_param
      "#{id}-#{slug}"
    end


    after_create :update_last_comment
    def update_last_comment
      self.last_comment_user = user
      self.last_commented_at = self.created_at
      self.save
    end


    include IoAsk::Comment::TopicMethods

    module UserMethods
      def self.included(base)
        base.has_many :topics
      end
    end


  end
end
