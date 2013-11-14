class Reservation < ActiveRecord::Base
    validates_format_of :email, :with => /\A([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})\Z/i, :message => 'Email address is not correct (e.g. name@domain.com)'
    validates_format_of :adults, :with => /\A(0*(?:[1-2][0-9]?|2))\Z/i, :message => 'Maximum number of adults allowed is 19'
    validates_format_of :youngsters, :with => /\A(0*(?:[0-2][0-9]?|2))?\Z/i, :message => 'Maximum number of children allowed is 19'
    validates :arrival, :date => {:after => Proc.new { Time.now + 1.day}, :before => Proc.new { Time.now + 1.day + 6.month } , :message => 'Arrival date must be after current date'}
    validates :departure, :date => {:after => :arrival , :before => Proc.new { Time.now + 2.day + 6.month }, :message => 'Departure date must be after the arrival date and less than six months away'}

    def days
        days_to_stay = (departure - arrival).to_i
    end
end
