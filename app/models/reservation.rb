class Reservation < ActiveRecord::Base
    validates :email, :with => :validate_email
    validates_format_of :adults, :with => /\A^([1][0-9]|[0-9])$\Z/i, :message => 'Maximum number of adults allowed is 19'
    validates_format_of :youngsters, :with => /\A^([0-1][0-9]|[0-9])$\Z/i, :message => 'Maximum number of children allowed is 19'
    validates :arrival, :date => {:after => Proc.new { Time.now }, :before => Proc.new { Time.now + 6.month } , :message => 'Arrival date must be after current date'}
    validates :departure, :date => {:after => :arrival , :before => Proc.new { Time.now + 1.day + 6.month }, :message => 'Departure date must be after the arrival date and less than six months away'}

    before_save do
        self.days = (departure - arrival).to_i
    end

    validates_each :phone, :mobile do |model, attr, value|
        left_par = value.count(")")
        right_par = value.count("(")
        left_bra = value.count("]")
        right_bra = value.count("[")
        if !value.match(/\A^(?!\(\+\))[\(\[]?\+?[\)\]]?\s?(?<num>([\(\[]?\d{1,10}[\)\]]?([\s\-\.\/]{1,3}\g<num>|[\(\[]?\d{1,10}[\)\]]?\d{,10}))?)$\Z/i) || left_par!=right_par || left_bra!=right_bra
              model.errors.add(attr, "Invalid phone number format!!!")
        end
     end

     def validate_email
        if !self.email.match(/\A([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})\Z/i)
               self.errors.add(:email, "Email address is not correct (e.g. name@domain.com)!!!")
        end
     end
end
