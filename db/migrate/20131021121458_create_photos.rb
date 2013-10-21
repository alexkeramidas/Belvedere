class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :article_id
      t.string :description

      t.timestamps
    end
  end
end
