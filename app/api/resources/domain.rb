# frozen_string_literal: true

module Resources
  ##
  class Domain < Grape::API
    desc 'Добавляет новый домен в список' do
      success Entities::Domain
    end
    params do
      requires :hostname, type: String
    end
    post '/' do
      domain = CreateDomain.call(params[:hostname])
      if domain.persisted?
        present domain, with: Entities::Domain
      else
        error!({ errors: domain.errors }, :bad_request)
      end
    end
  end
end
