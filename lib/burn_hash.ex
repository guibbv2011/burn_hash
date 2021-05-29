defmodule BurnHash do

  def sha512_unicode(data) do
    hash_binary = :crypto.hash(:sha512, "#{data}\n")

    codepoints = String.codepoints(hash_binary)

    val = Enum.reduce(codepoints, fn(w, result) ->
      cond do 
        String.valid?(w) -> result <> w 
        true -> 
          << parsed :: 8>> = w 
          result <> << parsed :: utf8 >>
      end
    end)

    result_base64 = Base.encode64(val, case: :lower)

    IO.puts result_base64
  end

  def sha256_hash(data) do
    secret_hash = :crypto.hash(:sha256, "#{data}\n") |> Base.encode64(case: :lower)
    IO.puts(secret_hash)
  end
end
