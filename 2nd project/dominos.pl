:-use_module(library(clpfd)).
:-use_module(library(lists)).


piece(1,0,0).
piece(2,0,1).
piece(3,0,2).
piece(4,0,3).
piece(5,0,4).
piece(6,1,1).
piece(7,1,2).
piece(8,1,3).
piece(9,1,4).
piece(10,2,2).
piece(11,2,3).
piece(12,2,4).
piece(13,3,3).
piece(14,3,4).
piece(15,4,4).


board([1,2,3,
       3,2,1,
       4,4,2]).

%%board 6x5
%%peça à direita
getPieces(Board,Index,Piece,Width,Height):-
  nth1(Index,Board,Elem1),
  R=(Index mod Width),
  R>0,
  X is Index+1,
  nth1(X,Board,Elem2),(
  piece(Piece,Elem1,Elem2);
  piece(Piece,Elem2,Elem1)
  ).

%%peça à esquerda verifica 1ª linha
getPieces(Board,Index,Piece,Width,Height):-
  nth1(Index,Board,Elem1),
  R=(Index mod 1),
  R>0,
  X is Index-1,
  nth1(X,Board,Elem2),(
  piece(Piece,Elem1,Elem2);
  piece(Piece,Elem2,Elem1)
  ).

%%peça à esquerda verifica linhas seguintes
getPieces(Board,Index,Piece,Width,Height):-
  nth1(Index,Board,Elem1),
  R=(Index mod Width),
  R>1,
  X is Index-1,
  nth1(X,Board,Elem2),(
  piece(Piece,Elem1,Elem2);
  piece(Piece,Elem2,Elem1)
  ).

%%peça cima
getPieces(Board,Index,Piece,Width,Height):-
  nth1(Index,Board,Elem1),
  Index>Width,
  X is Index-Width,
  nth1(X,Board,Elem2),(
  piece(Piece,Elem1,Elem2);
  piece(Piece,Elem2,Elem1)
  ).
%%peça abaixo
getPieces(Board,Index,Piece,Width,Height):-
  nth1(Index,Board,Elem1),
  Index<Width*(Height-1)+1,
  X is Index+Width,
  nth1(X,Board,Elem2),(
  piece(Piece,Elem1,Elem2);
  piece(Piece,Elem2,Elem1)
  ).

%%get all pieces around 1 cell
getAllPieces(Board,Index,Pieces,Width,Height):-
  bagof(Piece,getPieces(Board,Index,Piece,Width,Height),Pieces).


%%get all pieces around all cells

getAllPossiblePieces(_,Width*Height,Pieces,Pieces,Width,Height).

getAllPossiblePieces(Board,Index,Pieces,NewPieces,Width,Height):-
  getAllPieces(Board,Index,P,Width,Height),
  append(Pieces,P,List),
  N is Index+1,
  getAllPossiblePieces(Board,N,List,NewPieces,Width,Height).



getAllPossiblePieces(Board,Pieces,Width,Height):-
  getAllPossiblePieces(Board,1,[],Pieces,Width,Height).
