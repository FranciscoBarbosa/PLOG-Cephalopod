:- use_module(library(system)).
:- use_module(library(lists)).
:- include('utilities.pl').
:- include('menus.pl').
:- include('gameClass.pl').
:- include('gameBoard.pl').


cephalopod:-
  mainMenu.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

playGame(Game):-
  getGameBoard(Game, Board),
%%  checkBoardHasEmptySpace(Board),
  letHumanPlay(Game, ResultantGame),
  playGame(ResultantGame).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

letHumanPlay(Game, ResultantGame):-
  getGameBoard(Game, Board),
  getGamePlayerTurn(Game, Player),

%%  repeat,

  printBoard(Board),
  printTurnInfo(Player), nl, nl,
  getCoordsToPlacePiece(Row, Col),

  checkCellEmpty(Row,Col).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%checkBoardHasEmptySpace([H|T]):-

checkCellEmpty

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

printTurnInfo(Player):-
  getPlayerName(Player, PlayerName),
  write('# It is '), write(PlayerName), write(' player\'s turn to play.'), nl, !.

getCoordsToPlacePiece(SrcRow, SrcCol):-
	write('Please insert the coordinates where you want to place a piece and press <Enter> - example: 3f.'), nl,
	inputCoords(Row, Col), nl.

inputCoords(Row, Col):-
	getInt(RawRow),
	getInt(RawCol),
	% discard enter
	discardInputChar,
	% process row and column
	Row is RawRow-1,
	Col is RawCol-49.
