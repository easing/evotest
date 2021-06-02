# frozen_string_literal: true

##
# Создаёт запись в журнале состояний
class CreateStatus
  # Создаёт запись в журнале состояний, если новое состояние хоста отличается от текущего
  #
  # @param [String] hostname
  # @param [String] status_type
  # @param [String] message
  # @return [Status]
  def self.call(hostname, status_type:, message:)
    # Если в актуальном статусе домена те же параметры, возвращаем актуальный статус и ничего не создаём
    current_status = Status.find_by(hostname: hostname, current: true, status_type: status_type, message: message)
    if current_status
      current_status.touch
      return current_status
    end

    # Создаём новый актуальный статус домена
    Status.transaction do
      Status.where(hostname: hostname, current: true).update_all(current: false)
      Status.create!(hostname: hostname, current: true, status_type: status_type, message: message)
    end
  end
end
