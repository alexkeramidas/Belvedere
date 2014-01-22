class RemoveLastEditToArticle < ActiveRecord::Migration
    def change
        remove_column :articles, :last_edit, :timestamp
    end
end
