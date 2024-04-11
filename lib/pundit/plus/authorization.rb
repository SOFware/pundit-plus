# frozen_string_literal: true

require "pundit"

module Pundit
  module Plus
    # This module adds to the Pundit::Authorization module so that anywhere it is
    # included will also receive the methods added in this.
    module Authorization
      # Return the params that are required or permitted for the given action.
      #
      # Define a method in your policy class called `params_for_#{action}` to
      # return the params for that action. If no such method exists, then
      # `permitted_attributes` is called to return the params.
      #
      # In your policy, define the relevant method to receive parameters and
      # specify permitted or required parameters.
      #
      # @example
      #   class MyPolicy < ApplicationPolicy
      #      def params_for_create(params)
      #        params.require(:user).permit(*permitted_attributes_for_create).tap do |permitted|
      #          permitted.require(:special_value)
      #        end
      #      end
      #    end
      def params_for_action(record, action = action_name)
        if policy(record).respond_to?(:"params_for_#{action}")
          policy(record).send(:"params_for_#{action}", params)
        else
          permitted_attributes(record, action)
        end
      end
    end
  end
end
Pundit::Authorization.include(Pundit::Plus::Authorization)
