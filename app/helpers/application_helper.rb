module ApplicationHelper
  def url_for_document(document, _params = {})
    if document.key? 'DocId'
      "/id/#{document['DocId']}"
    else
      super
    end
  end

  def session_tracking_path(_document, _params)
    nil
  end

  def url_display(data)
    items = data[:document][data[:field]].each_with_index.map do |url, i|
      label = data[:document]["#{data[:field]}_label"][i]

      content_tag(:li, link_to(label, url))
    end

    content_tag(:ul, safe_join(items))
  end

  def position_display(data)
    items = data[:document][data[:field]].each_with_index.map do |_field, i|
      label = data[:document]["#{data[:field]}_label"][i]
      org = data[:document]["#{data[:field]}_org"][i]
      org_label = data[:document]["#{data[:field]}_org_label"][i]

      org_link = link_to(org_label, "/?f[position_org][]=#{org}")
      content_tag(:li, "#{label} at #{org_link}".html_safe)
    end

    content_tag(:ul, safe_join(items))
  end
end
