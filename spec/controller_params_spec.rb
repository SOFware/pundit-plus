# frozen_string_literal: true

require "spec_helper"
# -- Why doesn't strog_parameters require these if it needs them?
require "active_support"
require "active_support/core_ext"
# --
require "action_controller/metal/strong_parameters"

class Account
end

class AccountPolicy
  include Pundit::Plus
  def initialize(user, record)
    @user = user
    @record = record
  end
  attr_reader :user, :record

  def params_for_create(params)
    params_for(record, params, :create).tap do |params|
      params.require(:special)
    end
  end

  def permitted_attributes_for_create
    %i[name special]
  end

  def permitted_attributes
    %i[name special other]
  end

  def params_for_other(params)
    params_for(record, params, :other)
  end
end

RSpec.describe "Controller params_for_action" do
  it "returns the params for the specified action" do
    account = Account.new
    params = ActionController::Parameters.new({
      account: {
        name: "test",
        other: "value"
      }
    })
    controller = Controller.new(account, :create, params)
    expect do
      controller.params_for_action(account)
    end.to raise_error(
      ActionController::ParameterMissing,
      "param is missing or the value is empty: special"
    )
  end

  it "returns the permitted attributes for the specified action" do
    account = Account.new
    params = ActionController::Parameters.new({
      account: {
        name: "test",
        special: "value"
      }
    })
    controller = Controller.new(account, :update, params)
    expect(controller.params_for_action(account).to_h).to eq(
      {"name" => "test", "special" => "value"}
    )
  end

  it "returns the permitted attributes for the specified action" do
    account = Account.new
    params = ActionController::Parameters.new({
      account: {
        name: "test",
        other: "value"
      }
    })
    controller = Controller.new(account, :other, params)
    expect(controller.params_for_action(account).to_h).to eq(
      {
        "name" => "test",
        "other" => "value"
      }
    )
  end
end
