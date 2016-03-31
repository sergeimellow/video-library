class CreateContentProviders < ActiveRecord::Migration
  def change
    create_table :content_providers do |t|
      t.string :title
      t.string :url
      t.string :url_title
      t.text :description

      t.timestamps null: false
    end
  end
end
