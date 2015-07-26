%    ___   ___    _______        _       
%   / _ \ / _ \  |__   __|      | |      
%  | (_) | (_) |    | | ___  ___| |_ ___ 
%   \__, |\__, |    | |/ _ \/ __| __/ __|
%     / /   / /     | |  __/\__ \ |_\__ \
%    /_/   /_/      |_|\___||___/\__|___/

%  _   _      _                                      _ _           _            
% | | | | ___| |_ __   ___ _ __   _ __  _ __ ___  __| (_) ___ __ _| |_ ___  ___ 
% | |_| |/ _ \ | '_ \ / _ \ '__| | '_ \| '__/ _ \/ _` | |/ __/ _` | __/ _ \/ __|
% |  _  |  __/ | |_) |  __/ |    | |_) | | |  __/ (_| | | (_| (_| | ||  __/\__ \
% |_| |_|\___|_| .__/ \___|_|    | .__/|_|  \___|\__,_|_|\___\__,_|\__\___||___/
%              |_|               |_|                                            


sublist([], _Ys) :- !.
sublist([X|Xs], Ys) :-
  member(X, Ys),
  sublist(Xs, Ys).


% yields true if two lists, when treated as sets, are the same
setEq(Xs, Ys) :- sublist(Xs, Ys), sublist(Ys, Xs).


pairwise_disjunct([]).
pairwise_disjunct([X|Xs]) :-
  pairwise_disjunct(X, Xs).
pairwise_disjunct(_, []) :- !.
pairwise_disjunct(X, [Y|Ys]) :-
  \+ member(X, [Y|Ys]), !,
  pairwise_disjunct(Y, Ys).


pairwise_disjunct2(Xs) :-
  forall(
    member(Z, Xs),
    (
      select(Z, Xs, L2),
      forall(
        member(Z2, L2),  
        (Z \= Z2)
      )
    )
  ).


pairwise_disjunct3(Xs) :- is_set(Xs). % well, duh...

sum([], 0).
sum([X|Xs], N) :- sum(Xs, NN), N is X+NN.

:- arithmetic_function(fac/1).
fac(0, 1) :- !.
fac(N, F) :- N1 is N-1, fac(N1, F1), F is N * F1.

%:- arithmetic_function(nCr/2).
nCr(N, K, NCR) :- NCR is (fac(N) / (fac(K)*fac(N-K))).

zip([], [], []).
zip([X|Xs], [Y|Ys], [(X,Y)|Zs]) :- zip(Xs,Ys,Zs).

fst((A,_B), A).
snd((_A,B), B).


