class ReservationMailer < ActionMailer::Base
    default :from => ActionMailer::Base.smtp_settings[:user_name]
    
    def request_email(name, email, phone, mobile, arrival, departure, adults, children, message)
        @name = name
        @email = email
        @phone = phone
        @mobile = mobile
        @arrival = arrival
        @departure = departure
        @adults = adults
        @children = children
        @message = message
        
        mail(:to => ActionMailer::Base.smtp_settings[:user_name], :subject => "Belvedere Hotel - New reservation request!")
    end
end
