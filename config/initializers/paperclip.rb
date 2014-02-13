require 'paperclip/media_type_spoof_detector'

Paperclip.interpolates :parent_name do |attachment, style|
    attachment.instance.article.article_type_name.downcase.gsub(' ', '_')
end

Paperclip.interpolates :token  do |attachment, style|
    attachment.instance.get_token
end

module Paperclip
    class MediaTypeSpoofDetector
        def spoofed?
            false
        end
    end
end
