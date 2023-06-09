defmodule Numbers do

  def prime?(2), do: :true
  def prime?(num) do
    last = num
            |> :math.sqrt
            |> Float.ceil
            |> trunc
    notprime = 2..last
      |> Enum.any?(fn a -> rem(num, a)==0 end)
    !notprime
  end

  def nextprime(num) do
    cond do
      prime?(num + 1) -> num + 1
      true -> nextprime(num + 1)
    end
  end

  def nthprime(n) do
    Stream.iterate(2, &nextprime/1)
        |> Enum.at(n-1)
  end

  def divisors(num) do
    do_divisors(num, 1)
  end

  defp do_divisors(num, n) do
    cond do
      prime?(num) -> [num]
      rem(num, nthprime(n))==0 ->
        [nthprime(n) |
        do_divisors(trunc(num/nthprime(n)), n)]
      true -> do_divisors(num, n+1)
    end
  end

end