module ApplicationHelper
    def title(page_title=nil)
        @title = page_title
        content_for :title, "Belvedere Hotel#{' - ' if !page_title.blank?}#{page_title.to_s}"
    end
    
    def form_field_attr(field, min=2, max=300)
        ApplicationHelper.form_field_attr(field, min, max)
    end
    
    def self.form_field_attr(field, min=2, max=300)
        case field
        when 'name'
            {
                regex: "^(?!\\s*$).{#{min},#{max}}$",
                title: I18n.t('shared.forms.name.errors.title', min: min, max: max),
                moz_error: I18n.t('shared.forms.name.errors.moz'),
                generic: I18n.t('shared.forms.name.errors.generic')
            }
        when 'email'
            {
                regex: '^[A-Za-z0-9_\-\.]+\@[A-Za-z0-9_\-\.]+\.[A-Za-z]{2,4}$',
                title: I18n.t('shared.forms.email.errors.title'),
                moz_error: I18n.t('shared.forms.email.errors.moz'),
                generic: I18n.t('shared.forms.email.errors.generic')
            }
        when 'phone'
            {
                regex: phone_regex_pattern,
                title: I18n.t('main.reservation.phone.errors.title', min: min, max: max),
                moz_error: I18n.t('main.reservation.phone.errors.moz'),
                generic: I18n.t('main.reservation.phone.errors.generic')
            }
        when 'mobile'
            {
                regex: phone_regex_pattern(min),
                title: I18n.t('main.reservation.mobile.errors.title', min: min, max: max),
                moz_error: I18n.t('main.reservation.mobile.errors.moz'),
                generic: I18n.t('main.reservation.mobile.errors.generic')
            }
        when 'arrival'
            {
                regex: date_to_regex,
                title: I18n.t('main.reservation.arrival.errors.title'),
                moz_error: I18n.t('main.reservation.arrival.errors.moz'),
                generic: I18n.t('main.reservation.arrival.errors.generic')
            }
        when 'departure'
            {
                regex: date_to_regex(1.day.from_now),
                title: I18n.t('main.reservation.departure.errors.title'),
                moz_error: I18n.t('main.reservation.departure.errors.moz'),
                generic: I18n.t('main.reservation.departure.errors.generic')
            }
        when 'adults'
            {
                regex: '^(1[0-9]|[1-9])$',
                title: I18n.t('main.reservation.adults.errors.title'),
                moz_error: I18n.t('main.reservation.adults.errors.moz'),
                generic: I18n.t('main.reservation.adults.errors.generic')
            }
        when 'children'
            {
                regex: '^([0-1][0-9]|[0-9])$',
                title: I18n.t('main.reservation.children.errors.title'),
                moz_error: I18n.t('main.reservation.children.errors.moz'),
                generic: I18n.t('main.reservation.children.errors.generic')
            }
        when 'message'
            {
                regex: "^(?!\\s*$).{#{min},#{max}}$",
                title: I18n.t('main.reservation.message.errors.title', min: min, max: max),
                moz_error: I18n.t('main.reservation.message.errors.moz'),
                generic: I18n.t('main.reservation.message.errors.generic', min: min, max: max)
            }
        when 'contact'
            {
                regex: "^(?!\\s*$).{#{min},#{max}}$",
                title: "Message between #{min} and #{max} characters.",
                moz_error: 'You must provide a comprehensible message.',
                generic: "Invalid message (accepted length: between #{min} and #{max} characters)."
            }
        else
            {
                regex: '',
                title: '',
                moz_error: '',
                generic: ''
            }
        end
    end
    
    def phone_regex_pattern(min=5)
        ApplicationHelper.phone_regex_pattern(min)
    end
    
    def self.phone_regex_pattern(min=5)
        "^[\\d\\(\\)\\[\\]\\s\\-\\+\\/\\.]{#{min},}$"
    end
    
    def date_to_regex(t = Time.new)
        ApplicationHelper.date_to_regex(t)
    end
    
    def self.date_to_regex(t = Time.new)
        y = t.year.to_s
        m = t.strftime('%m')
        d = t.strftime('%d')
        
        y_later_regex = "(#{"[#{y[0].to_i + 1}-9][0-9][0-9][0-9]|" if y[0].to_i < 9}#{"#{y[0]}[#{y[1].to_i + 1}-9][0-9][0-9]|" if y[1].to_i < 9}#{"#{y[0]}#{y[1]}[#{y[2].to_i + 1}-9][0-9]|" if y[2].to_i < 9}#{"#{y[0]}#{y[1]}#{y[2]}[#{y[3].to_i + 1}-9]" if y[3].to_i < 9})"
        m_later_regex = "(#{"#{m[0].to_i + 1}[0-2]|#{m[0]}[#{m[1].to_i + 1}-9]" if m[0].to_i == 0}#{"#{m[0]}[#{m[1].to_i + 1}-2]" if m[0].to_i == 1 && m[1].to_i < 2})"
        d_later_regex = "(#{"#{d[0].to_i + 3}[0-1]|[#{d[0].to_i + 1}-#{d[0].to_i + 2}][0-9]|#{d[0].to_i}[#{d[1]}-9]" if d[0].to_i == 0}#{"#{d[0].to_i + 2}[0-1]|#{d[0].to_i + 1}[0-9]|#{d[0]}[#{d[1]}-9]" if d[0].to_i == 1}#{"#{d[0].to_i + 1}[0-1]|#{d[0]}[#{d[1]}-9]" if d[0].to_i == 2}#{"#{d[0]}[#{d[1]}-1]" if d[0].to_i == 3})"
        
        m_general_regex = "(0[1-9]|1[0-2])"
        d_general_regex = "(0[1-9]|[1-2][0-9]|3[0-1])"
        
        regex = "^(#{y_later_regex}-#{m_general_regex}-#{d_general_regex}|#{y}-#{m_later_regex}-#{d_general_regex}|#{y}-#{m}-#{d_later_regex})$"
    end
end
