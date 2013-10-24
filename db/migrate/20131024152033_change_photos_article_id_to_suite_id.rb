class ChangePhotosArticleIdToSuiteId < ActiveRecord::Migration
  def self.up
      rename_column :photos, :article_id, :suite_id
  end
  def self.down
      rename_column :photos, :suite_id, :article_id
  end
end
