class Poi < ActiveRecord::Base
    self.table_name = "articles"

    # has_many :photos, :foreign_key => 'article_id', :dependent => :destroy
    # accepts_nested_attributes_for :photos, :allow_destroy => true, reject_if: proc {|attr| attr['image'].blank?}

    #Translations Configuration
    has_many :article_translations, foreign_key: 'article_id'
    accepts_nested_attributes_for :article_translations, :allow_destroy => true
    translates :title, :description

    validates_acceptance_of :article_type, :accept => 5

    # validates_associated :photos

    # Class methods

    def self.valid
        self.where(:article_type => 5)
    end

    def self.visible
        self.where(:visible => true)
    end
end
