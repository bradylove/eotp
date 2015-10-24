defmodule Eotp.TokenTest do
  use ExUnit.Case

  it 'returns a uri that can be used with apps such as google authenticator' do
    token = %Token{}
    uri = Token.to_uri(token, "brady@eotp", "issuer")

  end
end
