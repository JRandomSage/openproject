#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2022 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

module Bim::Bcf
  module Comments
    class UpdateService < ::BaseServices::Update
      private

      def before_perform(params, service_result)
        journal_call = update_journal(params[:original_comment].journal, params[:comment])
        return journal_call if journal_call.failure?

        super params.slice(*::Bim::Bcf::Comment::UPDATE_ATTRIBUTES), service_result
      end

      def update_journal(journal, comment)
        ::Journals::UpdateService.new(user:,
                                      model: journal,
                                      contract_class: ::EmptyContract)
                                 .call(notes: comment)
      end
    end
  end
end
