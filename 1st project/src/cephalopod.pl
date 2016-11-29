:- use_module(library(system)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- include('utilities.pl').
:- include('menus.pl').
:- include('gameClass.pl').
:- include('gameBoard.pl').
:-cephalopod.

cephalopod:-
  mainMenu.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

playGame(Game):-
  getGameMode(Game,Mode),
  getGameBoard(Game, Board),
  checkBoardHasEmptySpace(Board),
  (
	Mode=pvp->
	letHumanPlay(Game, ResultantGame),
	playGame(ResultantGame);

	Mode=pvb->
	playVsBot(Game,ResultantGame),
	playGame(ResultantGame);

	Mode=cvc->
	computerVsComputer(Game,ResultantGame),
	playGame(ResultantGame)
  ).


  playGame(Game):-
  getGameMode(Game,Mode),
  getGameBoard(Game, Board),
  printBoard(Board),
%  trace,
  (
    Mode=pvp->checkGameWinner(Board,Player,whitePlayer,blackPlayer);
    Mode=pvb->checkGameWinner(Board,Player,whitePlayer,botPlayer);
    Mode=cvc->checkGameWinner(Board,Player,botPlayer,computerPlayer)
    ),
  printGameOverMessage(Player).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

letHumanPlay(Game, ResultantGame):-
  getGameBoard(Game, Board),
  getGamePlayerTurn(Game, Player),

  repeat,

  printBoard(Board),
  printTurnInfo(Player), nl, nl,
  getCoordsToPlacePiece(Row, Col),

%  write('yo1'),nl,
  checkCellEmpty(Row,Col,Board),
%  write('yo2'),nl,
  checkAroundCell(Row,Col,Board,AdjacentCells),
%  write('yo3'),nl,
  checkAdjacentCellsNotEmpty(AdjacentCells, NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty),
%  write('yo4'),nl,
  checkSumAdjacentCells(AdjacentCells,SumAdjacentCells),
%  write('yo5'),nl,

  checkPossibleToCapture(NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty, PossibleToCapture),
%  write('yo6'),nl,
  (
  PossibleToCapture =0 -> write('Impossible to capture'),  CapturedBoard = Board, NewPieceValue is 1;
  PossibleToCapture =1 -> write('Possible to capture 2'),nl,
                          getDirectionOfTwoPieces(AdjacentCells,DirectionsToCapture),
                          write(DirectionsToCapture),nl,
                          capturePieces(Row,Col,DirectionsToCapture,AdjacentCells,Board,CapturedBoard),
                          write('Yo1'),nl,%trace,
                          getNewPieceValue(DirectionsToCapture,AdjacentCells,NewPieceValue),
                          write(NewPieceValue),nl;
  PossibleToCapture =2 -> write('Possible to capture >2'),nl,
                          getNumberofPiecesToCapture(NumPiecesToCapture),
                          getDirectionsToCapture(NumPiecesToCapture,DirectionsToCapture),
                          capturePieces(Row,Col,DirectionsToCapture,AdjacentCells,Board,CapturedBoard),
                          getNewPieceValue(DirectionsToCapture,AdjacentCells,NewPieceValue)
  ),

  getPieceValue(NewPiece,NewPieceValue),
  getPiecePlayer(NewPiece,Player),
  setMatrixElemAtWith(Row, Col, NewPiece, CapturedBoard, NewBoard),

  setGameBoard(NewBoard, Game, Game2),
  changePlayer(Game2, ResultantGame),
  clearConsole.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
playVsBot(Game,ResultantGame):-
  getGameBoard(Game,Board),
  getGamePlayerTurn(Game,Player),


  repeat,
  printBoard(Board),
  printTurnInfo(Player),%%nl, nl,
  (
  Player=botPlayer ->
  getCoordsBot(Board,Row,Col);

  Player=whitePlayer ->
  getCoordsToPlacePiece(Row,Col)
  ),
%  write('yo1'),nl,
  checkCellEmpty(Row,Col,Board),
%  write('yo2'),nl,
  checkAroundCell(Row,Col,Board,AdjacentCells),
%  write('yo3'),nl,
  checkAdjacentCellsNotEmpty(AdjacentCells, NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty),
%  write('yo4'),nl,
  checkSumAdjacentCells(AdjacentCells,SumAdjacentCells),
%  write('yo5'),nl,

  checkPossibleToCapture(NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty, PossibleToCapture),
%  write('yo6'),nl,
(
  PossibleToCapture =0 -> write('Impossible to capture'),  CapturedBoard = Board, NewPieceValue is 1;
  PossibleToCapture =1 -> write('Possible to capture 2'),nl,
                          getDirectionOfTwoPieces(AdjacentCells,DirectionsToCapture),
                          %write(DirectionsToCapture),nl,
                          capturePieces(Row,Col,DirectionsToCapture,AdjacentCells,Board,CapturedBoard),
                          getNewPieceValue(DirectionsToCapture,AdjacentCells,NewPieceValue),nl;
  PossibleToCapture =2 -> write('Possible to capture >2'),nl,
                          (
                          Player=botPlayer ->
                          botGetNumberOfPiecesToCapture(NumPiecesToCapture),
                          botGetDirectionsToCapture(DirectionsToCapture);
                          Player=whitePlayer ->
                          getNumberofPiecesToCapture(NumPiecesToCapture),
                          getDirectionsToCapture(NumPiecesToCapture,DirectionsToCapture)
                          ),

                          capturePieces(Row,Col,DirectionsToCapture,AdjacentCells,Board,CapturedBoard),
                          getNewPieceValue(DirectionsToCapture,AdjacentCells,NewPieceValue)
  ),

%  write(AdjacentCells),nl,

  getPieceValue(NewPiece,NewPieceValue),
  getPiecePlayer(NewPiece,Player),
  setMatrixElemAtWith(Row, Col, NewPiece, CapturedBoard, NewBoard),

  setGameBoard(NewBoard, Game, Game2),
%  write(Game2),
  changeBot(Game2, ResultantGame),
%  write(ResultantGame),
  clearConsole.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
computerVsComputer(Game,ResultantGame):-
  getGameBoard(Game,Board),
  getGamePlayerTurn(Game,Player),


  repeat,
  printBoard(Board),
  printTurnInfo(Player),%%nl, nl,
  getCoordsBot(Board,Row,Col),
  checkCellEmpty(Row,Col,Board),
  checkAroundCell(Row,Col,Board,AdjacentCells),
  checkAdjacentCellsNotEmpty(AdjacentCells, NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty),
  checkSumAdjacentCells(AdjacentCells,SumAdjacentCells),
  %  write(AdjacentCells),nl,
  checkPossibleToCapture(NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty, PossibleToCapture),
  (
  PossibleToCapture =0 -> write('Impossible to capture'),  CapturedBoard = Board, NewPieceValue is 1;
  PossibleToCapture =1 -> write('Possible to capture 2'),nl,
                          getDirectionOfTwoPieces(AdjacentCells,DirectionsToCapture),
                      %    write(DirectionsToCapture),nl,
                          capturePieces(Row,Col,DirectionsToCapture,AdjacentCells,Board,CapturedBoard),
                          getNewPieceValue(DirectionsToCapture,AdjacentCells,NewPieceValue),
						  nl;
  PossibleToCapture =2 -> write('Possible to capture >2'),nl,
                          botGetNumberOfPiecesToCapture(NumPiecesToCapture),
                  %        write(NumPiecesToCapture),
                          botGetDirectionsToCapture(DirectionsToCapture),
                  %        write(DirectionsToCapture),
                          capturePieces(Row,Col,DirectionsToCapture,AdjacentCells,Board,CapturedBoard),
                          getNewPieceValue(DirectionsToCapture,AdjacentCells,NewPieceValue),
                %          write(NewPieceValue),
                          NewPieceValue<7
  ),

%  write(AdjacentCells),nl,
  getPieceValue(NewPiece,NewPieceValue),
  getPiecePlayer(NewPiece,Player),
  setMatrixElemAtWith(Row, Col, NewPiece, CapturedBoard, NewBoard),

  setGameBoard(NewBoard, Game, Game2),
  changeComputer(Game2, ResultantGame),
  clearConsole.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getCoordsBot(Board,Row,Col):-
repeat,
random(0,5,Row),
random(0,5,Col),
checkCellEmpty(Row,Col,Board),!.
%write(index).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
checkBoardHasEmptySpace([]):-fail.
checkBoardHasEmptySpace([H|T]):-
  checkLineHasEmptySpace(H).
checkBoardHasEmptySpace([H|T]):-
  checkBoardHasEmptySpace(T).

checkLineHasEmptySpace([]):-fail.
checkLineHasEmptySpace([vazio|T]):-
  H=vazio.
checkLineHasEmptySpace([H|T]):-
  checkLineHasEmptySpace(T).

checkCellEmpty(Row,Col,Board):-
  getMatrixElemAt(Row, Col, Board, vazio),!.
checkCellEmpty(_,_,_):-
  write('ERROR: Invalid Cell'), nl,fail.

checkAroundCell(Row,Col,Board,AdjacentCells):-
  Up is Row-1,
  (getMatrixElemAt(Up,Col,Board,Elem1);Elem1=vazio),
  Right is Col+1,(getMatrixElemAt(Row,Right,Board,Elem2);Elem2=vazio),
  Down is Row+1,(getMatrixElemAt(Down,Col,Board,Elem3);Elem3=vazio),
  Left is Col-1,(getMatrixElemAt(Row,Left,Board,Elem4);Elem4=vazio),
  AdjacentCells = [Elem1, Elem2, Elem3, Elem4],!.

checkAdjacentCellsNotEmpty(AdjacentCells, NumAdjacentCellsNotEmpty,AdjacentCellsNotEmpty):-
  checkAdjacentCellsNotEmpty(AdjacentCells, NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty,0,[]),!.
checkAdjacentCellsNotEmpty([], NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty, Counter,TempList):-
  NumAdjacentCellsNotEmpty=Counter,
  AdjacentCellsNotEmpty=TempList.
checkAdjacentCellsNotEmpty([H|T], NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty, Counter,TempList):-
  H\=vazio,
  Counter1 is Counter +1,
  append(TempList,[H],AdjacentCellsNotEmpty1),
  checkAdjacentCellsNotEmpty(T,NumAdjacentCellsNotEmpty,AdjacentCellsNotEmpty,Counter1,AdjacentCellsNotEmpty1).
checkAdjacentCellsNotEmpty([H|T], NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty, Counter, TempList):-
  checkAdjacentCellsNotEmpty(T,NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty, Counter,TempList).

checkSumAdjacentCells(AdjacentCells,SumAdjacentCells):-
  checkSumAdjacentCells(AdjacentCells, SumAdjacentCells, 0).
checkSumAdjacentCells([],SumAdjacentCells, Counter):-
  SumAdjacentCells=Counter.
checkSumAdjacentCells([H|T],SumAdjacentCells,Counter):-
  getPieceValue(H,Value),
  Counter1 is Counter + Value,
  checkSumAdjacentCells(T,SumAdjacentCells,Counter1).

%checkPossibleToCapture(NumAdjacentCellsNotEmpty, AdjacentCellsNotEmpty, PossibleToCapture)
checkPossibleToCapture(2, [Piece1,Piece2], 1):-
  getPieceValue(Piece1,P1),
  getPieceValue(Piece2,P2),
  P1 + P2 =<6,!.
checkPossibleToCapture(3, [Piece1,Piece2,Piece3], 2):-
  getPieceValue(Piece1,P1),
  getPieceValue(Piece2,P2),
  getPieceValue(Piece3,P3),
  P1 + P2 + P3 =< 6,!.
checkPossibleToCapture(3, [Piece1,Piece2,Piece3], 1):-
  getPieceValue(Piece1,P1),
  getPieceValue(Piece2,P2),
  getPieceValue(Piece3,P3),
  (P1 + P2 =<6;
  P1 + P3 =<6;
  P2 + P3 =<6).
checkPossibleToCapture(4, [Piece1,Piece2,Piece3,Piece4], 2):-
  getPieceValue(Piece1,P1),
  getPieceValue(Piece2,P2),
  getPieceValue(Piece3,P3),
  getPieceValue(Piece4,P4),
  (P1 + P2 + P3=<6;
  P1 + P3 + P4=<6;
  P2 + P3 + P4=<6),!.
checkPossibleToCapture(4, [Piece1,Piece2,Piece3,Piece4], 1):-
  getPieceValue(Piece1,P1),
  getPieceValue(Piece2,P2),
  getPieceValue(Piece3,P3),
  getPieceValue(Piece4,P4),
  (P1 + P2 =<6;
  P1 + P3 =<6;
  P1 + P4 =<6;
  P2 + P3 =<6;
  P2 + P4 =<6;
  P3 + P4 =<6),!.
checkPossibleToCapture(_,_,0).

getDirectionOfTwoPieces([Piece1,Piece2,Piece3,Piece4],[1,1,0,0]):-
  getPieceValue(Piece1,P1),
  getPieceValue(Piece2,P2),
  P1\=0,P2\=0,P1+P2=<6,!.
getDirectionOfTwoPieces([Piece1,Piece2,Piece3,Piece4],[1,0,1,0]):-
  getPieceValue(Piece1,P1),
  getPieceValue(Piece3,P3),
  P1\=0,P3\=0,P1+P3=<6,!.
getDirectionOfTwoPieces([Piece1,Piece2,Piece3,Piece4],[1,0,0,1]):-
  getPieceValue(Piece1,P1),
  getPieceValue(Piece4,P4),
  P1\=0,P4\=0,P1+P4=<6,!.
getDirectionOfTwoPieces([Piece1,Piece2,Piece3,Piece4],[0,1,1,0]):-
  getPieceValue(Piece2,P1),
  getPieceValue(Piece3,P3),
  P2\=0,P3\=0,P2+P3=<6,!.
getDirectionOfTwoPieces([Piece1,Piece2,Piece3,Piece4],[0,1,0,1]):-
  getPieceValue(Piece2,P2),
  getPieceValue(Piece4,P4),
  P2\=0,P4\=0,P2+P4=<6,!.
getDirectionOfTwoPieces([Piece1,Piece2,Piece3,Piece4],[0,0,1,1]):-
  getPieceValue(Piece3,P3),
  getPieceValue(Piece4,P4),
  P3\=0,P4\=0,P3+P4=<6.

%capturePieces(Row,Col,PiecesToCapture,AdjacentCells,Board,NewBoard)
capturePieces(Row,Col,[Up,Right,Down,Left],[P1,P2,P3,P4],Board,NewBoard):-
  UpRow is Row-1,
  ((Up=1,P1\=vazio)-> setMatrixElemAtWith(UpRow,Col,vazio,Board,Board1);
  Board1=Board),
  RightCol is Col+1,
  ((Right=1,P2\=vazio)->setMatrixElemAtWith(Row,RightCol,vazio,Board1,Board2);
  Board2=Board1),
  DownRow = Row+1,
  ((Down=1,P3\=vazio)->setMatrixElemAtWith(DownRow,Col,vazio,Board2,Board3);
  Board3=Board2),
  LeftCol is Col-1,
  ((Left=1,P4\=vazio)->setMatrixElemAtWith(Row,LeftCol,vazio,Board3,Board4);
  Board4=Board3),
  NewBoard = Board4.

%getNewPieceValue(DirectionsToCapture,AdjacentCells,NewPieceValue)
getNewPieceValue([Up,Right,Down,Left],[Piece1,Piece2,Piece3,Piece4],NewPieceValue):-
  NewPieceValue1=0,
  (Up=1 ->(getPieceValue(Piece1,P1), NewPieceValue2 is NewPieceValue1 + P1);NewPieceValue2 = NewPieceValue1),
  (Right=1 ->(getPieceValue(Piece2,P2), NewPieceValue3 is NewPieceValue2 + P2);NewPieceValue3 = NewPieceValue2),
  (Down=1 ->(getPieceValue(Piece3,P3), NewPieceValue4 is NewPieceValue3+ P3);NewPieceValue4 = NewPieceValue3),
  (Left=1 ->(getPieceValue(Piece4,P4), NewPieceValue5 is NewPieceValue4 + P4);NewPieceValue5 = NewPieceValue4),
  NewPieceValue=NewPieceValue5.

%checkGameWinner(Board,Player)
checkGameWinner(Board,Player,Player1,Player2):-
  checkGameWinner(Board,0,0,Player,Player1,Player2).
checkGameWinner([],White,Black,Player,Player1,Player2):-
  White>Black,
  Player=Player1.
checkGameWinner([],White,Black,Player,Player1,Player2):-
  Player=Player2.
checkGameWinner([H|T],White,Black,Player,Player1,Player2):-
  countPiecesInRow(H,WhiteInRow,BlackInRow,Player1,Player2),
  White1 is White+WhiteInRow,
  Black1 is Black+BlackInRow,
  checkGameWinner(T,White1,Black1,Player,Player1,Player2).

countPiecesInRow(Row,White,Black,Player1,Player2):-
  countPiecesInRow(Row,White,Black,0,0,Player1,Player2).

countPiecesInRow([],White,Black,CounterWhite,CounterBlack,Player1,Player2):-
  White=CounterWhite,
  Black=CounterBlack.
countPiecesInRow([H|T],White,Black,CounterWhite,CounterBlack,Player1,Player2):-
  getPiecePlayer(H,Player1),
  CounterWhite1 is CounterWhite +1,
  countPiecesInRow(T,White,Black,CounterWhite1,CounterBlack,Player1,Player2).
countPiecesInRow([H|T],White,Black,CounterWhite,CounterBlack,Player1,Player2):-
  getPiecePlayer(H,Player2),
  CounterBlack1 is CounterBlack +1,
  countPiecesInRow(T,White,Black,CounterWhite,CounterBlack1,Player1,Player2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% 1. current player; 2. next player.
changePlayer(Game, ResultantGame):-
	getGamePlayerTurn(Game, Player),
	(
		Player == whitePlayer ->
			NextPlayer = blackPlayer;
		NextPlayer = whitePlayer
	),
	setGamePlayerTurn(NextPlayer, Game, ResultantGame).


	changeBot(Game, ResultantGame):-
	getGamePlayerTurn(Game,Player),
	(
		Player = whitePlayer ->
			NextPlayer = botPlayer;
		NextPlayer = whitePlayer
	),
	setGamePlayerTurn(NextPlayer, Game, ResultantGame).

	changeComputer(Game, ResultantGame):-
	getGamePlayerTurn(Game,Player),
	(
		Player = computerPlayer ->
			NextPlayer = botPlayer;
		NextPlayer = computerPlayer
	),
	setGamePlayerTurn(NextPlayer, Game, ResultantGame).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

printTurnInfo(Player):-
  getPlayerName(Player, PlayerName),
  write('# It is '), write(PlayerName), write(' player\'s turn to play.'), nl, !.

getCoordsToPlacePiece(Row, Col):-
	write('Please insert the coordinates where you want to place a piece and press <Enter> - example: 3f.'), nl,
	inputCoords(Row, Col), nl.

getNumberofPiecesToCapture(NumPiecesToCapture):-
  write('You can capture more than 2 pieces. How many do you want to capture?'),nl,
  getInt(NumPiecesToCapture),discardInputChar,
  (NumPiecesToCapture=2;NumPiecesToCapture=3;NumPiecesToCapture=4;write('ERROR:Capturing Pieces')),!.

botGetNumberOfPiecesToCapture(NumPiecesToCapture):-
random(2,5,NumPiecesToCapture),!.

getDirectionsToCapture(2,DirectionsToCapture):-
  write('Please insert the directions to capture, u=up,r=right,d=down,l=left'),nl,
  get_char(Char1),
  get_char(Char2),
  discardInputChar,
  Directions1 = [0,0,0,0],
  translateCharToDirection(Char1,Directions1,Directions2),
  translateCharToDirection(Char2,Directions2,Directions3),
  DirectionsToCapture = Directions3.
getDirectionsToCapture(3,DirectionsToCapture):-
  write('Please insert the directions to capture, u=up,r=right,d=down,l=left'),nl,
  get_char(Char1),
  get_char(Char2),
  get_char(Char3),
  discardInputChar,
  Directions1 = [0,0,0,0],
  translateCharToDirection(Char1,Directions1,Directions2),
  translateCharToDirection(Char2,Directions2,Directions3),
  translateCharToDirection(Char3,Directions3,Directions4),
  DirectionsToCapture = Directions4.
getDirectionsToCapture(4,DirectionsToCapture):-
  write('Please insert the directions to capture, u=up,r=right,d=down,l=left'),nl,
  get_char(Char1),
  get_char(Char2),
  get_char(Char3),
  get_char(Char4),
  discardInputChar,
  Directions1 = [0,0,0,0],
  translateCharToDirection(Char1,Directions1,Directions2),
  translateCharToDirection(Char2,Directions2,Directions3),
  translateCharToDirection(Char3,Directions3,Directions4),
  translateCharToDirection(Char4,Directions1,Directions5),
  DirectionsToCapture = Directions5.

translateCharToDirection('u',[Up,Right,Down,Left],DirectionsToCapture):-
  DirectionsToCapture = [1,Right,Down,Left].
translateCharToDirection('r',[Up,Right,Down,Left],DirectionsToCapture):-
  DirectionsToCapture = [Up,1,Down,Left].
translateCharToDirection('d',[Up,Right,Down,Left],DirectionsToCapture):-
  DirectionsToCapture = [Up,Right,1,Left].
translateCharToDirection('l',[Up,Right,Down,Left],DirectionsToCapture):-
  DirectionsToCapture = [Up,Right,Down,1].

  botGetDirectionsToCapture(DirectionsToCapture):-
    random(1,12,Random),
    randomDirections(Random,DirectionsToCapture).

  randomDirections(1,[1,1,0,0]).
  randomDirections(2,[1,0,1,0]).
  randomDirections(3,[1,0,0,1]).
  randomDirections(4,[0,1,1,0]).
  randomDirections(5,[0,1,0,1]).
  randomDirections(6,[0,0,1,1]).
  randomDirections(7,[1,1,1,0]).
  randomDirections(8,[1,0,1,1]).
  randomDirections(9,[1,1,0,1]).
  randomDirections(10,[1,1,1,0]).
  randomDirections(11,[1,1,1,1]).


inputCoords(Row, Col):-
	getInt(RawRow),
	getInt(RawCol),
	% discard enter
	discardInputChar,
	% process row and column
	Row is RawRow-1,
	Col is RawCol-49.

printGameOverMessage(Player):-
  write('GAME OVER - '), write(Player), write('WON!'),nl.
