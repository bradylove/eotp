defmodule Eotp.Base32 do
  def random(size \\ 20) do
    :crypto.strong_rand_bytes(size)
    |> Base.encode32(case: :lower)
  end

  def decode(secret) do
    Base.decode32!(secret, case: :lower)
  end
end
