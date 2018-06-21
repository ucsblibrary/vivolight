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
end
