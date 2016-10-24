:-include('tabuleiro.pl').

player(whitePlayer).
player(blackPlayer).

getPlayer(whitePlayer, 'White').
getPlayer(blackPlayer, 'Black').

playerPiece(whitePlayer,w1).
playerPiece(whitePlayer,w2).
playerPiece(whitePlayer,w3).
playerPiece(whitePlayer,w4).
playerPiece(whitePlayer,w5).
playerPiece(whitePlayer,w6).

playerPiece(blackPlayer,b1).
playerPiece(blackPlayer,b2).
playerPiece(blackPlayer,b3).
playerPiece(blackPlayer,b4).
playerPiece(blackPlayer,b5).
playerPiece(blackPlayer,b6).

piece(whitePiece).
piece(blackPiece).

playerPiece(whitePiece, whitePlayer).
playerPiece(blackPiece, blackPlayer).

getPlayerPiece(X,Y,Player,Piece):-getPiece(X,Y,Piece),player(Player),playerPiece(Player,Piece).

