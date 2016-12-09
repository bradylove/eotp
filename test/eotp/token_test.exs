#defmodule Eotp.TokenTest do
#  use ExUnit.Case
#
#  import Eotp.Token
#
#  test 'returns a uri that can be used with apps such as google authenticator' do
#    token = %Eotp.Token{}
#    uri = Eotp.Token.to_uri(token, "brady@eotp", "issuer")
#  end
#end
