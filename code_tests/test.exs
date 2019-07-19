defmodule Test do
  def probar(map, valor, hay?) do
    Enum.any?(map[:match], fn x ->
      cond do
        (is_binary(x) or is_list(x)) and String.starts_with?(valor, x) and not hay? -> true
        is_map(x) and valor =~ x and not hay? -> true
        true -> false
      end
    end)
  end
end

Test.probar(%{match: [["__ ", "\n"], ~r/^__[A-Za-z!¡¿?0-9]/]}, "__testo para empezar", false)
|> IO.inspect()
