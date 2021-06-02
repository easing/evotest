# frozen_string_literal: true

module Entities
  ##
  class Domain < Grape::Entity
    expose :id, documentation: { type: Integer, example: 1 }
    expose :hostname, documentation: { type: String, example: 'example.com',
                                       desc: ::Domain.human_attribute_name(:hostname) }
    expose :status, with: Entities::Status,
                    documentation: { desc: ::Domain.human_attribute_name(:status) }
  end
end
