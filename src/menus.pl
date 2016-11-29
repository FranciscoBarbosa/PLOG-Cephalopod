mainMenu:-
  printMainMenu,
  getChar(Input),
  (
    Input = '1' -> gameModeMenu, mainMenu;
    Input = '2';

    nl,
		write('Error: invalid input.'), nl
  ).

printMainMenu:-
  clearConsole,
  write('CEPHALOPOD'),nl,
  write('1. Play'), nl,
  write('2. Exit'), nl,
  write('Choose an option:'), nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gameModeMenu:-
  printGameModeMenu,
  getChar(Input),
  (
    Input = '1' -> startPvPGame;
    Input = '2' -> startPvBGame;
    Input = '3' -> startCvCGame;
    Input = '4';

    nl,
		write('Error: invalid input.'), nl
  ).

printGameModeMenu:-
  clearConsole,
  write('1.PvP'),nl,
  write('2.PvC easy'), nl,
  write('3.CvC'), nl,
  write('4.back'), nl,
  write('Choose an option:'), nl.

startPvPGame:-
  createPvPGame(Game),
  playGame(Game).

startPvBGame:-
  createPvBGame(Game),
  playGame(Game).

startCvCGame:-
  createCvCGame(Game),
  playGame(Game).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
