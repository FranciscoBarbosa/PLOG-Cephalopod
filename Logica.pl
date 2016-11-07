:-include('tabuleiro.pl').


checkPos(List,X,Y):-getPiece(X,Y,vazio,List).%Piece\==vazio.		

		

play(List,X,Y,Piece,NewList):-checkPos(List,X,Y),setPiece(List,X,Y,Piece,NewList),printBoard(NewList).

play(List,X,Y,Piece,NewList):-printBoard(List),write('Nao e possivel jogar nessa casa').



checkAround(List,X,Y,NewList):-X1 is X-1, X2 is X+1, Y1 is Y-1,Y2 is Y2+1,getPiece(X1,Y),getPiece(X2,Y),getPiece(X,Y1),getPiece(X,Y2).


sum([],Result).
sum([H|T],Result):-Result1 is Result+H,Sum(T,Result1).

deletePieces().%escolher quais comer

%fazer funcao para para peça w(Result).

eatPieces(List,NewPiece,X,Y,NewList):-sum(List,Result),Result <6,deletePieces(),setPiece().