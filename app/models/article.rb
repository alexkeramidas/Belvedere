class Article < ActiveRecord::Base
    PER_PAGE = 5
    
    validates_acceptance_of :article_type, :accept => 1
    
    paginates_per Article::PER_PAGE
    default_scope ->{ order(updated_at: :desc) }
    
    scope :paginated, ->(page_num = 1, per_page = Article::PER_PAGE) { page(page_num).per(per_page) }

    # Object methods

    def article_type_name
        case article_type
        when 1
            return 'News'
        when 2
            return 'Suites'
        when 3
            return 'Photo Gallery'
        else
            return ''
        end
    end

    # Class methods

    def self.valid
        self.where(:article_type => 1)
    end

    def self.visible
        self.where(:visible => true)
    end
end
