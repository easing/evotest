# frozen_string_literal: true

# Небольшой манки-патч, чтобы заработал sidekiq-scheduler/web
#
module UriEscapePatch
  def escape(*args)
    CGI.escape(*args)
  end
end

URI.extend(UriEscapePatch) unless URI.respond_to?(:escape)
