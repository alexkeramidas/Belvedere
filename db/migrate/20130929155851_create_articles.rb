class CreateArticles < ActiveRecord::Migration
    def up
        create_table :articles do |t|
            t.string :title
            t.text :description
            t.boolean :visible
            t.integer :article_type

            t.timestamps
        end
    end
    def down
        drop_table :articles
    end
end
