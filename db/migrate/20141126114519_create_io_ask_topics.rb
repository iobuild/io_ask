class CreateIoAskTopics < ActiveRecord::Migration
  def change
    create_table :io_ask_topics do |t|
      t.integer :topic_id
      t.integer :user_id
      t.integer :last_comment_user_id
      t.integer :category_id
      t.string :title
      t.text :content
      t.datetime :last_commented_at
      t.integer :comment_count, :default => 0

      t.timestamps
    end
  end
end
