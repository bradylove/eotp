defmodule Eotp.TotpTest do
  use ExUnit.Case, async: false

  import Mock

  doctest Eotp.Totp

  @test_secret "nftvbnyzojhhrgzt7lb3bo77mzbfp3r3"

  test "it generates an OTP for a given token" do
    token = %Eotp.Token{secret: @test_secret}
    result = Eotp.Totp.at(1444924687, token)

    assert result == "758729"
  end

  test "it is valid" do
    token = %Eotp.Token{secret: @test_secret}

    assert Eotp.Totp.valid_at?(1444924687, token, "758729")
  end
end
