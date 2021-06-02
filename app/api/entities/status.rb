# frozen_string_literal: true

module Entities
  ##
  class Status < Grape::Entity
    expose :id, documentation: { type: Integer, example: 1 }

    expose :status_type, documentation: { type: String, example: ::Status::SUCCESS,
                                          desc: ::Status.human_attribute_name(:status_type) }

    expose :hostname, documentation: { type: String, example: 'example.com',
                                       desc: ::Status.human_attribute_name(:hostname) }

    expose :message, documentation: { type: String, example: 'Everything is fine',
                                      desc: ::Status.human_attribute_name(:message) }

    expose :current, documentation: { type: 'Boolean', example: true,
                                      desc: ::Status.human_attribute_name(:current) }

    expose :created_at, documentation: { type: DateTime, example: Time.now,
                                         desc: ::Status.human_attribute_name(:created_at) }

    expose :updated_at, documentation: { type: DateTime, example: Time.now,
                                         desc: ::Status.human_attribute_name(:updated_at) }
  end
end
