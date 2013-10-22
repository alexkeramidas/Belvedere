class Article < ActiveRecord::Base
    validates_acceptance_of :article_type, :accept => 1
    
    # Class methods
    
    def self.valid
        self.where(:article_type => 1)
    end
    
    def self.visible
        self.where(:visible => true)
    end
end
