class CreateIoAskComments < ActiveRecord::Migration
  def change
    create_table :io_ask_comments do |t|
      t.integer     :topic_id
      t.integer     :user_id
      t.text        :content
      
      t.timestamps
    end
  end
end
