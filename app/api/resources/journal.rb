# frozen_string_literal: true

module Resources
  ##
  class Journal < Grape::API
    helpers Grape::Pagy::Helpers

    desc 'Выводит записи из журнала' do
      success Entities::Status
      is_array true
    end
    params do
      use :pagy
      optional :query, type: Hash, default: {}
    end
    get '/' do
      present pagy(::Status.ordered.ransack(params[:query]).result), with: Entities::Status
    end
  end
end
