ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ConstantReplacementHelper
  def with_constant_replaced(namespace, constant_name, replacement)
    original = namespace.const_get(constant_name)
    namespace.send(:remove_const, constant_name)
    namespace.const_set(constant_name, replacement)

    yield
  ensure
    namespace.send(:remove_const, constant_name)
    namespace.const_set(constant_name, original)
  end
end

module ActiveSupport
  class TestCase
    include ConstantReplacementHelper

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Add more helper methods to be used by all tests here...
  end
end

class ActionDispatch::IntegrationTest
  include ConstantReplacementHelper
end
