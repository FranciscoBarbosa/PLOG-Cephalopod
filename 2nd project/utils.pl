%transforms a matrix in a list
%flatten(Matrix,List)
flatten(Matrix,List):-
  flatten(Matrix,[],List).

flatten([H],Acc,List):-
  append(Acc,H,List).
flatten([H|T],Acc,List):-
  append(Acc,H,Acc1),
  flatten(T,Acc1,List).
