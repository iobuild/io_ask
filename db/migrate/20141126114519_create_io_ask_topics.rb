class CreateIoAskTopics < ActiveRecord::Migration
  def change
    create_table :io_ask_topics do |t|
      t.integer :topic_id
      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
