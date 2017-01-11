ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    panel "Recent Cards" do
      table_for Card.order("review_date desc").limit(5) do
        column :original_text
        column :translated_text
        column :review_date
      end
      strong { link_to "View All Cards", admin_cards_path }
    end
  end # content
end
