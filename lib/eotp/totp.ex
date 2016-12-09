defmodule Eotp.Totp do
  use Bitwise

  def valid?(token = %Eotp.Token{}, code), do: now(token) == code

  def valid_at?(unix_time, token = %Eotp.Token{}, code) do
    at(unix_time, token) == code
  end

  def now(token = %Eotp.Token{}), do: at(current_time, token)

  def at(unix_time, token = %Eotp.Token{}) do
    get_hmac(token.secret, div(unix_time, token.period))
    |> hmac_to_code
    |> code_to_otp(token.digits)
  end

  defp code_to_otp(code, n) do
    rem(code, round(:math.pow(10, n)))
    |> Integer.to_string
    |> pad_otp(n)
  end

  defp pad_otp(otp, total_length) do
    pad_size = total_length - String.length(otp)

    String.duplicate("0", pad_size) <> otp
  end

  defp get_hmac(secret, time_code) do
    :crypto.hmac(
      :sha,
      Eotp.Base32.decode(secret),
      integer_to_byte_list(time_code))
    |> :binary.bin_to_list
  end

  defp hmac_to_code(hmac) do
    offset = Enum.at(hmac, -1) &&& 0xf

    (Enum.at(hmac, offset) &&& 0x7f) <<< 24 |||
    (Enum.at(hmac, offset + 1) &&& 0xff) <<< 16 |||
    (Enum.at(hmac, offset + 2) &&& 0xff) <<< 8 |||
    (Enum.at(hmac, offset + 3) &&& 0xff)
  end

  defp integer_to_byte_list(int) do
    for n <- 7..0, x = 8 * n, do: (int >>> x) &&& 0xFF
  end

  defp current_time do
    {:ok, time} = Timex.now("UTC")
    |> Timex.Format.DateTime.Formatter.format("{s-epoch}")

    {time, _} = Integer.parse(time)
    time
  end
end