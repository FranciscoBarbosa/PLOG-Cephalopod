:-use_module(library(clpfd)).
:-use_module(library(lists)).
:- [utils].
:- [menus].
:- [gameBoard].
%:-mainMenu.

%peças
%piece(Num,Valor1,Valor2)
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

%boards

%funcao principal
dominos1(N,Sol):-
  %board0(Board),
  %Sol= [S1,S2,S3,S4,S5,S6],
  %Width is 3,

  board(N,Board),
  flatten(Board,FlatBoard),
  length(FlatBoard,Length),
%  Sol= [S1,S2,S3,S4,S5,S6,
%  S7,S8,S9,S10,S11,S12,
%  S13,S14,S15,S16,S17,S18,
%  S19,S20,S21,S22,S23,S24,
%  S25,S26,S27,S28,S29,S30],
  length(Sol,Length),

  determineWidth(Board,Width),
  %Width is 6,

  joinSolBoard(Sol,FlatBoard,SolBoard),

  getAllAdjacentCells(Sol,Width,Adjacents),
  getAllAdjacentCellsFunctor(SolBoard,Width,AdjacentsFunctor),

  %domain
  DomainUpperBound is Length//2,
  domain(Sol,1,DomainUpperBound),

  %restricoes
  %talvez seja redundante mas pode aumentar eficiencia
  restrainEveryValue(Sol,DomainUpperBound),
  restrainAdjacentCells(Sol,Adjacents),
  restrainAdjacentCellsFunctor(SolBoard,AdjacentsFunctor),
  restrainBoard(Sol,FlatBoard),


%  write(Board),nl,
%  write(FlatBoard),nl,
%  write(Sol),nl,
%  write(Adjacents),nl,
%write(SolBoard),nl,

  labeling([],Sol),
  write(Sol).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Funcoes de manipulacao de tabuleiro %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   retorna em adjacentes uma lista de listas em que cada sublista são as peças
%adjacentes à peça com o mesmo indice no tabuleiro
%getAllAdjacentCells(Sol,Width,Adjacents):-
getAllAdjacentCells(Sol,Width,Adjacents):-
  getAllAdjacentCells(Sol,Width,0,[],Adjacents).
getAllAdjacentCells(Sol,Width,Counter,Acc,Acc):-
  length(Sol,Counter).
getAllAdjacentCells(Sol,Width,Counter,Acc,Adjacents):-
  bagof(Adj, getAdjacent(Sol,Width,Counter,Adj), Adjacent),
  Counter1 is Counter + 1,
  append(Acc,[Adjacent],Acc1),
  getAllAdjacentCells(Sol,Width,Counter1,Acc1,Adjacents).

%getAdjacent(Sol,Width,Index,Adjacent):-
%Down
getAdjacent(Sol,Width,Index,Adjacent):-
    length(Sol,Length),
    Index1 is Index + Width,
    Index1 < Length,
    nth0(Index1,Sol,Adjacent).
%Up
getAdjacent(Sol,Width,Index,Adjacent):-
    Index1 is Index - Width,
    Index1 >= 0,
    nth0(Index1,Sol,Adjacent).
%Left
getAdjacent(Sol,Width,Index,Adjacent):-
    R is Index mod Width,
    R \= 0,
    Index1 is Index - 1,
    nth0(Index1,Sol,Adjacent).
%Rigth
getAdjacent(Sol,Width,Index,Adjacent):-
    Index1 is Index + 1,
    R is Index1 mod Width,
    R \= 0,
    nth0(Index1,Sol,Adjacent).

determineWidth([H|_],Width):-
  length(H,Width).

%Retrona lista em que cada elemento é Sol-Board
joinSolBoard(Sol,Board,SolBoard):-
  joinSolBoard(Sol,Board,[],SolBoard).
joinSolBoard([],[],Acc,Acc).
joinSolBoard([HSol|TSol],[HBoard|TBoard],Acc,SolBoard):-
  append(Acc,[HSol-HBoard],Acc1),
  joinSolBoard(TSol,TBoard,Acc1,SolBoard).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Funcoes de restricao  %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Garante que cada valor aparece 2 vezes no tabuleiro resolvido
restrainEveryValue(List,MaxValue):-
  restrainEveryValue(List,1,MaxValue).
restrainEveryValue(List,Counter,MaxValue):-
  Counter > MaxValue.
restrainEveryValue(List,Counter,MaxValue):-
  %exactly(Counter,List,2),
  count(Counter,List,#=,2),
  Counter1 is Counter + 1,
  restrainEveryValue(List,Counter1,MaxValue).

%Garante que uma(e apenas uma!) célula adjacente tem o mesmo valor que a que se analisa
%restrainAdjacentCells(Sol,Adjacents):-
restrainAdjacentCells([],[]).
restrainAdjacentCells([H|T],[Adjacent|Adjacents]):-
  restrainAdjacentCell(H,Adjacent),
  restrainAdjacentCells(T,Adjacents).

%same thing but for only one cell
restrainAdjacentCell(Cell,[A1,A2]):-
  (Cell #= A1) #\ (Cell #= A2).
restrainAdjacentCell(Cell,[A1,A2,A3]):-
  (Cell #= A1) #\ ((Cell #= A2) #\ (Cell #= A3)).
restrainAdjacentCell(Cell,[A1,A2,A3,A4]):-
  (Cell #= A1) #\ ((Cell #= A2) #\ ((Cell #= A3) #\ (Cell#=A4))).

%garante a ligação entre os valores da solução e das peças tabuleiro
%restrainBoard(Sol,FlatBoard),
restrainBoard([],[]).
restrainBoard([HSol|TSol],[HBoard|TBoard]):-
  (piece(HSol,HBoard,_);
  piece(HSol,_,HBoard)),
  restrainBoard(TSol,TBoard).
%restrainBoard([HSol|TSol],[HBoard|TBoard]):-
%  piece(HSol,Value,_),
%  Value#=HBoard.
%restrainBoard([HSol|TSol],[HBoard|TBoard]):-
%  piece(HSol,_,Value),
%  Value#=HBoard.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Functor  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getAllAdjacentCellsFunctor(SolBoard,Width,Adjacents):-
  getAllAdjacentCellsFunctor(SolBoard,Width,0,[],Adjacents).
getAllAdjacentCellsFunctor(SolBoard,Width,Counter,Acc,Acc):-
  length(SolBoard,Counter).
getAllAdjacentCellsFunctor(SolBoard,Width,Counter,Acc,Adjacents):-
  bagof(Adj, getAdjacentFunctor(SolBoard,Width,Counter,Adj), Adjacent),
  Counter1 is Counter + 1,
  append(Acc,[Adjacent],Acc1),
  getAllAdjacentCellsFunctor(SolBoard,Width,Counter1,Acc1,Adjacents).

%getAdjacent(Sol,Width,Index,Adjacent):-
%Down
getAdjacentFunctor(Sol,Width,Index,Adjacent):-
    length(Sol,Length),
    Index1 is Index + Width,
    Index1 < Length,
    nth0(Index1,Sol,Adjacent).
%Up
getAdjacentFunctor(Sol,Width,Index,Adjacent):-
    Index1 is Index - Width,
    Index1 >= 0,
    nth0(Index1,Sol,Adjacent).
%Left
getAdjacentFunctor(Sol,Width,Index,Adjacent):-
    R is Index mod Width,
    R \= 0,
    Index1 is Index - 1,
    nth0(Index1,Sol,Adjacent).
%Rigth
getAdjacentFunctor(Sol,Width,Index,Adjacent):-
    Index1 is Index + 1,
    R is Index1 mod Width,
    R \= 0,
    Div1 = Div2,
    nth0(Index1,Sol,Adjacent).


%%%%%%%%%%%%%%%%%

restrainAdjacentCellsFunctor([],[]).
restrainAdjacentCellsFunctor([H|T],[Adjacent|Adjacents]):-
  %trace,
  restrainAdjacentCellFunctor(H,Adjacent),
  restrainAdjacentCellsFunctor(T,Adjacents).


%same thing but for only one cell
restrainAdjacentCellFunctor(_,[]):-fail.
restrainAdjacentCellFunctor(Cell-Board,[HC-HB|T]):-
  Cell=HC,
   piece(Cell,Board,HB).
restrainAdjacentCellFunctor(Cell-Board,[HC-HB|T]):-
  Cell=HC,
   piece(Cell,HB,Board).
restrainAdjacentCellFunctor(Cell-Board,[HC-HB|T]):-
  restrainAdjacentCellFunctor(Cell-Board,T).

%restrainAdjacentCellFunctor(Cell-Board,[A1-B1,A2-B2]):-
  %(restrainTwoCells(Cell,A1)) #\ (restrainTwoCells(Cell,A2)).
%  (Cell #= A1 #/\ piece(Cell,Board,A1)) #\ (Cell #= A2).
%restrainAdjacentCellFunctor(Cell-Board,[A1-B1,A2-B2,A3-B3]):-
  %(restrainTwoCells(Cell,A1)) #\ ((restrainTwoCells(Cell,A2)) #\ (restrainTwoCells(Cell,A3))).
  %(Cell #= A1) #\ ((Cell #= A2) #\ (Cell #= A3)).
%restrainAdjacentCellFunctor(Cell-Board,[A1-B1,A2-B2,A3-B3,A4-B4]):-
  %(restrainTwoCells(Cell,A1)) #\ ((restrainTwoCells(Cell,A2)) #\ ((restrainTwoCells(Cell,A3)) #\ (restrainTwoCells(Cell,A4)))).
%  (Cell #= A1) #\ ((Cell #= A2) #\ ((Cell #= A3) #\ (Cell#=A4))).


%restrainTwoCells(Cell1,Cell2)
restrainTwoCells(Sol1-Board1,Sol2-Board2):-
  Sol1 #= Sol2.
  %piece(Sol1,Board1,Board2).
restrainTwoCells(Sol1-Board1,Sol2-Board2):-
  Sol1 #= Sol2,
  piece(Sol1,Board2,Board1).
