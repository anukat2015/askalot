module Shared::DashboardHelper
  def dashboard_link(icon, number, description, path, type)
    html = <<-HTML
      <div class="col-xs-12 col-sm-6">
        <a href="#{path}">
          <div class="link-icon #{type}">#{fa_icon icon}</div>
          <div class="link-text">
              <div class="vertical-table">
                <div class="vertical-cell">
                  <div class="number">#{number}</div>
                  <div class="description">#{description}</div>
                </div>
              </div>
          </div>
        </a>
      </div>
    HTML

    html.html_safe
  end

  def active_tab_class(all_news, user, tab)
    if all_news.first && user.dashboard_last_sign_in_at < all_news.first.created_at
      return 'active' if tab == :news
    elsif tab == :activites
      return 'active'
    end

    return ''
  end
end
