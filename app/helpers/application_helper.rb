# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def tracked_link_to(link, link_href, scan_id, opts = {})
    link_to link, link_path(:link => link, :link_href => link_href, :scan_id => scan_id), opts
  end
  
end
