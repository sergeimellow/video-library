class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.string :url
      t.string :url_title
      t.text :description
      t.references :show, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
