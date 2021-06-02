# frozen_string_literal: true

##
# Добавляет домен в список отслеживаемых и ставит задачу на обновление его состояния.
# Если домен уже есть в базе данных, просто ставит задачу на обновление состояния.
class CreateDomain
  # @param [String] hostname
  # @return [Domain]
  def self.call(hostname)
    domain = Domain.find_or_create_by(hostname: hostname)
    UpdateDomainStatusJob.perform_later(hostname) if domain.persisted?
    domain
  end
end
