class AddArticleRefToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :article, index: true
    Photo.connection.execute("UPDATE photos SET article_id=suite_id")
    remove_column :photos, :suite_id
  end
end
