class Reservation < ActiveRecord::Base

    before_validation :children_to_zero

    validates :email, :with => :validate_email

    validates_format_of :name, :with => /\A#{ApplicationHelper.form_field_attr('name')[:regex]}\Z/i, :message => "#{ApplicationHelper.form_field_attr('name')[:generic]}"
    validates_format_of :adults, :with => /\A#{ApplicationHelper.form_field_attr('adults')[:regex]}\Z/i, :message => "#{ApplicationHelper.form_field_attr('adults')[:generic]}"
    validates_format_of :youngsters, :with => /\A#{ApplicationHelper.form_field_attr('children')[:regex]}\Z/i, :message => "#{ApplicationHelper.form_field_attr('children')[:generic]}"
    validates :arrival, :date => {:after => Proc.new { 1.day.ago }, :before => Proc.new { 6.months.from_now } , :message => "#{ApplicationHelper.form_field_attr('arrival')[:generic]}"}
    validates :departure, :date => {:after => :arrival , :before => Proc.new { 1.day.since(6.months.from_now.to_date) }, :message => "#{ApplicationHelper.form_field_attr('departure')[:generic]}"}

    #Custom validations for phone numbers
    validates_each :phone, :mobile do |model, attr, value|
        left_par = value.count(")")
        right_par = value.count("(")
        left_bra = value.count("]")
        right_bra = value.count("[")

        if !value.match(/\A^(?!\(\+\))[\(\[]?\+?[\)\]]?\s?(?<num>([\(\[]?\d{1,10}[\)\]]?([\s\-\.\/]{1,3}\g<num>|[\(\[]?\d{1,10}[\)\]]?\d{,10}))?)$\Z/i) || left_par != right_par || left_bra != right_bra
            model.errors.add(attr, "#{ApplicationHelper.form_field_attr(attr.to_s)[:generic]}")
        end
    end

    #Custom validation to be used in validates :email
    def validate_email
        if !self.email.match(/\A#{ApplicationHelper.form_field_attr('email')[:regex]}\Z/i)
            self.errors.add(:email, "#{ApplicationHelper.form_field_attr('email')[:generic]}")
        end
    end

    #Change children value to zero if set to nil to be used before validation
    def children_to_zero
        self.youngsters ||= 0
    end
end
