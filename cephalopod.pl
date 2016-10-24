:-include('tabuleiro.pl').

%TODO game launcher

playGame:-
        createGame(Game)
        repeat,
        humanPlay(),
        fimDeJogo,
        mostraVencedor.
        
%create(Game):-
                

play(

mostraVencedor:-
        write('venceu').

repeat.
repeat:-
        repeat.