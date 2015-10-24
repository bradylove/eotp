defmodule Eotp.Token do
  defstruct secret: Eotp.Base32.random, digits: 6, period: 30, drift: 0
end
