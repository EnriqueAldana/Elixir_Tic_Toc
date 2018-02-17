defmodule Tic_Toc do
  @moduledoc """
   This is the Tic Toc module.
   This module is an implementation for Tic Toc game
   It is a basic implementation to get knowledge about
   tuples, if conditions and recursivity funtions.

   How to use:
   1.- The game ask you about the gamers names like this:
   Input the name for first player with the X turn :
   Input the name for second player with the O turn :

2.- The game shows the dashboard like This
   Tic Toc Dashboard
   Player One with X turn :  Carolina
   Player Two with O turn :  Enrique

     D E F
   A 1 2 3
   B 4 5 6
   C 7 8 9

3.- The game asks to the player about will be the selection choice.
The gamer would selected ones number between 1 to 9
Input the number that you want play with X turn :

4.- The game will update the dashboard and turn on to the next player ans so on.
5.- The game will validates the dashboard status on every move to determinates the game result.


   Author : Jesus Enrique Aldana Sanchez
   Date : February 17 2018
   Version : 0.1
   """
   @doc """
     start function is the begin of the program to start it.

     Returns `:ok` when the program has been finished.

     ## Examples to run

         iex> c("tic_toc.ex")
         [Tic_Toc]
         iex> Tic_Toc.start

     """
def start do

  play_list_tuple = {1,2,3,4,5,6,7,8,9}
  name_players= players_name()
  dashboard(name_players,play_list_tuple)
  # start the game
  player_turn_initial= "X"
  play(name_players,play_list_tuple,player_turn_initial)

end

defp play(player_name) do
  IO.puts "The winner is  #{player_name}"
end
@doc """
  The play function is a recursive function to play the game.

  Output Call functions to:

  play(player_name) function to declare a winner.
   or
  the_game_is_tie() function if the game is tie.

  """
defp play(name_players,play_list_tuple, player_turn) do

        if player_turn == "X" do
            # To validate if the board represent a tie
            if (is_tie(play_list_tuple, tuple_size(play_list_tuple))) do
              the_game_is_tie()
            else
              index = get_only_numbers(1,9,"Input the number that you want play with X turn : ")
              if position_is_free_to_play(play_list_tuple,index - 1) do
                tuple_deleted = Tuple.delete_at(play_list_tuple,index - 1)
                tuple_played = Tuple.insert_at(tuple_deleted,index - 1,"X")
                dashboard(name_players, tuple_played)
                if validate_all_win_rules(tuple_played,"X"), do: play(elem(name_players,0)), else: play(name_players,tuple_played, "O")
              else
                play(name_players,play_list_tuple, "X")
              end
          end # End from game is Tie
        else
            # To validate if the board represent a tie
            if (is_tie(play_list_tuple, tuple_size(play_list_tuple))) do
              the_game_is_tie()
            else
              index_O = get_only_numbers(1,9,"Input the number that you want play with O turn : " )
              if position_is_free_to_play(play_list_tuple,index_O - 1) do
                tuple_deleted_O = Tuple.delete_at(play_list_tuple,index_O - 1)
                tuple_played_O = Tuple.insert_at(tuple_deleted_O,index_O - 1 ,"O")
                dashboard(name_players, tuple_played_O)
                if validate_all_win_rules(tuple_played_O,"O"), do: play(elem(name_players,1)), else: play(name_players,tuple_played_O, "X")
              else
                play(name_players,play_list_tuple, "O")
              end
            end # End from game is Tie
        end # End of player_turn

end
@doc """
  validate_all_win_rules function is useful to determinate if the gamer is the winner.

  Returns
  true if there is a win rule.
  false if there is not a win rule.
  """
defp validate_all_win_rules(play_list_tuple,player_turn) do

    # 123 win rule
    cond do
      elem(play_list_tuple,0)== player_turn and elem(play_list_tuple,1) == player_turn and elem(play_list_tuple,2) == player_turn -> true
      elem(play_list_tuple,3)== player_turn and elem(play_list_tuple,4) == player_turn and elem(play_list_tuple,5) == player_turn -> true
      elem(play_list_tuple,6)== player_turn and elem(play_list_tuple,7) == player_turn and elem(play_list_tuple,8) == player_turn -> true
      elem(play_list_tuple,0)== player_turn and elem(play_list_tuple,3) == player_turn and elem(play_list_tuple,6) == player_turn -> true
      elem(play_list_tuple,1)== player_turn and elem(play_list_tuple,4) == player_turn and elem(play_list_tuple,7) == player_turn -> true
      elem(play_list_tuple,2)== player_turn and elem(play_list_tuple,5) == player_turn and elem(play_list_tuple,8) == player_turn -> true
      elem(play_list_tuple,0)== player_turn and elem(play_list_tuple,4) == player_turn and elem(play_list_tuple,8) == player_turn -> true
      elem(play_list_tuple,2)== player_turn and elem(play_list_tuple,4) == player_turn and elem(play_list_tuple,6) == player_turn -> true
      true -> false
    end
end
@doc """
  players_name function is useful to get the names of the gamers.

  Returns
  a tuple with both game names
  """
defp players_name do
  player1 = IO.gets("Input the name for first player with the X turn : ")
  player2 = IO.gets("Input the name for second player with the O turn : ")
  {player1,player2}
end
@doc """
  dashboard function is useful to print on console the dashboard .

  Printing at console the dashboard like :

  Tic Toc Dashboard
  Player One with X turn :  Carolina
  Player Two with O turn :  Enrique

    D E F
  A 1 2 3
  B 4 5 6
  C 7 8 9

  """
defp dashboard(name_players, play_list_tuple) do
IO.puts "Tic Toc Dashboard"
IO.puts "Player One with X turn : #{elem(name_players,0)} "
IO.puts "Player Two with O turn : #{elem(name_players,1)} "
IO.puts ""
IO.puts "  D E F"
IO.puts "A #{elem(play_list_tuple,0)} #{elem(play_list_tuple,1)} #{elem(play_list_tuple,2)}"
IO.puts "B #{elem(play_list_tuple,3)} #{elem(play_list_tuple,4)} #{elem(play_list_tuple,5)}"
IO.puts "C #{elem(play_list_tuple,6)} #{elem(play_list_tuple,7)} #{elem(play_list_tuple,8)}"
end

defp position_is_free_to_play(play_list_tuple, index) do
    if elem(play_list_tuple,index) != "X" and elem(play_list_tuple,index) != "O", do: true , else: false
end

defp the_game_is_tie() do
  IO.puts "The game is tie "
end

defp is_tie(play_list_tuple, 0) do
  true
end

@doc """
  is_tie(play_list_tuple, index) is a function to determinate if the game is tie.
  This function is called every move.

  It function get values from the dashboard tuple and compare with "X" or "O" sign
  if all values of dashboard tuple are "X" or "O" the game wiil be tie.

  Returns
  true if all values are "X" or "O"
  false if this is at least one value different of "X" or "O"

"""
defp is_tie(play_list_tuple, index) do
    if elem(play_list_tuple, index - 1 ) != "X" and elem(play_list_tuple, index - 1) != "O" do
      false
    else
      is_tie(play_list_tuple, index - 1)
    end
end
defp get_only_numbers(num) do
  num
end
@doc """
  get_only_numbers(min,max,message) is a recursive function to get only numbers from the console input device.

  Receives
    This function receives a three parameter values
      min - minimum value of the range specified
      max - maximum value of the range specified
      message - message to display to the user on console
  Returns
   It return just a valid number between a range specified from parameters.
"""
defp get_only_numbers(min,max,message) do
        ent = IO.gets message
        case Integer.parse(ent) do
            :error -> get_only_numbers(min,max,message)
            {num,_} -> if min <= num and num <= max , do: get_only_numbers(num), else: get_only_numbers(min,max,message)
        end

end

end # End defmodule
