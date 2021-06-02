# frozen_string_literal: true

##
class Api < Grape::API
  format :json
  content_type :json, 'application/json'

  rescue_from ActiveRecord::RecordNotFound, -> { error!('Record Not Found', 404) }
  rescue_from :all, ->(e) { error!(e.message || 'Unknown Error', 500) }

  mount Resources::Journal => '/journal'
  mount Resources::Status => '/status'
  mount Resources::Domain => '/domain'

  add_swagger_documentation mount_path: '/swagger',
                            format: :json,
                            info: {
                              title: 'Evo Api'
                            },
                            hide_format: false,
                            hide_documentation_path: true,

                            tags: [
                              { name: 'domain', description: 'Работа с доменами' },
                              { name: 'status', description: 'Актуальные проверки' },
                              { name: 'journal', description: 'История состояний' }
                            ]
end
