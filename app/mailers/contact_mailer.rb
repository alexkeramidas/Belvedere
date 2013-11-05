class ContactMailer < ActionMailer::Base
    default :from => ActionMailer::Base.smtp_settings[:user_name]
    
    def contact_email(name, email, message)
        @name = name
        @email = email
        @message = message
        mail(:to => ActionMailer::Base.smtp_settings[:user_name], :subject => "Belvedere Hotel - New message from Contact Form!")
    end
end
