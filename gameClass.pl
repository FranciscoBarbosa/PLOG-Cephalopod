createPvPGame(Game):-
	emptyBoard(Board),
	Game = [Board, whitePlayer, pvp].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getPlayerName(whitePlayer, 'White').
getPlayerName(blackPlayer, 'Black').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getGameBoard([Board|_], Board).

getGamePlayerTurn(Game, Player):-
  nth1(2,Game,Player).
