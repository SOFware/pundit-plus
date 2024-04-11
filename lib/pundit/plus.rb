# frozen_string_literal: true

require_relative "plus/version"
require_relative "plus/custom_exception"
require_relative "plus/authorization"

module Pundit
  module Plus
    # The default exception to raise when authorization fails.
    def exception_from(query:)
      Pundit::NotAuthorizedError
    end

    # Return the params that are required or permitted for the given action.
    #
    # This assumes that you will define a `permitted_attributes` method in your
    # policy class to return the permitted attributes for the record. Or you may
    # define a method called `permitted_attributes_for_#{action}` to return the
    # permitted attributes for that action.
    protected def params_for(record, params, action_name)
      param_method = if respond_to?(:"permitted_attributes_for_#{action_name}")
        "permitted_attributes_for_#{action_name}"
      else
        "permitted_attributes"
      end

      required = params.require(
        PolicyFinder.new(record).param_key
      ).permit(
        *send(param_method)
      )
    end
  end
end
