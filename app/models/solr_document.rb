# frozen_string_literal: true

class SolrDocument
  include Blacklight::Solr::Document
  # The following shows how to setup this blacklight document to
  # display marc documents
  extension_parameters[:marc_source_field] = :marc_display
  extension_parameters[:marc_format_type] = :marcxml
  use_extension(Blacklight::Solr::Document::Marc) do |document|
    document.key?(:marc_display)
  end

  self.unique_key = 'DocId'
end
