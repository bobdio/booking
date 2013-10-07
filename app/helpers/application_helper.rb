module ApplicationHelper
  def resource_name
    :user
  end
 
 
  def resource
    @resource ||= User.new
  end
 
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction =  sort_column == column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, params.merge(sort: column, direction: direction), {class: css_class}
  end
end