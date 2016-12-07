require 'test/test_helper'

class ScopedHashTest < Minitest::Test

  def setup
    @smash = ScopedHash.new 'foo': 3
  end

  def test_get_scope
    @smash['foo(scope1)'] = 4

    assert_equal 3, @smash[:foo]
    assert_equal 4, @smash.scope('scope1')[:foo]
  end

  def test_get_scope_fallback
    smash = ScopedHash.new 'foo': 3, 'foo(scope1)': 4

    assert_equal 3, smash.foo
    assert_equal 3, smash.scope('scope2')[:foo]
  end

  def test_bracket
    @smash['foo[scope1]'] = 4

    assert_equal 3, @smash['foo']
    assert_equal 3, @smash.scope('scope1')[:foo]

    @smash.set_bracket('[]')
    assert_equal 4, @smash.scope('scope1')[:foo]
  end

  def test_get_scope_deep
    smash = ScopedHash.new 'foo': { 'bar': 3,'bar(scope1)': 4 }

    assert_equal 3, smash.foo.bar
    assert_equal 4, smash.scope('scope1')[:foo][:bar]
  end

  def test_get_scope_deep_fallback
    smash = ScopedHash.new({
      'foo': {
        'bar': 3,
        'bar[scope1]': 4
      }
    })

    assert_equal 3, smash.foo.bar
    assert_equal 3, smash.scope('scope2')[:foo][:bar]
  end

  def test_get_scope_tree
    smash = ScopedHash.new(
      'foo': { 'bar': 3 },
      'foo(scope1)': { 'bar': 4 }
    )
    assert_equal 3, smash.foo.bar
    assert_equal 4, smash.scope('scope1')[:foo][:bar]
  end


  def test_many_scopes
    smash = ScopedHash.new({
      'foo': {
        'bar': 3,
        'bar(scope1)': 4,
        'bar(scope2)': 5
      }
    })

    assert_equal 3, smash.foo.bar
    assert_equal 4, smash.scope('scope1')[:foo][:bar]
    assert_equal 5, smash.scope('scope2')[:foo][:bar]
  end

end
