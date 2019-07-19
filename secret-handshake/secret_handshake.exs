defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  # primera prueba hecha por mi
  # def commands(code) when code > 31 or code == 0 do
  #   []
  # end

  @actions %{
    0b1 => "wink",
    0b10 => "double blink",
    0b100 => "close your eyes",
    0b1000 => "jump"
  }

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    # ops =
    #   Map.keys(@actions)
    #   |> Enum.map(fn x -> IO.inspect(@actions[x &&& code]) end)
    #   |> IO.inspect(label: "resultado")
    #   |> Enum.reject(&is_nil/1)

    ops = for key <- Map.keys(@actions), (n = @actions[key &&& code]) != nil, do: n

    if (code &&& 0b10000) > 0, do: Enum.reverse(ops), else: ops
  end

  # def commands(code) do
  #   commands = []
  #   <<empty::27,reverse::1,jump::1,close::1,doubleblink::1,wink::1>> = <<code::32>>
  #   commands = if jump == 1 do [ "jump" | commands ] else commands end
  #   commands = if close == 1 do [ "close your eyes" | commands ] else commands end
  #   commands = if doubleblink == 1 do [ "double blink" | commands ] else commands end
  #   commands = if wink == 1 do [ "wink" | commands ] else commands end
  #   if reverse == 1 do Enum.reverse(commands) else commands end
  # end

  # def commands(code) do
  #   points = %{
  #     0b1 => "wink",
  #     0b10 => "double blink",
  #     0b100 => "close your eyes",
  #     0b1000 => "jump"
  #   }

  #   actions =
  #     Enum.reduce(points, [], fn {k, val}, acc ->
  #       if (code &&& k) === k do
  #         [val | acc]
  #       else
  #         acc
  #       end
  #     end)

  #   if (code &&& 0b10000) === 0b10000, do: Enum.reverse(actions), else: actions
  # end

  # primera prueba hecha por mi
  # def commands(code) do
  #   code
  #   |> Integer.to_string(2)
  #   |> String.reverse()
  #   |> do_decode_handshake()
  # end

  # defp do_decode_handshake(_list, i \\ 1, acumulado \\ [])

  # defp do_decode_handshake("", _i, acumulado), do: acumulado

  # defp do_decode_handshake(<<head>> <> tail, i, acumulado) do
  #   acum =
  #     cond do
  #       head == ?1 and i == 1 -> acumulado ++ ["wink"]
  #       head == ?1 and i == 2 -> acumulado ++ ["double blink"]
  #       head == ?1 and i == 3 -> acumulado ++ ["close your eyes"]
  #       head == ?1 and i == 4 -> acumulado ++ ["jump"]
  #       head == ?1 and i == 5 -> Enum.reverse(acumulado)
  #       true -> acumulado ++ []
  #     end

  #   do_decode_handshake(tail, i + 1, acum)
  # end
  # primera prueba hecha por mi - END
end

# Enum.map(1..32, fn n ->
#   SecretHandshake.commands(n)
#   |> IO.inspect(label: n)
# end)
