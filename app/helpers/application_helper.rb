module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? "sidebar-item selected" : "sidebar-item"
  end
end
