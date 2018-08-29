require OK

defmodule Dictionary do

  def split_words(file_content) do
    String.split(file_content, "\n")
  end

  def word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!
  end

  def random_word do
    word_list()
    |> split_words
    |> Enum.random
  end

  def a({a,b}) do
    {b,a}
  end

  def b?({a,a}), do: true
  def b?({_,_}), do: false

  def sum_pairs([]), do: []
  def sum_pairs([h1,h2 | t]), do: [ h1+h2 | sum_pairs(t)]
  def sum_pairs([h | t]), do: [ h | t ]
end
