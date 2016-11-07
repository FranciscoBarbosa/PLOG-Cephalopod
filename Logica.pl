:-include('tabuleiro.pl').
:-include('lib(iso_light)').
		

play(List,X,Y,Piece,NewList):-checkPos(List,X,Y),setPiece(List,X,Y,Piece,NewList),printBoard(NewList).

play(List,X,Y,Piece,NewList):-printBoard(List),write('Nao e possivel jogar nessa casa').



checkAround(List,X,Y,NewList):-X1 is X-1, X2 is X+1, Y1 is Y-1,Y2 is Y2+1,getPiece(X1,Y),getPiece(X2,Y),getPiece(X,Y1),getPiece(X,Y2).


sum([],Result,Var):-Var=Result.
sum([H|T],Result,Var):-Result1 is Result+H,sum(T,Result1,Var).

deletePieces().%escolher quais comer

%fazer funcao para peça w(Result).

newPiece(List,Piece):-sum(List,Result),number_chars(Result,R),atom_chars('w',W),append(W,R,FinalPiece),atom_chars(FinalPiece,Final),Piece=Final.


eatPieces(List,NewPiece,X,Y,NewList):-sum(List,Result),Result <6,deletePieces(),setPiece().