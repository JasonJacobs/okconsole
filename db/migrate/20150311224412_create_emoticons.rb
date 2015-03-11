class CreateEmoticons < ActiveRecord::Migration
  def change
    create_table :emoticons do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
