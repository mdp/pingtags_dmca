# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def tracked_link_to(link, link_href, scan_id, opts = {})
    link_to link, link_path(:link => link, :link_href => link_href, :scan_id => scan_id), opts
  end

  def localized_image_tag(img, options = {})
    img_arr = img.split('.')
    extension = img_arr.pop
    localized_img = "#{img_arr.join('.')}_#{I18n.locale}.#{extension}"
    p localized_img
    if File.exists?(RAILS_ROOT + "/public/images/#{localized_img}")
      image_tag("#{localized_img}", options)
    else
      image_tag(img, options)
    end
  end

  def time_in_words(time)
    if Time.now - time > 86400
      "#{time.strftime("%A %e %B %Y")}"
    else
      "#{time_ago_in_words(time)} ago"
    end
  end

end
