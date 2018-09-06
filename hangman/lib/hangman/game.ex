defmodule Hangman.Game do

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )


  def new_game do
    %Hangman.Game{
      letters: Dictionary.random_word |> String.codepoints
    }
  end

  def make_move(game = %{ game_state: state} , _guess) when state in [:won, :lost] do
    { game, tally(game)}
  end

  def make_move(game, guess) do
    already_guessed_key = MapSet.member?(game.used, guess)
    game = accept_move(game, guess, already_guessed_key )
    { game, tally(game)}
  end

  def accept_move(game, _guess, true) do
    %{game | game_state: :already_used}
  end

  def accept_move(game, guess, _ ) do
    game
    |> Map.put(:used, MapSet.put(game.used, guess))
    |> checkScore(guess in game.letters)
  end

  def checkScore(game, _good_guess = true) do
    letters_set = MapSet.new(game.letters)
    new_state = MapSet.subset?(letters_set, game.used)
                 |> check_win
    %{game | game_state: new_state}
  end
  def checkScore(game, _bad_guess) do
    turns = game.turns_left - 1
    game
    |> Map.put(:turns_left, turns)
    |> Map.put(:game_state, check_loss(turns))
  end

  def check_win(true), do: :won
  def check_win(_), do: :good_guess
  def check_loss(0), do: :lost
  def check_loss(_), do: :bad_guess

  def tally(_game) do
  end
end
