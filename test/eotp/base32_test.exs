defmodule Eotp.Base32Test do
  use ExUnit.Case

  test "it generates a random 16 byte base32 secret" do
    result = Base.decode32!(Eotp.Base32.random, case: :lower)

    assert byte_size(result) == 20
  end

  test "it generates a random byte base32 secret of a given size" do
    result = Base.decode32!(Eotp.Base32.random(24), case: :lower)

    assert byte_size(result) == 24
  end

  test "it decodes a base32 encoded secret" do
    secret = "72n3imk5rg3f7kppbvuaoy67k4======"
    expected = <<254, 155, 180, 49, 93, 137, 182, 95, 169, 239, 13, 104, 7, 99, 223, 87>>
    result = Eotp.Base32.decode(secret)

    assert result == expected
  end
end
