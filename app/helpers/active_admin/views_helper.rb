module ActiveAdmin::ViewsHelper
    def language_list
        I18n.available_locales.map { |loc|
            loc = [I18n.t("meta.language_admin", locale: loc.to_s), loc.to_s]
        }
    end
end
