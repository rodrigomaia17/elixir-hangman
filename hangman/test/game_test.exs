defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "initial state" do
    game = Game.new_game

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert MapSet.size(game.used) == 0
  end

  test "letters is lower case" do
    game = Game.new_game

    string_letters = Enum.join(game.letters)
    assert String.downcase(string_letters) == string_letters
  end

  test "make move does not change when game is won or lost" do
    for game_state <- [:won, :lost] do
      game = Game.new_game |> Map.put(:game_state, game_state)
      assert { ^game, _ } = Game.make_move(game, "x")
    end
  end

  test "make move checks if we already guessed a letter" do
    game = Game.new_game
    { new_game, _ } = Game.make_move(game, "x")
    assert new_game.game_state != :already_used
    assert MapSet.member?(new_game.used, "x")
    { new_game, _ } = Game.make_move(new_game, "x")
    assert new_game.game_state == :already_used
  end
  
  test "test good guess and you won" do
    {new_game, _} = %{Game.new_game | letters: ["o","i"], used: MapSet.new(["a","i"])}
               |> Game.make_move("o")

    assert new_game.game_state == :won
    assert MapSet.member?(new_game.used, "o")
  end

  test "test good guess and you not won" do
    {new_game , _ } = %{Game.new_game | letters: ["o","i"], used: MapSet.new(["a"])}
    |> Game.make_move("i")

    assert new_game.game_state == :good_guess
    assert MapSet.member?(new_game.used, "i")
  end

  test "test bad guess and you lose" do
    {new_game , _ } = %{Game.new_game | letters: ["o","i"], used: MapSet.new(["a"]), turns_left: 1}
    |> Game.make_move("z")

    assert new_game.game_state == :lost
    assert MapSet.member?(new_game.used, "z")
  end

  test "test bad guess and you not lose" do
    {new_game, _ } = %{Game.new_game | letters: ["o","i"], used: MapSet.new(["a"]), turns_left: 2}
    |> Game.make_move("z")

    assert new_game.game_state == :bad_guess
    assert new_game.turns_left == 1
    assert MapSet.member?(new_game.used, "z")
  end

end
