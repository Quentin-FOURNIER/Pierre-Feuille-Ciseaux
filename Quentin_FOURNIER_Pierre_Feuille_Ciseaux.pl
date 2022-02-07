% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%  							  %
%         PROJET PROLOG - PIERRE FEUILLE CISEAUX          %
%							  %
%                    Quentin FOURNIER                     %
%						          %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


%%%%%%%%%%%%%%%%%%%%%%%%% IMPORTS %%%%%%%%%%%%%%%%%%%%%%%%%

:- use_module(library(dif)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%% UTILS %%%%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %	   
% Permet de récupérer le coup du joueur deux, d'il y a 2  %
% tours                                            	  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

popCouple2([[_C1,C2]|_L],C2).

pop1([_P|L],F):-
	popCouple2(L,F).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIECST  %%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %	   
% Stratégie constante qui donne toujours la pierre.	  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

strategieCst(_N,_R,pierre).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIE01 %%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Stratégie simple qui alterne le papier et les ciseaux,  %
% par exemple selon le numéro de la manche 		  %
% (pair=>papier, impair=>ciseaux).			  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

strategie01(N,_R, papier) :-
    N mod 2 =:= 0.

strategie01(N,_R,ciseaux) :-
    N mod 2 =:= 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIE02 %%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Stratégie qui répète un cycle de coups (si le cycle est %
% court, c'est une stratégie qui peut_ paraitre 'simple') %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

strategie02(N,_R,papier) :-
    N mod 3 =:= 0.

strategie02(N,_R,ciseaux) :-
    N mod 3 =:= 1.

strategie02(N,_R,pierre) :-
    N mod 3 =:= 2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIE03 %%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% stratégie qui détermine le coup de manière difficile à  %
% prévoir en fonction du numéro de la manche		  %
% N multiple de 5 => papier				  %
% N multiple de 2 et non multiple de 5 => ciseaux	  %
% Sinon => pierre					  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

strategie03(N,_R,papier) :-
	N mod 5 =:= 0.

strategie03(N,_R,ciseaux) :-
	N mod 5 =\= 0,
	N mod 2 =:= 0.

strategie03(N,_R,pierre) :-
	N mod 5 =\= 0,
	N mod 2 =\= 0.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIE11 %%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Stratégie qui répète le dernier coup du joueur 2	  %
% papier, ou n'importe quoi, quand il n'y a pas de 	  %
% dernier coup (si c'est le premier coup)                 %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

strategie11(_N,[],papier).

strategie11(_N,[[_C1,C2]|_L],C2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIE12 %%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Stratégie pour le joueur 1 qui joue en fonction du      %
% dernier coup du joueur 2 pour le contrer en supposant   %
% que le joueur 2 ne changera pas de coup		  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

strategie12(_N,[], papier).

strategie12(_N,[[_C1,C2]|_L], papier) :-
    C2 == pierre.

strategie12(_N,[[_C1,C2]|_L], pierre) :-
    C2 == ciseaux.

strategie12(_N,[[_C1,C2]|_L], ciseaux) :-
    C2 == papier.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIE13 %%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Stratégie pour le joueur 1 qui joue en fonction de son  %
% dernier coup et suppose que le joueur 2 va vouloir 	  %
% contrer ce dernier coup				  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

strategie13(_N,[], papier).

strategie13(_N,[[C1,_C2]|_L], papier) :-
    C1 == ciseaux.

strategie13(_N,[[C1,_C2]|_L], pierre) :-
    C1 == papier.

strategie13(_N,[[C1,_C2]|_L], ciseaux) :-
    C1 == pierre.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIE14 %%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Stratégie pour le joueur 1 qui joue en fonction de son  %
% dernier coup et le répète s'il a été gagnant.	          %
% Sinon change de coup					  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

strategie14(_N,[], papier).

strategie14(_N,[[C1,C2]|_L], C1) :-
    C1 == ciseaux, C2 == papier;
    C1 == papier, C2 == pierre;
    C1 == pierre, C2 == ciseaux.

strategie14(_N,[[C1,C2]|_L], pierre) :-
    C1 == ciseaux, 
    C2 \== papier.

strategie14(_N,[[C1,C2]|_L], papier) :-
    C1 == pierre, 
    C2 \== ciseaux.

strategie14(_N,[[C1,C2]|_L], ciseaux) :-
    C1 == papier, 
    C2 \== pierre.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIE21 %%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Stratégie pour le joueur 1 qui regarde les 2 dernières  %
% manches et suppose que le joueur 2 alterne sur 2	  % 
% stratégies seulement					  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

strategie21(_N, R, papier) :-
    length(R, Len),
    Len < 2.

strategie21(_N, R, papier) :-
    pop1(R,J),
    J==pierre.

strategie21(_N, R, pierre) :-
    pop1(R,J),
    J==ciseaux.

strategie21(_N, R, ciseaux) :-
    pop1(R,J),
    J==papier.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIE31 %%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% stratégie pour le joueur 1 qui regarde sur ces          %
% dernières manches si l'un de ses coups est plus         %
% favorable	  					  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
couple3(3,_L, Z1,Z2,Z3,Z1, Z2,Z3).
   
couple3(_N,Liste, _EntryPierre,_EntryPapier,_EntryCiseaux,0, 0, 0) :-
    length(Liste, Len),
    Len<3.

% Victoire pierre
couple3(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [pierre, ciseaux],
    NewPierre is EntryPierre + 2,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier,
    couple3(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Victoire papier
couple3(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [papier, pierre],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier + 2,
    couple3(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Victoire ciseaux
couple3(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [ciseaux, papier],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux + 2,
    NewPapier is EntryPapier,
    couple3(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Egalité pierre
couple3(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [pierre, pierre],
    NewPierre is EntryPierre + 1,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier,
    couple3(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Egalité papier
couple3(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [papier, papier],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier + 1,
    couple3(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Egalité ciseaux
couple3(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [ciseaux, ciseaux],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux + 1,
    NewPapier is EntryPapier,
    couple3(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Défaite ciseaux
couple3(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [ciseaux, pierre],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier,
    couple3(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Défaite pierre
couple3(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [pierre, papier],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier,
    couple3(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% pierre
strategie31(_N, Liste,pierre) :-
    couple3(0,Liste,0,0,0,Pierre,Papier,Ciseaux),
    Pierre >= Papier,
    Pierre >= Ciseaux.

% ciseaux
strategie31(_N, Liste,ciseaux) :-
    couple3(0,Liste,0,0,0,Pierre,Papier,Ciseaux),
    Ciseaux >= Papier,
    Ciseaux > Pierre.

% papier
strategie31(_N, Liste,papier) :-
    couple3(0,Liste,0,0,0,Pierre,Papier,Ciseaux),
    Papier > Ciseaux,
    Papier > Pierre.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIEN1 %%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% stratégie pour le joueur 1 qui regarde toutes les       %
% manches pour voir si l'un de ses coups est plus 	  %
% favorable en moyenne					  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

couple(_K,[], Z1,Z2,Z3,Z1, Z2,Z3).

% Victoire pierre
couple(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [pierre, ciseaux],
    NewPierre is EntryPierre + 2,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier,
    couple(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Victoire papier
couple(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [papier, pierre],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier + 2,
    couple(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Victoire ciseaux
couple(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [ciseaux, papier],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux + 2,
    NewPapier is EntryPapier,
    couple(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Egalité pierre
couple(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [pierre, pierre],
    NewPierre is EntryPierre + 1,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier,
    couple(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Egalité papier
couple(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [papier, papier],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier + 1,
    couple(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Egalité ciseaux
couple(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [ciseaux, ciseaux],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux + 1,
    NewPapier is EntryPapier,
    couple(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Défaite ciseaux
couple(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [ciseaux, pierre],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier,
    couple(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% Défaite pierre
couple(Iterateur, [SousListe|Liste], EntryPierre,EntryPapier,EntryCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux) :-
    Iterateur1 is Iterateur + 1,
    SousListe == [pierre, papier],
    NewPierre is EntryPierre,
    NewCiseaux is EntryCiseaux,
    NewPapier is EntryPapier,
    couple(Iterateur1, Liste, NewPierre,NewPapier,NewCiseaux,ReturnPierre, ReturnPapier, ReturnCiseaux).

% pierre
strategieN1(_N, Liste,pierre) :-
    couple(0,Liste,0,0,0,Pierre,Papier,Ciseaux),
    Pierre >= Papier,
    Pierre >= Ciseaux.

% ciseaux
strategieN1(_N, Liste,ciseaux) :-
    couple(0,Liste,0,0,0,Pierre,Papier,Ciseaux),
    Ciseaux >= Papier,
    Ciseaux > Pierre.

% papier
strategieN1(_N, Liste,papier) :-
    couple(0,Liste,0,0,0,Pierre,Papier,Ciseaux),
    Papier > Ciseaux,
    Papier > Pierre.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%