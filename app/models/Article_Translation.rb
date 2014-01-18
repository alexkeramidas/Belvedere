class ArticleTranslation < ActiveRecord::Base
  belongs_to :article
  validates_uniqueness_of :locale, :scope => :article_id
end