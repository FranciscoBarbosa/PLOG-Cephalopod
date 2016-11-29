createPvPGame(Game):-
 exampleboard2(Board),
 %emptyBoard(Board),
	Game = [Board, whitePlayer, pvp].

createPvBGame(Game):-
 exampleboard3(Board),
  %emptyBoard(Board),
	Game = [Board, whitePlayer, pvb].

createCvCGame(Game):-
 exampleboard4(Board),
  %emptyBoard(Board),
	Game = [Board, botPlayer, cvc].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getPlayerName(whitePlayer, 'White').
getPlayerName(blackPlayer, 'Black').
getPlayerName(botPlayer, 'Bot').
getPlayerName(computerPlayer, 'Computer').


getPieceValue(w1,1).
getPieceValue(w2,2).
getPieceValue(w3,3).
getPieceValue(w4,4).
getPieceValue(w5,5).
getPieceValue(w6,6).
getPieceValue(b1,1).
getPieceValue(b2,2).
getPieceValue(b3,3).
getPieceValue(b4,4).
getPieceValue(b5,5).
getPieceValue(b6,6).
getPieceValue(c1,1).
getPieceValue(c2,2).
getPieceValue(c3,3).
getPieceValue(c4,4).
getPieceValue(c5,5).
getPieceValue(c6,6).
getPieceValue(d1,1).
getPieceValue(d2,2).
getPieceValue(d3,3).
getPieceValue(d4,4).
getPieceValue(d5,5).
getPieceValue(d6,6).
getPieceValue(vazio,0).

getPiecePlayer(w1,whitePlayer).
getPiecePlayer(w2,whitePlayer).
getPiecePlayer(w3,whitePlayer).
getPiecePlayer(w4,whitePlayer).
getPiecePlayer(w5,whitePlayer).
getPiecePlayer(w6,whitePlayer).
getPiecePlayer(b1,blackPlayer).
getPiecePlayer(b2,blackPlayer).
getPiecePlayer(b3,blackPlayer).
getPiecePlayer(b4,blackPlayer).
getPiecePlayer(b5,blackPlayer).
getPiecePlayer(b6,blackPlayer).
getPiecePlayer(c1,botPlayer).
getPiecePlayer(c2,botPlayer).
getPiecePlayer(c3,botPlayer).
getPiecePlayer(c4,botPlayer).
getPiecePlayer(c5,botPlayer).
getPiecePlayer(c6,botPlayer).
getPiecePlayer(d1,computerPlayer).
getPiecePlayer(d2,computerPlayer).
getPiecePlayer(d3,computerPlayer).
getPiecePlayer(d4,computerPlayer).
getPiecePlayer(d5,computerPlayer).
getPiecePlayer(d6,computerPlayer).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%board
getGameBoard([Board|_], Board).

setGameBoard(Board, Game, ResultantGame):-
  setListElemAtWith(0, Board, Game, ResultantGame).

%player
getGamePlayerTurn(Game, Player):-
  nth1(2,Game,Player).

getGameMode(Game,Mode):-
  nth1(3,Game,Mode).

setGamePlayerTurn(Player, Game, ResultantGame):-
	setListElemAtWith(1, Player, Game, ResultantGame).
