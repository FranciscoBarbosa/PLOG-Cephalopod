:-use_module(library(lists)).



board1([[2,0,0,2,2,3],
						[2,0,1,1,0,0],
						[1,1,4,4,4,3],
						[2,1,3,2,3,3],
						[1,0,3,4,4,4]]).

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



translate(empty):-write('   ').
translate(0):-write(' 0 ').
translate(1):-write(' 1 ').
translate(2):-write(' 2 ').
translate(3):-write(' 3 ').
translate(4):-write(' 4 ').
translate(5):-write(' 5 ').
translate(6):-write(' 6 ').
translate(7):-write(' 7 ').
translate(8):-write(' 8 ').
translate(9):-write(' 9 ').


%%%%%PRINT BOARD1

printBoard1([H|T]):-
  write(' ------------------------------'),nl,
  printRemainingBoard1([H|T],1),
%  write('|                  |'),
  write(' ------------------------------').



printRemainingBoard1([],_).
printRemainingBoard1([H|T],N):-
        write('| '),printTopOfLine1(H),
        nl,
        write('| '),printMidOfLine1(H),
        nl,
        write('| '),printBotOfLine1(H),
        nl,
        N1 is N+1,
        printRemainingBoard1(T,N1).

printMidOfLine1([]):-write('|').
printMidOfLine1([H|T]):-write(' '),
        translate(H),
        write(' '),
        printMidOfLine1(T).

printBotOfLine1([]):-write('                              |').
printBotOfLine1([H|T]):-
        printBotOfLine1(T).

printTopOfLine1([]):-write('                              |').
printTopOfLine1([H|T]):-
        printTopOfLine1(T).


%%%%%PRINT BOARD2

printBoard2([H|T]):-
  write(' -----------------------------------------------'),nl,
  printRemainingBoard2([H|T],1),
%  write('|                  |'),
  write(' -----------------------------------------------').



printRemainingBoard2([],_).
printRemainingBoard2([H|T],N):-
        write('| '),printTopOfLine2(H),
        nl,
        write('| '),printMidOfLine2(H),
        nl,
        write('| '),printBotOfLine2(H),
        nl,
        N1 is N+1,
        printRemainingBoard2(T,N1).

printMidOfLine2(List):-printMidOfLine2(List,0).

printMidOfLine2([],Bef):-write(' |').
printMidOfLine2([H|T],Bef):-write(' '),
Bef\=empty->(
H=empty->write('|    ');
H\=empty
),
        translate(H),
        write(' '),
        printMidOfLine2(T,H),!.

printMidOfLine2([H|T],Bef):-write(' '),
Bef=empty->(
H\=empty->write('|');
H=empty
),
        translate(H),
        write(' '),
        printMidOfLine2(T,H).



printBotOfLine2([]):-write('                                              |').
printBotOfLine2([H|T]):-
        printBotOfLine2(T).

printTopOfLine2([]):-write('                                              |').
printTopOfLine2([H|T]):-
        printTopOfLine2(T).
