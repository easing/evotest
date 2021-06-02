# frozen_string_literal: true

## Запускает проверку состояния домена
class UpdateDomainStatusJob < ActiveJob::Base
  queue_as :domains
  discard_on ArgumentError

  def perform(hostname)
    UpdateDomainStatus.call(hostname)
  end
end
