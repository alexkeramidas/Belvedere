class Article < ActiveRecord::Base
    PER_PAGE = 5
    ORDER_BY = {column: :updated_at, order: :desc}

    validates_acceptance_of :article_type, :accept => 1

    paginates_per Article::PER_PAGE
    default_scope ->{ order(Article::ORDER_BY[:column] => Article::ORDER_BY[:order]) }

    scope :paginated, ->(page_num = 1, per_page = Article::PER_PAGE) { page(page_num).per(per_page) }

    #Object translations
    has_many :article_translations
    translates :title, :description
    accepts_nested_attributes_for :article_translations, :allow_destroy => true


    # Object methods

    def article_type_name
        case article_type
        when 1
            return 'News'
        when 2
            return 'Suites'
        when 3
            return 'Photo Gallery'
        when 4
            return 'Services'
        when 5
            return 'Points of Interest'
        else
            return ''
        end
    end

    def page_at(per_page = nil)
        column = Article::ORDER_BY[:column]
        order = Article::ORDER_BY[:order]
        per = per_page || Article::PER_PAGE

        operator = (order == :asc ? '<=' : '>=')

        (Article.valid.visible.where("#{column} #{operator} ?", read_attribute(column)).order("#{column} #{order}").count.to_f / per).ceil
    end

    # Class methods

    def self.valid
        self.where(:article_type => 1)
    end

    def self.visible
        self.where(:visible => true)
    end
end
