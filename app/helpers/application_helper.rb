module ApplicationHelper
  LANGUAGE_NAMES = { en: "English", sv: "Svenska", pl: "Polski", de: "Deutsch" }.freeze

  def language_name(locale)
    LANGUAGE_NAMES.fetch(locale)
  end
end
