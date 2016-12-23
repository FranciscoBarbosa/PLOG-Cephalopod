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





%%%%%PRINT BOARD2

printBoard2([H|T]):-
  write(' ----------------------------------------------'),nl,
  printRemainingBoard2([H|T],T,1).



tailOfList(List,Tail):-[X|Tail]=List.

printRemainingBoard2([],[],_).

printRemainingBoard2([H|T],[],N):-
write('| '),printTopOfLine2(H,0),
nl,
write('| '),printMidOfLine2(H,0),
nl,
length([H|T],Num),
write('| '),printBotOfLine2(H,[],Num),
nl,
N1 is N+1,
printRemainingBoard2(T,[],N1).


printRemainingBoard2([H|T],T,N):-
        write('| '),printTopOfLine2(H,0),
        nl,
        write('| '),printMidOfLine2(H,0),
        nl,
				length([H|T],Num),
				nth1(1,T,X),
        write('| '),printBotOfLine2(H,X,Num),
        nl,
        N1 is N+1,
				tailOfList(T,Tail),
        printRemainingBoard2(T,Tail,N1).

printMidOfLine2([],Bef):-write('|').

printMidOfLine2([H|T],Bef):-
				length([H|T],N),
				N=1,
				write(' '),
				translate(H),
        write(' '),
        printMidOfLine2(T,H),!.

printMidOfLine2([H|T],Bef):-
				H=empty,
				write(' '),
        translate(H),
				write(' '),
        printMidOfLine2(T,H).

printMidOfLine2([H|T],Bef):-
				(
					Bef=empty->write('.');
					Bef\=empty->write(' ')
				),
        translate(H),
        write('.'),
        printMidOfLine2(T,H).


printBotOfLine2([],[],Num):-Num=1,nl,write('-----------------------------------------------|').
printBotOfLine2([],[],Num):-write('|').
printBotOfLine2([H|T],[],Num):-
	H\=empty,
	write('     '),
	printBotOfLine2(T,[],Num).



printBotOfLine2([H|T],[X|Y],Num):-
	Num>1,
	H\=empty,
	write('.....'),
        printBotOfLine2(T,Y,Num),!.

printBotOfLine2([H|T],[X|Y],Num):-
	Num>1,
	H=empty,
	(
	X=empty->write('     ');
	X\=empty->write('.....')
	),
        printBotOfLine2(T,Y,Num),!.			

printBotOfLine2([H|T],[X,Y],Num):-
        printBotOfLine2(T,Y,Num).

printTopOfLine2([],Bef):-write('|').

printTopOfLine2([H|T],Bef):-
	length([H|T],N),
	N=1,
	write('     '),
        printTopOfLine2(T,H),!.

printTopOfLine2([H|T],Bef):-
	H=empty,
	write('     '),
        printTopOfLine2(T,H).

printTopOfLine2([H|T],Bef):-
	(
	Bef=empty->write('.   .');
	Bef\=empty->write('    .')
	),
        printTopOfLine2(T,H).


%%%%%%%%%%%%%%%%%%%Print Board3

printBoard3([H|T]):-
  write(' ------------------------------------------'),nl,
  printRemainingBoard3([H|T],1).


printRemainingBoard3([],_).

printRemainingBoard3([H|T],N):-
write('| '),printTopOfLine2(H,0),
nl,
write('| '),printMidOfLine2(H,0),
nl,
length([H|T],Num),
write('| '),printBotOfLine3(H,Num),
nl,
N1 is N+1,
printRemainingBoard3(T,N1).


printBotOfLine3([],Num):-Num=1,write('-----------------------------------------|').
printBotOfLine3([],Num):-write('|').


printBotOfLine3([H|T],Num):-
	Num>1,
	H\=empty,
	write('.....'),
        printBotOfLine3(T,Num),!.

printBotOfLine3([H|T],Num):-
	Num>1,
	H=empty,
	(
	X=empty->write('     ');
	X\=empty->write('.....')
	),
        printBotOfLine3(T,Num),!.			

printBotOfLine3([H|T],Num):-
        printBotOfLine3(T,Num).


%PrintBoard4

printBoard4([H|T]):-
  write(' ----------------------------------------------------------------------------'),nl,
  printRemainingBoard4([H|T],T,1).


	printRemainingBoard4([H|T],[],N):-
	write('| '),printTopOfLine2(H,0),
	nl,
	write('| '),printMidOfLine2(H,0),
	nl,
	length([H|T],Num),
	write('| '),printBotOfLine4(H,[],Num),
	nl,
	N1 is N+1,
	printRemainingBoard4(T,[],N1).


	printRemainingBoard4([H|T],T,N):-
	        write('| '),printTopOfLine2(H,0),
	        nl,
	        write('| '),printMidOfLine2(H,0),
	        nl,
					length([H|T],Num),
					nth1(1,T,X),
	        write('| '),printBotOfLine4(H,X,Num),
	        nl,
	        N1 is N+1,
					tailOfList(T,Tail),
	        printRemainingBoard4(T,Tail,N1).

					printRemainingBoard4([],[],_).







					printBotOfLine4([],[],Num):-Num=1,nl,write('-----------------------------------------------------------------------------|').
					printBotOfLine4([],[],Num):-write('|').
					printBotOfLine4([H|T],[],Num):-
						H\=empty,
						write('     '),
						printBotOfLine4(T,[],Num).



					printBotOfLine4([H|T],[X|Y],Num):-
						Num>1,
						H\=empty,
						write('.....'),
					        printBotOfLine4(T,Y,Num),!.

					printBotOfLine4([H|T],[X|Y],Num):-
						Num>1,
						H=empty,
						(
						X=empty->write('     ');
						X\=empty->write('.....')
						),
					        printBotOfLine4(T,Y,Num),!.			

					printBotOfLine4([H|T],[X,Y],Num):-
					        printBotOfLine4(T,Y,Num).
