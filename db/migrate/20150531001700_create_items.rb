class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :user, null: false
      t.string :title, null: false
      t.text :body, null:false

      t.timestamps null: false
    end
  end
end
