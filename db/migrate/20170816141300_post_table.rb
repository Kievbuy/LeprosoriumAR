class PostTable < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :author
      t.text :content
      
      t.timestamps
    end
  end
end