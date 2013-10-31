class PhotoGallery < ActiveRecord::Base
    self.table_name = "articles"

    has_many :photos, :foreign_key => 'article_id', :dependent => :destroy
    accepts_nested_attributes_for :photos, :allow_destroy => true

    validates_acceptance_of :article_type, :accept => 3
    
    validates_associated :photos

    # Class methods
    
    def self.valid
        self.where(:article_type => 3)
    end

    def self.visible
        self.where(:visible => true)
    end
    
    def self.latest
        self.valid.visible.last()
    end
end
