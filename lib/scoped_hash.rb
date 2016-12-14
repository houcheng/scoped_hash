require 'mash'

class ScopedHash < Mash
  DEFAULT_LEFT_BRACKET = '('
  DEFAULT_RIGHT_BRACKET = ')'

  def initialize(args = {})
    super args

    @lbracket = DEFAULT_LEFT_BRACKET
    @rbracket = DEFAULT_RIGHT_BRACKET
  end

  def scope(scope)
    mash = Marshal.load(Marshal.dump(self))
    visit_scope(mash, scope)
    return mash
  end

  def set_bracket(bracket)
    if bracket.length != 2
      raise "Bracket length should be 2"
    end
    @lbracket = bracket[0]
    @rbracket = bracket[1]
  end

  private

  def visit_scope(mash, scope)
    scope_length = scope.length + 2
    scope_keys = []

    mash.each_key do |k|
      if k.end_with? "#{@lbracket}#{scope}#{@rbracket}"
        scope_keys << k
      end
    end

    scope_keys.each do |k|
      last_index = k.length - 1 - scope_length
      key = k[0..last_index]
      mash[key] = mash[k]
    end

    mash.each_pair do |k,v|
      if v.is_a?(Mash)
        visit_scope(v, scope)
      end
    end
  end
end
