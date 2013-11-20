module ApplicationHelper
    def form_field_attr(field, min=2, max=300)
        case field
        when 'name'
            {
                regex: "^(?!\\s*$).{#{min},#{max}}$",
                title: "Name between #{min} and #{max} characters.",
                moz_error: 'You must provide a valid name.',
                generic: ''
            }
        when 'email'
            {
                regex: '^[A-Za-z0-9_\-\.]+\@[A-Za-z0-9_\-\.]+\.[A-Za-z]{2,4}$',
                title: 'name@domain.com (correct e-mail structure)',
                moz_error: 'You must provide a valid e-mail address.',
                generic: ''
            }
        when 'phone'
            {
                regex: phone_regex_pattern,
                title: "Phone number for direct contact between #{min} and #{max} digits.",
                moz_error: 'You must provide a valid phone number.',
                generic: ''
            }
        when 'mobile'
            {
                regex: phone_regex_pattern(min),
                title: "Mobile phone number between #{min} and #{max} digits.",
                moz_error: 'You must provide a valid mobile phone number.',
                generic: ''
            }
        when 'arrival'
            {
                regex: date_to_regex,
                title: 'YYYY-MM-DD (correct arrival date format)',
                moz_error: 'Please specify the date of your arrival (date format must be YYYY-MM-DD).',
                generic: ''
            }
        when 'departure'
            {
                regex: date_to_regex(1.day.from_now),
                title: 'YYYY-MM-DD (correct departure date format)',
                moz_error: 'Please specify the date of your departure (date format must be YYYY-MM-DD).',
                generic: ''
            }
        when 'adults'
            {
                regex: '^(1[0-9]|[1-9])$',
                title: 'Allowed number of adults for one reservation is between 1 and 19, no leading zeros.',
                moz_error: 'The number of adults for each reservation must belong to the range from 1 to 19, no leading zeros.',
                generic: ''
            }
        when 'children'
            {
                regex: '^([0-1][0-9]|[0-9])$',
                title: 'Allowed number of children for one reservation is between 0 and 19, no leading zeros.',
                moz_error: 'The provided number of children must belong to the range from 0 to 19, no leading zeros.',
                generic: ''
            }
        when 'message'
            {
                regex: "^(?!\\s*$).{#{min},#{max}}$",
                title: "Additional details about your reservation between #{min} and #{max} characters.",
                moz_error: 'You must provide a comprehensible message.',
                generic: ''
            }
        when 'contact'
            {
                regex: "^(?!\\s*$).{#{min},#{max}}$",
                title: "Message between #{min} and #{max} characters.",
                moz_error: 'You must provide a comprehensible message.',
                generic: ''
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
        "^[\\d\\(\\)\\[\\]\\s\\-\\+\\/\\.]{#{min},}$"
    end
    
    def date_to_regex(t = Time.new)
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
