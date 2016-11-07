mainMenu:-
  printMainMenu,
  getChar(Input),
  (
    Input = '1' -> gameModeMenu, mainMenu;
    Input = '4';

    nl,
		write('Error: invalid input.'), nl
  ).

printMainMenu:-
  clearConsole,
  write('1. Play'), nl,
  write('2. Exit'), nl,
  write('Choose an option:'), nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gameModeMenu:-
  printGameModeMenu,
  getChar(Input),
  (
    Input = '1' -> startPvPGame;
    Input = '2' -> write('not implemented yet'),nl;
    Input = '3' -> write('not implemented yet'),nl;
    Input = '4';

    nl,
		write('Error: invalid input.'), nl
  ).

printGameModeMenu:-
  clearConsole,
  write('1.PvP'),nl,
  write('2.PvC easy'), nl,
  write('3.PvC hard'), nl,
  write('4.back'), nl,
  write('Choose an option:'), nl.

startPvPGame:-
  createPvPGame(Game),
  playGame(Game).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
