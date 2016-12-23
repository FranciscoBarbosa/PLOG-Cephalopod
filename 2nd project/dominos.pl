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

%funcao principal
dominos1(N,Sol):-
  board(N,Board),
  flatten(Board,FlatBoard),
  length(FlatBoard,Length),
  length(Sol,Length),
  determineWidth(Board,Width),
  joinSolBoard(Sol,FlatBoard,SolBoard),

  getAllAdjacentCellsFunctor(SolBoard,Width,AdjacentsFunctor),

  %domain
  DomainUpperBound is Length//2,
  domain(Sol,1,DomainUpperBound),

  %restricoes
  %talvez seja redundante mas pode aumentar eficiencia
  restrainEveryValue(Sol,DomainUpperBound),
  restrainAdjacentCellsFunctor(SolBoard,AdjacentsFunctor),
  restrainBoard(Sol,FlatBoard),

  labeling([],Sol),
  write(Sol),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Funcoes de manipulacao de tabuleiro %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
restrainEveryValue(_,Counter,MaxValue):-
  Counter > MaxValue.
restrainEveryValue(List,Counter,MaxValue):-
  %exactly(Counter,List,2),
  count(Counter,List,#=,2),
  Counter1 is Counter + 1,
  restrainEveryValue(List,Counter1,MaxValue).


%garante a ligação entre os valores da solução e das peças tabuleiro
%restrainBoard(Sol,FlatBoard),
restrainBoard([],[]).
restrainBoard([HSol|TSol],[HBoard|TBoard]):-
  (piece(HSol,HBoard,_);
  piece(HSol,_,HBoard)),
  restrainBoard(TSol,TBoard).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Functor  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getAllAdjacentCellsFunctor(SolBoard,Width,Adjacents):-
  getAllAdjacentCellsFunctor(SolBoard,Width,0,[],Adjacents).
getAllAdjacentCellsFunctor(SolBoard,_,Counter,Acc,Acc):-
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
    nth0(Index1,Sol,Adjacent).


%%%%%%%%%%%%%%%%%

restrainAdjacentCellsFunctor([],[]).
restrainAdjacentCellsFunctor([H|T],[Adjacent|Adjacents]):-
  %trace,
  restrainAdjacentCellFunctor(H,Adjacent),
  restrainAdjacentCellsFunctor(T,Adjacents).


%same thing but for only one cell
restrainAdjacentCellFunctor(_,[]):-fail.
restrainAdjacentCellFunctor(Cell-Board,[HC-HB|_]):-
  Cell=HC,
  piece(Cell,Board,HB).
restrainAdjacentCellFunctor(Cell-Board,[HC-HB|_]):-
  Cell=HC,
   piece(Cell,HB,Board).
restrainAdjacentCellFunctor(Cell-Board,[_|T]):-
  restrainAdjacentCellFunctor(Cell-Board,T).


%restrainTwoCells(Cell1,Cell2)
restrainTwoCells(Sol1-Board1,Sol2-Board2):-
  Sol1 #= Sol2,
  piece(Sol1,Board1,Board2).
restrainTwoCells(Sol1-Board1,Sol2-Board2):-
  Sol1 #= Sol2,
  piece(Sol1,Board2,Board1).
