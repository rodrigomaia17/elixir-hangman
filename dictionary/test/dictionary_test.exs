require OK
defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "split file content on list of words" do
    assert length(Dictionary.split_words("some\nrandom\nwords")) == 3
  end

  test "a" do
    assert Dictionary.a({2,5}) == {5,2}
  end

  test "b" do
    assert Dictionary.b?({2,5}) == false
    assert Dictionary.b?({2,2}) == true
  end
  
  test "sum_pairs" do
    assert Dictionary.sum_pairs([]) == []
    assert Dictionary.sum_pairs([1,2]) == [3]
    assert Dictionary.sum_pairs([1,2,3,4]) == [3,7]
    assert Dictionary.sum_pairs([1,2,3]) == [3,3]
  end

end
