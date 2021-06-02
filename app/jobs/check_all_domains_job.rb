# frozen_string_literal: true

## Для каждого домена из базы ставит задачи на проверку состояния
class CheckAllDomainsJob < ActiveJob::Base
  queue_as :domains

  def perform
    Domain.pluck(:hostname).each do |hostname|
      UpdateDomainStatusJob.perform_later(hostname)
    end

    true
  end
end
