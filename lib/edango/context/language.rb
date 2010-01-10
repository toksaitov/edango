#    EDango - torrent ticket extractor.
#    Copyright (C) 2010  Dmitrii Toksaitov
#
#    This file is part of EDango.
#
#    EDango is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    EDango is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with EDango. If not, see <http://www.gnu.org/licenses/>.

require 'edango/di/container'

module EDango
  module Language

    UN_US = DI::Container.new do
      asset :agent_title => 'Evil Dango - Ticket Extractor'

      asset :description => 'torrent ticket extractor'

      asset :url_label => 'link:'
      asset :url_hint  => 'A page link where the desired ticket can be downloaded'

      asset :passkey_label => 'passkey:'
      asset :passkey_hint  => 'A passkey that will be used in the extracted ticket'

      asset :process_hint => 'Extract a ticket'

      asset :result_form_title => 'Result:'
      asset :ticket_link_title => 'Extracted ticket'

      asset :more_hint => 'Extract more tickets'

      asset :help_hint => 'Show/Hide help'

      asset :synopsys_title => 'Synopsys:'

      asset :synopsys_text => "Evil Dango can help you to extract torrent tickets from 'torrentpier'-enabled "\
                              "sites. It fetches a ticket with a predefined account and replaces the initial "\
                              "passkey with a new defined one."

      asset :notes_title => 'Notes:'

      asset :passkey_note => "The passkey can usually be found on the 'profile' page of the site."

      asset :link_note => "The URL in the 'link' field should point to the page "\
                          "where a download link for the ticket can be found."

      asset :all_specs => 'all specifications'
      asset :no_specs_for_url => 'Specifications were not found for the link.'

      asset :error_form_title => 'The following problems occurred:'
      asset :error_list_title => 'Problems with'

      asset :specified_file => 'the specified file'
      asset :file_not_found => 'File was not found'

      asset :operation_timed_out => 'The process did not finish in the specified time limit.'

      asset :empty_url => 'The link field should not be empty.'
      asset :empty_passkey => 'The passkey field should not be empty.'

      asset :empty_source_passkey => 'A passkey used to find replacement places in the ticket was not specified.'
      asset :empty_ticket_link_regex => 'A regular expression used to search for a ticket download link was not set.'

      asset :empty_login => 'A login name for the account used in the ticket extraction process was not set.'
      asset :empty_password => 'A password for the account used in the ticket extraction process was not specified.'

      asset :empty_login_url => 'A login url for the account used in the ticket extraction process was not set.'

      asset :login_process_failed => 'Failed to log in.'

      asset :ticket_page_loading_failed => 'Failed to load the page with a ticket link.'
      asset :ticket_link_not_found => 'A link for the ticket was not found on the specified page.'

      asset :raw_ticket_not_saved => 'Failed to download and save the ticket.'

      asset :raw_ticket_not_opened => 'Failed to read saved ticket in order to replace its passkey.'
      asset :passkey_not_found => 'The extracted ticket does not have an initial passkey to change.'
      asset :processed_ticket_not_saved => 'Failed to save processed ticket.'
    end

  end

  LANGUAGE = LANG = Language::UN_US
end

module Kernel
  def translate(key)
    EDango::LANGUAGE[key] || key.to_s()
  end
  alias t translate
end
