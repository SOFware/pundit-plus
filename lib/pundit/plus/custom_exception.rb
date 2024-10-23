# frozen_string_literal: true

require "pundit"

module Pundit
  module Plus
    # This module is prepended to Pundit to allow for custom exceptions to be
    # raised by policies.
    module CustomException
      # This method is called by Pundit when a policy raises an exception.
      #
      # The default implementation raises the exception that was passed to
      # `authorize`, but you can override this method in your policy classes to
      # handle the exception differently.
      #
      # To make use of this method define the `exception_from` method in your
      # policy class.
      def raise(klass, query:, record:, policy:)
        super(policy.exception_from(query:), query: query, record: record, policy: policy)
      end
    end
  end
end

if Pundit.const_defined?(:Context)
  Pundit::Context.prepend(Pundit::Plus::CustomException)
else
  Pundit.singleton_class.prepend(Pundit::Plus::CustomException)
end
