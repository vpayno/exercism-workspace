local Queen = require('queen-attack')

describe('queen-attack', function()
  it('queen with a valid position', function()
    assert.has_no_error(function()
      Queen({ row = 2, column = 2 })
    end)
  end)

  it('queen must have a positive row', function()
    assert.has_error(function()
      Queen({ row = -2, column = 2 })
    end)
  end)

  it('queen must have row on board', function()
    assert.has_error(function()
      Queen({ row = 8, column = 4 })
    end)
  end)

  it('queen must have positive column', function()
    assert.has_error(function()
      Queen({ row = 2, column = -2 })
    end)
  end)

  it('queen must have column on board', function()
    assert.has_error(function()
      Queen({ row = 4, column = 8 })
    end)
  end)

  it('can not attack', function()
    local q1 = Queen({ row = 2, column = 4 })
    local q2 = Queen({ row = 6, column = 6 })
    assert.is_false(q1.can_attack(q2))
  end)

  it('can attack on same row', function()
    local q1 = Queen({ row = 2, column = 4 })
    local q2 = Queen({ row = 2, column = 6 })
    assert.is_true(q1.can_attack(q2))
  end)

  it('can attack on same column', function()
    local q1 = Queen({ row = 4, column = 5 })
    local q2 = Queen({ row = 2, column = 5 })
    assert.is_true(q1.can_attack(q2))
  end)

  it('can attack on first diagonal', function()
    local q1 = Queen({ row = 2, column = 2 })
    local q2 = Queen({ row = 0, column = 4 })
    assert.is_true(q1.can_attack(q2))
  end)

  it('can attack on second diagonal', function()
    local q1 = Queen({ row = 2, column = 2 })
    local q2 = Queen({ row = 3, column = 1 })
    assert.is_true(q1.can_attack(q2))
  end)

  it('can attack on third diagonal', function()
    local q1 = Queen({ row = 2, column = 2 })
    local q2 = Queen({ row = 1, column = 1 })
    assert.is_true(q1.can_attack(q2))
  end)

  it('can attack on fourth diagonal', function()
    local q1 = Queen({ row = 2, column = 2 })
    local q2 = Queen({ row = 5, column = 5 })
    assert.is_true(q1.can_attack(q2))
  end)
end)
