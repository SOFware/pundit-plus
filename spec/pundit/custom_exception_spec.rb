# frozen_string_literal: true

require "spec_helper"

class User
  def policy_class
    UserPolicy
  end
end

class UserPolicy
  include Pundit::Plus

  class CustomError < Pundit::NotAuthorizedError
    def initialize(options = {})
      options_with_message = options.dup
      options_with_message[:message] ||= "Custom exception from policy"
      super(options_with_message)
    end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    false
  end

  def create?
    false
  end

  def exception_from(query:)
    if query == :show?
      CustomError
    else
      super
    end
  end
end

RSpec.describe "Pundit.authorize" do
  it "raises a custom exception from the policy" do
    user = User.new
    query = :show?
    record = User.new

    expect do
      Pundit.authorize(user, record, query)
    end.to raise_error(UserPolicy::CustomError).with_message("Custom exception from policy")
  end

  it "raises a default exception from the policy" do
    user = User.new
    query = :create?
    record = User.new

    expect do
      Pundit.authorize(user, record, query)
    end.to raise_error(Pundit::NotAuthorizedError).with_message(/not allowed to UserPolicy#create?/)
  end
end
