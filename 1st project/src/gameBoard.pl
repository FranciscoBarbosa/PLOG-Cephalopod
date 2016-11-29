emptyBoard([[vazio,vazio,vazio,vazio,vazio],
						[vazio,vazio,vazio,vazio,vazio],
						[vazio,vazio,vazio,vazio,vazio],
						[vazio,vazio,vazio,vazio,vazio],
						[vazio,vazio,vazio,vazio,vazio]]).

testBoard3([[vazio,b1,vazio,vazio,vazio],
						[w1,vazio,w1,vazio,vazio],
						[vazio,b1,vazio,vazio,vazio],
						[vazio,vazio,vazio,vazio,vazio],
						[vazio,vazio,vazio,vazio,vazio]]).

testBoard([[b1,vazio,vazio,vazio,vazio],
						[vazio,b3,w3,b1,vazio],
						[w1,vazio,vazio,vazio,vazio],
						[vazio,vazio,vazio,w1,vazio],
						[vazio,vazio,vazio,vazio,vazio]]).

exampleboard1([[vazio,vazio,w1    ,b1    ,vazio],
			   			 [vazio,vazio,b1     ,vazio,vazio],
			   	 		 [vazio,b4    ,vazio,vazio,vazio],
		       		 [vazio,vazio,vazio,vazio,w3   ],
			   	 		 [w1   ,vazio,vazio,w4   ,vazio]]).


exampleboard2([[w1,w6,b1,b6,b1],
			   			 [w6,b2,w6,b6,b1],
			   	 		 [b6,w6,w1,b6,b6],
		       		 [b6,w6,b6,w6,vazio],
			   	 		 [w1,w1,b1,w6,b1]]).

exampleboard3([[w1,w6,c1,c6,c1],
 			   			 [w6,c2,w6,c6,c1],
 			   	 		 [c6,w6,w1,c6,c6],
 		       		 [c6,w6,c6,w6,vazio],
 			   	 		 [w1,w1,c1,w6,c1]]).

 exampleboard4([[d1,d6,c1,c6,c1],
   			 				[d6,c2,d6,c6,c1],
 			   	 		 [c6,d6,d1,c6,c6],
		       		 [c6,d6,c6,d6,vazio],
  			   	 	[d1,d1,c1,d6,c1]]).


exampleboard3([[w6,w6,w6,w6,w6],
			   			 [w6,w6,w6,w6,w6],
			   	 		 [w6,w6,w6,w6,w6],
		       		 [w6,w6,w6,w6,w6],
			   	 		 [w6,w6,w6,w6,w6]]).

translate(vazio):-write('     ').
translate(w1):-write(' W1  ').
translate(c1):-write(' C1  ').
translate(b1):-write(' B1  ').
translate(w2):-write(' W2  ').
translate(c2):-write(' C2  ').
translate(b2):-write(' B2  ').
translate(w3):-write(' W3  ').
translate(c3):-write(' C3  ').
translate(b3):-write(' B3  ').
translate(w4):-write(' W4  ').
translate(c4):-write(' C4  ').
translate(b4):-write(' B4  ').
translate(w5):-write(' W5  ').
translate(c5):-write(' C5  ').
translate(b5):-write(' B5  ').
translate(w6):-write(' W6  ').
translate(c6):-write(' C6  ').
translate(b6):-write(' B6  ').
translate(d1):-write(' D1  ').
translate(d2):-write(' D2  ').
translate(d3):-write(' D3  ').
translate(d4):-write(' D4  ').
translate(d5):-write(' D5  ').
translate(d6):-write(' D6  ').


printBoard([H|T]):-
        nl,
        printLetters,
        write('      ___________________________________ '),nl,
        printRemainingBoard([H|T],1).
printLetters:-
        write('        a      b      c      d      e    '),nl.


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
