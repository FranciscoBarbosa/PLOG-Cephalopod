clearConsole:-
	clearConsole(40), !.

clearConsole(0).
clearConsole(N):-
	nl,
	N1 is N-1,
	clearConsole(N1).

getChar(Input):-
	get_char(Input),
	get_char(_).

getInt(Input):-
	get_code(TempInput),
	Input is TempInput - 48.

discardInputChar:-
  get_code(_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%transforms a matrix in a list
%flatten(Matrix,List)
flatten(Matrix,List):-
  flatten(Matrix,[],List).

flatten([H],Acc,List):-
  append(Acc,H,List).
flatten([H|T],Acc,List):-
  append(Acc,H,Acc1),
  flatten(T,Acc1,List).
