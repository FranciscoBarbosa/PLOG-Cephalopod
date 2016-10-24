:- use_module(library(lists)).

emptyboard([[vazio,vazio,vazio,vazio,vazio],
[vazio,vazio,vazio,vazio,vazio],
[vazio,vazio,vazio,vazio,vazio],
[vazio,vazio,vazio,vazio,vazio],
[vazio,vazio,vazio,vazio,vazio]]).


exampleboard1([[vazio,vazio,w1    ,b1    ,vazio],
			   [vazio,vazio,b1     ,vazio,vazio],
			   [vazio,b4    ,vazio,vazio,vazio],
		       [vazio,vazio,vazio,vazio,w3   ],
			   [w1   ,vazio,vazio,w4   ,vazio]]).

	
exampleboard2([[w1,w6,b1,b6,b1],
			   [w6,b2,w6,b6,w1],
			   [b6,w6,w1,b6,b6],
		       [b6,w6,b6,w6,b1],
			   [w1,w1,b1,w6,b1]]).
			   
exampleboard3([[w6,w6,w6,w6,w6],
			   [w6,w6,w6,w6,w6],
			   [w6,w6,w6,w6,w6],
		       [w6,w6,w6,w6,w6],
			   [w6,w6,w6,w6,w6]]).

					 
					 
posicao(X,Y,N):-N is (Y-1)*5+X.


translate(vazio):-write('     ').
translate(w1):-write(' W1  ').
translate(b1):-write(' B1  ').
translate(w2):-write(' W2  ').
translate(b2):-write(' B2  ').
translate(w3):-write(' W3  ').
translate(b3):-write(' B3  ').
translate(w4):-write(' W4  ').
translate(b4):-write(' B4  ').
translate(w5):-write(' W5  ').
translate(b5):-write(' B5  ').
translate(w6):-write(' W6  ').
translate(b6):-write(' B6  ').

printBoard([H|T]):-
        nl,
        printLetters,
        write('      ___________________________________ '),nl,
        printRemainingBoard([H|T],1).
printLetters:-
        write('        a     b     c     d     e     f'),nl.

		
printRemainingBoard([],_).
printRemainingBoard([H|T],N):-
        write('     '),printTopOfLine(H),nl,
        write('  '),write(N),write('  '),
        printMidOfLine(H),nl,
        write('     '),printBotOfLine(H),nl,
        write('     |----------------------------------|'),nl,
        N1 is N+1,
        printRemainingBoard(T,N1).

printMidOfLine([]):-
        write('|').
printMidOfLine([H|T]):-
        write('| '),
        translate(H),
        printMidOfLine(T).

printBotOfLine([]):-
        write('|').
printBotOfLine([H|T]):-
        write('|      '),
        printBotOfLine(T).

printTopOfLine([]):-write('|').
printTopOfLine([H|T]):-
        write('|      '),
        printTopOfLine(T).


getLine(NumLinha,Lista,Linha):-exampleboard2(Lista),nth1(NumLinha,Lista,Linha).

getPiece(NumCol,NumLinha,Elemento):-getLine(NumLinha,Lista,Linha),nth1(NumCol,Linha,Elemento).



setPiece(Board, NewBoard,X, Y, Piece):-posicao(X,Y,I),replaceLine([H|Board],I,Piece,[H|NewBoard]).


replaceLine([_|T],0,X,[X|T]).

replaceLine([H|T],I,X,[H|R]):-I1 is I-1, replaceLine(T,I1,X,R).

replaceCol(List,X,Y,Piece,NewList):-getLine(Y,List,Line),replaceLine(Line,X-1,Piece,NewLine),replaceLine(List,Y-1,NewLine,NewList).


init(X,Y,Piece,NewBoard):-emptyboard(Board),printBoard(Board),replaceCol(Board,X,Y,Piece,NewBoard),printBoard(NewBoard).%com o emptyboard nao funciona, n sei pq





runGame:-
        exampleboard1(Board1),exampleboard2(Board2),
        printBoard(Board1),printBoard(Board2).
		
		
board1([[a,b,c,d],[e,f,g,h]]).
		
		

		
		
		


		
	