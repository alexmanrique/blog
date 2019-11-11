require "minitest/autorun"
require "hoe"

Hoe.load_plugins # make sure Hoe::Test is loaded

class TestHoeTest < Minitest::Test
  def setup
    @tester = Module.new do
      include Hoe::Test

      extend self

      initialize_test

      def test_globs
        ["test/test_hoe_test.rb"]
      end
    end
  end

  def assert_deprecated
    err_re = /DEPRECATED:/

    assert_output "", err_re do
      yield
    end
  end

  def test_make_test_cmd_with_different_testlibs
    skip "Using TESTOPTS... skipping" if ENV["TESTOPTS"]

    expected = ['-w -Ilib:bin:test:. -e \'require "rubygems"; %s',
                'require "test/test_hoe_test.rb"',
                "' -- ",
               ].join

    # default
    assert_deprecated do
      autorun = %(require "minitest/autorun"; )
      assert_equal expected % autorun, @tester.make_test_cmd
    end

    assert_deprecated do
      @tester.testlib = :testunit
      testunit = %(require "test/unit"; )
      assert_equal expected % testunit, @tester.make_test_cmd
    end

    assert_deprecated do
      @tester.testlib = :minitest
      autorun = %(require "minitest/autorun"; )
      assert_equal expected % autorun, @tester.make_test_cmd
    end

    assert_deprecated do
      @tester.testlib = :none
      assert_equal expected % "", @tester.make_test_cmd
    end

    @tester.testlib = :faketestlib
    e = assert_raises(RuntimeError) do
      @tester.make_test_cmd
    end

    assert_equal "unsupported test framework faketestlib", e.to_s
  end
end
