# frozen_string_literal: true

class CatalogController < ApplicationController
  include Blacklight::Catalog
  include Blacklight::Marc::Catalog

  %i[sms email citation bookmark].each do |tool|
    CatalogController.blacklight_config.show.document_actions.delete(tool)
  end

  configure_blacklight do |config|
    # This controls which partials are used, and in what order, for
    # each record type.
    #
    # - _show_header_default.html.erb
    # - _thumbnail_default.html.erb
    # - _show_default.html.erb
    #
    # falling back to _title_default etc. in each case.
    config.show.partials = %i[
      show_header
      media
      show
    ]

    # Default parameters to send to solr for all search-like
    # requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      rows: 10
    }

    # Default parameters to send on single-document requests to
    # Solr. These settings are the Blackligt defaults (see
    # SearchHelper#solr_doc_params) or parameters included in the
    # Blacklight-jetty document requestHandler.
    config.default_document_solr_params = {
      qt: 'search',
      q: '{!term f=DocId v=$id}'
    }

    # solr field configuration for search results/index views
    config.index.title_field = 'nameDisplay'
    config.index.display_type_field = 'typeDisplay'
    config.index.thumbnail_field = 'THUMBNAIL_URL'

    # solr field configuration for document/show views
    # config.show.title_field = 'nameDisplay'
    # config.show.display_type_field = 'typeDisplay'
    # config.show.thumbnail_field = 'THUMBNAIL_URL'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar
    #
    # set :index_range to true if you want the facet pagination view
    #  to have facet prefix-based navigation (useful when user clicks
    #  "more" on a large facet and wants to navigate alphabetically
    #  across a large set of results) :index_range can be an array or
    #  range of prefixes that will be used to create the navigation
    #  (note: It is case sensitive when searching values)
    config.add_facet_field 'typeDisplay', label: 'Type'

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    # config.add_index_field 'nameDisplay', label: 'Title'
    config.add_index_field 'typeDisplay', label: 'Type'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    config.add_show_field 'nameDisplay', label: 'Title'
    config.add_show_field 'typeDisplay', label: 'Type'

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.
    config.add_search_field 'nameDisplay', label: 'Title'

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    # config.add_sort_field 'score desc, pub_date_sort desc, title_sort asc', label: 'relevance'
    # config.add_sort_field 'pub_date_sort desc, title_sort asc', label: 'year'
    # config.add_sort_field 'author_sort asc, title_sort asc', label: 'author'
    # config.add_sort_field 'title_sort asc, pub_date_sort desc', label: 'title'
  end

  def show
    # Rails filters the parameters and turns http:// into http:/
    params[:id].sub!(':/', '://')

    super
  end
end
