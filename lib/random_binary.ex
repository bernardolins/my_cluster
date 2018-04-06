defmodule RandomBinary do
  def generate(bytes \\ 32) do
    ((for _ <- 1..(bytes-1), do: 32 + :rand.uniform(95) - 1) ++ '\n')
    |> to_string
  end
end
