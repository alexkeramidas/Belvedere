class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.boolean :visible
      t.datetime :created_at
      t.datetime :last_edit
      t.integer :article_type

      t.timestamps
    end
  end
end
