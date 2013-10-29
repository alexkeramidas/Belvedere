class Suite < ActiveRecord::Base
    self.table_name = "articles"

    has_many :photos, :dependent => :destroy
    accepts_nested_attributes_for :photos, :allow_destroy => true

    validates_acceptance_of :article_type, :accept => 2

    # Class methods

    def self.valid
        self.where(:article_type => 2)
    end

    def self.visible
        self.where(:visible => true)
    end

    # Object methods

    def photo_gallery
        Photo.where(:suite_id => id)
    end
end
