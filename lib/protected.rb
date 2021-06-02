# frozen_string_literal: true

##
# Basic-авторизация для Rack-приложений
#
# +mount Protected[Sidekiq::Web, username: 'username', password: 'password'] => '/sidekiq'+
#
# По мотивам Rack apps mounted in Rails — how to protect access to them?
# https://blog.arkency.com/common-authentication-for-mounted-rack-apps-in-rails/
#
module Protected
  def self.[](app, username:, password:)
    Rack::Builder.new do
      use Rack::Auth::Basic do |provided_username, provided_password|
        hexdigest = ::Digest::SHA256.method(:hexdigest)
        secure_compare = ActiveSupport::SecurityUtils.method(:secure_compare)

        username_comparison = secure_compare.call(hexdigest.call(provided_username), hexdigest.call(username))
        password_comparison = secure_compare.call(hexdigest.call(provided_password), hexdigest.call(password))

        username_comparison & password_comparison
      end

      run app
    end
  end
end
