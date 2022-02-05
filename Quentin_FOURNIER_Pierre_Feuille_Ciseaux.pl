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

strategie02(N,_R,feuille) :-
    N mod 3 =:= 2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% STRATEGIE03 %%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% stratégie qui détermine le coup de manière difficile à  %
% prévoir en fonction du numéro de la manche		  %
% N multiple de 5 => papier				  %
% N multiple de 2 et non multiple de 5 => ciseaux	  %
% Sinon => feuille					  %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

strategie03(N,_R,papier) :-
	N mod 5 =:= 0.

strategie03(N,_R,ciseaux) :-
	N mod 5 =\= 0,
	N mod 2 =:= 0.

strategie03(N,_R,feuille) :-
	N mod 5 =\= 0,
	N mod 2 =\= 0.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%