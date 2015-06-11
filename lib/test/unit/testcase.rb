module Test
  module Unit
    AssertionFailedError = Class.new(StandardError)
    class TestCase
      def default_test; end
    end
  end
end
