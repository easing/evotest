# frozen_string_literal: true

%w[google.com yandex.ru bing.com badssl.com].each(&CreateDomain.method(:call))