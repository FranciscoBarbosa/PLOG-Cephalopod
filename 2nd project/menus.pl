:-[gameBoard].

mainMenu:-
  printMainMenu,
  getChar(Input),
  (
    Input = '1' -> solveBoardMenu, mainMenu;
    Input = '2';

    nl,
		write('Error: invalid input.'), nl
  ).

printMainMenu:-
  clearConsole,
  write('DOMINOS'),nl,
  write('1. Solve Board'), nl,
  write('2. Exit'), nl,
  write('Choose an option:'), nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

solveBoardMenu:-
  printsolveBoardMenu,
  getChar(Input),
  (
    Input = '1' -> solveBoard(1);
    Input = '2' -> write('2');
    Input = '3' -> write('3');
    Input = '4' -> write('4');
    Input = '5' -> write('5');
    Input = '6' -> write('6');
    Input = '7';

    nl,
		write('Error: invalid input.'), nl
  ).

printsolveBoardMenu:-
  clearConsole,
  write('1. 3x2'),nl,
  write('2. 4x3'),nl,
  write('3. 4x4'),nl,
  write('4. 5x4'),nl,
  write('5. 6x4'),nl,
  write('6. 6x5'),nl,
  write('Choose an option:'), nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

solveBoard(N):-
  board(N,Board),
  printBoard(Board).
