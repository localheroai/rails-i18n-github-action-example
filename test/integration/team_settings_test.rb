require "test_helper"

class TeamSettingsTest < ActionDispatch::IntegrationTest
  I18n.available_locales.each do |locale|
    test "renders the team settings page in #{locale}" do
      get root_path(locale: locale)

      assert_response :success
      assert_select "html[lang=?]", locale.to_s
      assert_select "h1", I18n.t("team_settings.show.title", locale: locale)
    end
  end

  test "Polish uses separate plural forms for 1, 4 and 5" do
    forms = [ 1, 4, 5 ].map { |count| I18n.t("team_settings.show.member_count", count: count, locale: :pl) }

    assert_equal 3, forms.uniq.size
  end
end
