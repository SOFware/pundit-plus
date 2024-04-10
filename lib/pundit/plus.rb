# frozen_string_literal: true

require_relative "plus/version"
require_relative "plus/custom_exception"

module Pundit
  module Plus
    def exception_from(query:)
      Pundit::NotAuthorizedError
    end
  end
end
