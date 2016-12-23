:-use_module(library(lists)).

board(1, [[0, 0, 1],[0, 2, 0]]). % 3x2
board(2, [[2, 0, 0, 3], [1, 0, 0, 0], [0, 1, 1, 4]]). % 4x3
board(3, [[0, 0, 4, 0], [2, 1, 1, 0], [1, 2, 0, 3], [1, 3, 0, 1]]). % 4x4
board(4, [[0, 3, 0, 2, 4], [0, 0, 4, 0, 1], [3, 1, 0, 2, 2], [1, 1, 1, 1, 2]]). % 5x4
board(5, [[3, 1, 2, 2, 4, 1], [1, 2, 0, 2, 0, 0], [2, 4, 0, 1, 3, 2], [4, 0, 1, 1, 3, 0]]). % 6x4
board(6, [[2, 0, 0, 2, 2, 3], [2, 0, 1, 1, 0, 0], [1, 1, 4, 4, 4, 3], [2, 1, 3, 2, 3, 3], [1, 0, 3, 4, 4, 4]]). % 6x5

%board1([[2,0,0,2,2,3],
%				[2,0,1,1,0,0],
%				[1,1,4,4,4,3],
%				[2,1,3,2,3,3],
%				[1,0,3,4,4,4]]).

board2([[1,4,3,6,6,1,0,2,2],
						[2,0,0,0,1,1,3,1,3],
						[2,2,empty,empty,empty,empty,empty,0,3],
						[3,5,empty,empty,empty,empty,empty,6,6],
						[3,4,empty,empty,empty,empty,empty,6,3],
            [5,2,empty,empty,empty,empty,empty,2,3],
            [5,1,empty,empty,empty,empty,empty,6,6],
            [1,2,0,1,0,4,4,4,5],
            [6,4,4,4,0,5,5,5,5]]).

board3([[empty,2,0,4,0,1,empty,empty],
						[empty,5,6,3,6,6,2,1],
						[6,5,3,4,6,5,0,1],
						[6,5,1,0,0,5,2,1],
						[5,4,3,2,0,1,2,4],
            [2,3,3,4,4,1,4,4],
            [2,6,6,2,0,0,1,empty],
            [empty,empty,5,5,3,3,3,empty]]).

board4([[0,1,4,3,2,0,6,5,7,1,2,4,7,1,3],
			   			 [0,0,6,4,2,empty,empty,empty,empty,empty,4,4,8,7,4],
			   	 		 [1,1,6,1,8,empty,empty,empty,empty,empty,0,6,7,6,6],
		       		 [5,7,0,8,3,empty,empty,empty,empty,empty,3,1,2,2,7],
			   	 		 [4,3,6,0,3,empty,empty,empty,empty,empty,3,1,1,5,7],
               [4,6,6,2,3,empty,empty,empty,empty,empty,5,8,8,3,7],
               [4,5,5,2,7,empty,empty,empty,empty,empty,5,0,8,6,8],
               [0,0,8,2,5,4,2,1,2,3,7,5,5,8,8]]).



printPiece(empty):-write('     ').
printPiece(0):-write('  0  ').
printPiece(1):-write('  1  ').
printPiece(2):-write('  2  ').
printPiece(3):-write('  3  ').
printPiece(4):-write('  4  ').
printPiece(5):-write('  5  ').
printPiece(6):-write('  6  ').
printPiece(7):-write('  7  ').
printPiece(8):-write('  8  ').
printPiece(9):-write('  9  ').


%%%%%PRINT BOARD1

printBoard([H|T]):-
	length(H,Length),
	write(' '),
  printHorizontalSeparator(Length,'_'),nl,
  printRemainingBoard([H|T]),nl.

%printHorizontalSeparator(N,Separator)
printHorizontalSeparator(1,Separator):-
	write(Separator),
	write(Separator),
	write(Separator),
	write(Separator),
	write(Separator).
printHorizontalSeparator(N,Separator):-
	write(Separator),
	write(Separator),
	write(Separator),
	write(Separator),
	write(Separator),
	write(Separator),
	N1 is N-1,
	printHorizontalSeparator(N1,Separator).

printRemainingBoard([H]):-
	length(H,Length),
	write('|'),printTopOfLine(H),
	nl,
	write('|'),printMidOfLine(H),
	nl,
	write('|'),printHorizontalSeparator(Length,'_'),write('|').
printRemainingBoard([H|T]):-
%	trace,
  write('|'),printTopOfLine(H),
  nl,
  write('|'),printMidOfLine(H),
  nl,
  write('|'),printBotOfLine(H),
  nl,
  printRemainingBoard(T).

printTopOfLine([H]):-
	write('     |').
printTopOfLine([H|T]):-
	write('     '),
	write('.'),
	printTopOfLine(T).

printMidOfLine([H]):-
	printPiece(H),
	write('|').
printMidOfLine([H|T]):-
	printPiece(H),
	write('.'),
  printMidOfLine(T).

printBotOfLine([H]):-write('.....|').
printBotOfLine([H|T]):-
	write('......'),
  printBotOfLine(T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

printSolution([H|T],Solution):-
	length(H,Length),
	write(' '),
  printHorizontalSeparator(Length,'_'),nl,
  printRemainingSolution([H|T],Solution,0),nl.

printRemainingSolution([H],Solution,Index):-
	length(H,Length),
	write('|'),printTopOfLine(H,Solution,Index),
	nl,
	write('|'),printMidOfLine(H,Solution,Index),
	nl,
	write('|'),printBotOfLine(H,Solution,Index,Length).
printRemainingSolution([H|T],Solution,Index):-
	length(H,Length),
  write('|'),printTopOfLine(H,Solution,Index),
  nl,
  write('|'),printMidOfLine(H,Solution,Index),
  nl,
  write('|'),printBotOfLine(H,Solution,Index,Length),
  nl,
	NewIndex is Index+Length,
  printRemainingSolution(T,Solution,NewIndex).

printTopOfLine([H],Sol,Index):-
	write('     |').
printTopOfLine([H|T],Sol,Index):-
	NewIndex is Index + 1,
	length(Sol,Length),
	NewIndex < Length,
	nth0(Index,Sol,Elem1),
	nth0(NewIndex,Sol,Elem2),
	Elem1=Elem2,
	write('     '),
	write(' '),
	printTopOfLine(T,Sol,NewIndex).
printTopOfLine([H|T],Sol,Index):-
	write('     '),
	write('|'),
	NewIndex is Index + 1,
	printTopOfLine(T,Sol,NewIndex).

printMidOfLine([H],Sol,Index):-
	printPiece(H),
	write('|').
printMidOfLine([H|T],Sol,Index):-
	NewIndex is Index + 1,
	length(Sol,Length),
	NewIndex < Length,
	nth0(Index,Sol,Elem1),
	nth0(NewIndex,Sol,Elem2),
	Elem1=Elem2,
	printPiece(H),
	write(' '),
	printMidOfLine(T,Sol,NewIndex).
printMidOfLine([H|T],Sol,Index):-
	printPiece(H),
	write('|'),
	NewIndex is Index + 1,
	printMidOfLine(T,Sol,NewIndex).

printBotOfLine([H],Sol,Index,LineLength):-
	NewIndex is Index + LineLength,
	length(Sol,Length),
	NewIndex >= Length,
	write('_____'),
	write('|').
printBotOfLine([H],Sol,Index,_):-
	NewIndex is Index - 1,
	NewIndex >= 0,
	nth0(Index,Sol,Elem1),
	nth0(NewIndex,Sol,Elem2),
	Elem1=Elem2,
	write('_____'),
	write('|').
printBotOfLine([H],Sol,Index,LineLength):-
	NewIndex is Index + LineLength,
	length(Sol,Length),
	NewIndex < Length,
	nth0(Index,Sol,Elem1),
	nth0(NewIndex,Sol,Elem2),
	Elem1\=Elem2,
	write('_____'),
	write('|').
printBotOfLine([H],Sol,Index,_):-
	write('     |').
printBotOfLine([H|T],Sol,Index,LineLength):-
	NewIndex is Index + 1,
	length(Sol,Length),
	NewIndex < Length,
	nth0(Index,Sol,Elem1),
	nth0(NewIndex,Sol,Elem2),
	Elem1=Elem2,
	write('_____'),
	write('_'),
	printBotOfLine(T,Sol,NewIndex,LineLength).
printBotOfLine([H|T],Sol,Index,LineLength):-
	NewIndex is Index - 1,
	NewIndex >= 0,
	nth0(Index,Sol,Elem1),
	nth0(NewIndex,Sol,Elem2),
	Elem1=Elem2,
	write('_____'),
	write('|'),
	NewIndex2 is Index + 1,
	printBotOfLine(T,Sol,NewIndex2,LineLength).
printBotOfLine([H|T],Sol,Index,LineLength):-
	NewIndex is Index + LineLength,
	length(Sol,Length),
	NewIndex < Length,
	nth0(Index,Sol,Elem1),
	nth0(NewIndex,Sol,Elem2),
	Elem1\=Elem2,
	write('_____'),
	write('|'),
	NewIndex2 is Index + 1,
	printBotOfLine(T,Sol,NewIndex2,LineLength).
printBotOfLine([H|T],Sol,Index,LineLength):-
	NewIndex is Index + LineLength,
	length(Sol,Length),
	NewIndex >= Length,
	write('_____'),
	write('|'),
	NewIndex2 is Index + 1,
	printBotOfLine(T,Sol,NewIndex2,LineLength).
printBotOfLine([H|T],Sol,Index,LineLength):-
	write('     '),
	write('|'),
	NewIndex is Index + 1,
	printBotOfLine(T,Sol,NewIndex,LineLength).
