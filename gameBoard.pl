emptyBoard([[vazio,vazio,vazio,vazio,vazio],
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
