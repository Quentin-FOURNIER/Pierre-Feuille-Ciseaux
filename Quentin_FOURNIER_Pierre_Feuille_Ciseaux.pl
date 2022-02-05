% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%  							  %
%         PROJET PROLOG - PIERRE FEUILLE CISEAUX          %
%							  %
%                    Quentin FOURNIER                     %
%						          %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


% % % % % % % % % % % % % IMPORTS % % % % % % % % % % % % %

:- use_module(library(dif)).

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %




% % % % % % % % % % % % STRATEGIECST  % % % % % % % % % % %	   
% Stratégie constante qui donne toujours la pierre.	  

strategieCst(_N,_R,pierre).

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 




% % % % % % % % % % % % STRATEGIE01 % % % % % % % % % % % %
% Stratégie simple qui alterne le papier et les ciseaux, 
% par exemple selon le numéro de la manche 
% (pair=>papier, impair=>ciseaux).

strategie01(N,_R, papier) :-
    N mod 2 =:= 0.

strategie01(N,_R,ciseaux) :-
    N mod 2 =:= 1.

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %