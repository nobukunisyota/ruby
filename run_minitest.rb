def isTrue
    return false
end

require 'minitest/autorun'

class GithubActionTest < Minitest::Test
    def test_sample
        assert_equal true, isTrue()
    end
end
