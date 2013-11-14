class Reservation < ActiveRecord::Base
    validates_format_of :email, :with => /\A([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})\Z/i, :on => :create, :on => :update
    validates_format_of :days, :with => /\A(0*(?:[1-2][0-9]?|2))\Z/i, :on => :create, :on => :update
    validates_format_of :adults, :with => /\A(0*(?:[1-2][0-9]?|2))\Z/i, :on => :create, :on => :update
    validates_format_of :youngsters, :with => /\A(0*(?:[1-2][0-9]?|2))\Z/i, :on => :create, :on => :update
    validates :arrival, :date => {:after => Proc.new { Time.now }, :message => 'Arrival date must be after current date'}
    validates :departure, :date => {:after => :arrival , :before => Proc.new { Time.now + 6.month }, :message => 'Departure date must be after arrival date and less than six months away'}
end
