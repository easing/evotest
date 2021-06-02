# frozen_string_literal: true

module Resources
  ##
  class Status < Grape::API
    desc 'Список проверяемых доменов' do
      success Entities::Domain
    end
    get '/' do
      present ::Domain.includes(:status), with: Entities::Domain
    end
  end
end
