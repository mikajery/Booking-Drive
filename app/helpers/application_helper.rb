module ApplicationHelper

  def active_if_current_page_is(page)
    current_page?(page) ? 'class="active"'.html_safe : ''
  end

  def set_active(page)
    current_page?(page) ? "active".html_safe : ''
  end

end
