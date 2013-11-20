class Reservation < ActiveRecord::Base
    validates :email, :with => :validate_email
    validates_format_of :adults, :with => /\A#{ApplicationHelper.form_field_attr('adults')[:regex]}\Z/i, :message => "#{ApplicationHelper.form_field_attr('adults')[:generic]}"
    validates_format_of :youngsters, :with => /\A#{ApplicationHelper.form_field_attr('children')[:regex]}\Z/i, :message => "#{ApplicationHelper.form_field_attr('children')[:generic]}"
    validates :arrival, :date => {:after => Proc.new { Time.now }, :before => Proc.new { Time.now + 6.month } , :message => "#{ApplicationHelper.form_field_attr('arrival')[:generic]}"}
    validates :departure, :date => {:after => :arrival , :before => Proc.new { Time.now + 1.day + 6.month }, :message => "#{ApplicationHelper.form_field_attr('departure')[:generic]}"}

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
end
