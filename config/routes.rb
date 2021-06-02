# frozen_string_literal: true

require_relative '../lib/protected.rb'

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Api => '/'

  mount Protected[
          Sidekiq::Web,
          username: ENV['DASHBOARD_USER'],
          password: ENV['DASHBOARD_PASSWORD']
        ], at: '/sidekiq', as: :sidekiq_web

  root to: 'docs#swagger'
end
