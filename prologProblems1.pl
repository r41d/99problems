%    ___   ___    _____           _     _
%   / _ \ / _ \  |  __ \         | |   | |
%  | (_) | (_) | | |__) | __ ___ | |__ | | ___ _ __ ___  ___
%   \__, |\__, | |  ___/ '__/ _ \| '_ \| |/ _ \ '_ ` _ \/ __|
%     / /   / /  | |   | | | (_) | |_) | |  __/ | | | | \__ \
%    /_/   /_/   |_|   |_|  \___/|_.__/|_|\___|_| |_| |_|___/

%   _     ____            _               _     _     _
%  / |   |  _ \ _ __ ___ | | ___   __ _  | |   (_)___| |_ ___
%  | |   | |_) | '__/ _ \| |/ _ \ / _` | | |   | / __| __/ __|
%  | |_  |  __/| | | (_) | | (_) | (_| | | |___| \__ \ |_\__ \
%  |_(_) |_|   |_|  \___/|_|\___/ \__, | |_____|_|___/\__|___/
%                                 |___/

:- consult(helper).


% 1.01 (*) Find the last element of a list.
% my_last(?Elem, +List)/2
my_last(X, [X|[]]) :- !.
my_last(X, [_|Xs]) :- my_last(X, Xs).


% 1.02 (*) Find the last but one element of a list.
% my_snd_last(?Elem, +List)/2
my_snd_last(X, [X, _|[]]) :- !.
my_snd_last(X, [_|Xs]) :- my_snd_last(X, Xs).


% 1.03 (*) Find the K'th element of a list.
% element_at(?Elem, +List, +Index)/3
element_at(X, [X|_], 1) :- !.
element_at(Elem, [_|Xs], Index) :-
  IndexNew is Index - 1,
  element_at(Elem, Xs, IndexNew).


% 1.04 (*) Find the number of elements of a list.
% my_length(Length, List)/2
my_length([], 0).
my_length([_|Xs], Len) :- my_length(Xs, L1), Len is L1 + 1.


% 1.05 (*) Reverse a list.
% my_reverse(List, ReverseList).
my_reverse([], []).
my_reverse([X|Xs], Rev) :-
  my_reverse(Xs, Ys),
  append(Ys, [X], Rev).


% 1.06 (*) Find out whether a list is a palindrome.
% palindrome(List1)/1
palindrome(L1) :-
  my_reverse(L1, L1).


% 1.07 (**) Flatten a nested list structure.
% my_flatten(List, FlatList)/2
my_flatten([], []) :- !.
my_flatten([X|Xs], Flat) :-
  !,
  my_flatten(X, FlatX),
  my_flatten(Xs, FlatXs),
  append(FlatX, FlatXs, Flat).
my_flatten(X, [X]).


% 1.08 (**) Eliminate consecutive duplicates of list elements.
% compress(List, CompressedList)/2
compress([], []).
compress([X|Xs], Comp) :-
  compressAcc(Xs, [X], C),
  my_reverse(C, Comp),
  !.
compressAcc([], Acc, Acc).
compressAcc([X|Xs], [X|Ys], R) :- !, compressAcc(Xs, [X|Ys], R).
compressAcc([X|Xs], [Y|Ys], R) :- compressAcc(Xs, [X, Y|Ys], R).


% 1.09 (**) Pack consecutive duplicates of list elements into sublists.
% pack(+List, ?List of Lists).
pack([], []).
pack([H|T], R) :-
  packAcc(T, [[H]], R1),
  reverse(R, R1),
  !.
packAcc([], Acc, Acc).
packAcc([H1|T1], [[H1|T2]|Acc], R) :-
  packAcc(T1, [[H1, H1|T2]|Acc], R), !. % red cut
packAcc([H1|T1], [[H2|T2]|Acc], R) :-
  packAcc(T1, [[H1], [H2|T2]|Acc], R).


% 1.10 (*) Run-length encoding of a list.
% encode(List, EncodedList)/2
encode([], []).
encode(List, Enc) :-
  pack(List, Pack),
  encodeAcc(Pack, [], C),
  my_reverse(C, Enc),
  !.
encodeAcc([], Acc, Acc).
encodeAcc([[]|Xs], Ys, R) :-
  encodeAcc(Xs, Ys, R).
encodeAcc([[E|Es]|Xs], [[N, E]|Ys], R) :-
  N1 is N+1,
  encodeAcc([Es|Xs], [[N1, E]|Ys], R).
encodeAcc([[X|Xs]|Xss], Ys, R) :-
  encodeAcc([Xs|Xss], [[1, X]|Ys], R).


% 1.11 (*) Modified run-length encoding.
% encode_modified(List, ModifiedEncodedList)/2
encode_modified([], []) :- !.
encode_modified(List, Mod) :-
  encode(List, Enc),
  eliminate(Enc, [], M),
  my_reverse(M, Mod).
eliminate([], Acc, Acc) :- !.
eliminate([[N, E]|T], Acc, R) :-
  integer(N), N =< 1, !,
  eliminate(T, [E|Acc], R).
eliminate([[N, E]|T], Acc, R) :-
  integer(N), N > 1, !,
  eliminate(T, [[N, E]|Acc], R).


% 1.12 (**) Decode a run-length encoded list.
% decode(Encoded, Decoded).
decode([], []) :- !.
decode(Enc, Dec) :-
  decodeAcc(Enc, [], D),
  my_reverse(D, Dec).
decodeAcc([], Acc, Acc).
decodeAcc([[N, E]|Xs], Ys, Acc) :-
  !,
  replicate(N, E, L),
  append(L, Ys, NewYs),
  decodeAcc(Xs, NewYs, Acc).
decodeAcc([X|Xs], Ys, Acc) :-
  !,
  decodeAcc(Xs, [X|Ys], Acc).
replicate(0, _, []) :- !.
replicate(NN, X, [X|L]) :- N is NN-1, replicate(N, X, L).


% 1.13 (**) Run-length encoding of a list (direct solution).
% encode_direct(List, EncodedList)/2
encode_direct([], _).
encode_direct([H|T], Enc) :-
  encode_directAcc(T, [[1, H]], E),
  eliminate(E, [], Enc).
encode_directAcc([], Acc, Acc) :- !.
encode_directAcc([E|Xs], [[N, E]|Ys], R) :-
  !, N1 is N+1, encode_directAcc(Xs, [[N1, E]|Ys], R).
encode_directAcc([X|Xs], [[N, E]|Ys], R) :-
  encode_directAcc(Xs, [[1, X], [N, E]|Ys], R).


% 1.14 (*) Duplicate the elements of a list.
% dupli(List, DupliList)/2
dupli([], []).
dupli([X|Xs], [X, X|Ys]) :- dupli(Xs, Ys).


% 1.15 (**) Duplicate the elements of a list a given number of times.
% dupli(+List, +Number, ?DupliList)/3
dupli([], _, []).
dupli([X|Xs], N, Z) :-
  replicate(N, X, R),
  dupli(Xs, N, D),
  append(R, D, Z),
  !.


% 1.16 (**) Drop every N'th element from a list.
% drop(+List, +N, ?DropList)/3
drop(L, N, D) :-
  N1 is N-1,
  dropping(L, N1, N, D),
  !.
dropping([], _, _, []).
dropping([_|Xs], 0, N, D) :-
  K is N-1,
  dropping(Xs, K, N, D).
dropping([X|Xs], K, N, [X|D]) :- % N > 0
  K1 is K-1,
  dropping(Xs, K1, N, D).


% 1.17 (*) Split a list into two parts; the length of the first part is given.
% split(+List, +Len1, ?Part1, ?Part2).
split([], _, [], []).
split(Xs, 0, [], Xs).
split([X|Xs], L, [X|PP1], P2) :-
  NewL is L - 1,
  split(Xs, NewL, PP1, P2),
  !.


% 1.18 (**) Extract a slice from a list.
% slice(+List, +Start, +End, ?SliceList)/4
slice([], _, _, []) :- !.
slice(_, 1, 0, []) :- !.
slice([X|Xs], 1, End, Result) :-
  !,
  NewEnd is End - 1,
  slice(Xs, 1, NewEnd, SliceList),
  append([X], SliceList, Result).
slice([_|Xs], Start, End, SliceList) :- % Start > 1
  !,
  NewStart is Start - 1,
  NewEnd is End - 1,
  slice(Xs, NewStart, NewEnd, SliceList).


% 1.19 (**) Rotate a list N places to the left.
% rotate(List, Num, RotatedList)/3
rotate(L, 0, L) :- !.
rotate(L, N, R) :-
  N < 0, !,
  my_length(L, Len), NN is Len + N,
  rotate(L, NN, R).
rotate(L, N, R) :-
  split(L, N, Front, Back),
  append(Back, Front, R),
  !.


% 1.20 (*) Remove the K'th element from a list.
% remove_at(?Elem, +List, +Index, ?RestList)/4
remove_at(E, L, N, R) :-
  split(L, N, P1, P2),
  my_last(E, P1),
  SliceLen is N - 1,
  slice(P1, 1, SliceLen, Slice),
  append(Slice, P2, R).


% 1.21 (*) Insert an element at a given position into a list.
% insert_at(?Elem, +List, +Index, ?NewList)/4
insert_at(E, L, 1, [E|L]) :- !.
insert_at(E, [H|T], N, R) :-
  N1 is N-1,
  insert_at(E, T, N1, R1),
  append([H], R1, R).


% 1.22 (*) Create a list containing all integers within a given range.
% range(+Lower, +Upper, ?RangeList)/3
range(L, U, []) :- L > U, !.
range(L, L, [L]) :- !.
range(L, U, [L|Rng]) :- L1 is L+1, range(L1, U, Rng).


% 1.23 (**) Extract a given number of randomly selected elements from a list.
% rnd_select(+List, +Number, -RandomElemList)/3
rnd_select(_, 0, []) :- !.
rnd_select(L, N, [Elem|T]) :-
  my_length(L, Len),
  random_between(1, Len, Idx),
  remove_at(Elem, L, Idx, Rest),
  N1 is N-1,
  rnd_select(Rest, N1, T).


% 1.24 (*) Lotto: Draw N different random numbers from the set 1..M.
% rnd_lotto(+Num, +Maximum, -NumberList).
rnd_lotto(N, M, L) :-
  range(1, M, List),
  rnd_select(List, N, L).


% 1.25 (*) Generate a random permutation of the elements of a list.
% rnd_permu(+List, -PermList)/2
rnd_permu(List, Perm) :-
  my_length(List, Len),
  rnd_select(List, Len, Perm).


% 1.26 (**) Generate the combinations of K distinct objects chosen from the N elements of a list
% combination(+K, +List, ?SubListWithLengthK)/3
combination(0, _, []) :- !.
combination(K, [H|Rest], [H|T]) :-
  K1 is K-1,
  combination(K1, Rest, T).
combination(K, [_H|Rest], T) :-
  combination(K, Rest, T).
%combination2(0, _, []).
%combination2(K, List, [H|T]) :-
%  member(H, List),
%  K1 is K-1,
%  select(H, List, Rest), % remove first occurence of H from List
%  combination2(K1, Rest, T).


% 1.27 (**) Group the elements of a set into disjoint subsets.
% a) In how many ways can a group of 9 people work in 3 disjoint subgroups of 2, 3 and 4 persons? Write a predicate that generates all the possibilities via backtracking.
% group3(+NamesList, ?Group2, ?Group3, ?Group4).
group3(L, G2, G3, G4) :-
  length(L, 9),

  combination(2, L, G2),

  subtract(L, G2, L2),
  combination(3, L2, G3),

  subtract(L2, G3, G4).

% b) Generalize the above predicate in a way that we can specify a list of group sizes and the predicate will return a list of groups.
% group(+NamesList, +SizesList, ?Groups).
group([], [], []) :- !.
%group(_, [], []) :- writeln('ERROR: sum(SizesList) != length(NamesList)'), fail.
group(Names, [S|Sizes], [G|Groups]) :-

  % check input for mistakes
  length(Names, Len),
  sum([S|Sizes], Len),
  !,

  combination(S, Names, G),

  subtract(Names, G, Rest),
  group(Rest, Sizes, Groups).

group(_, _, _) :- writeln('FAILBOB: length(NamesList) != sum(SizesList)'), fail.


% 1.28 (**) Sorting a list of lists according to length of sublists
% a) We suppose that a list (InList) contains elements that are lists themselves. The objective is to sort the elements of InList according to their length. E.g. short lists first, longer lists later, or vice versa.
% lsort(+InList, ?SortedByLengthList)/2
lsort(LOL, Res) :-
  maplist(my_length, LOL, Lengths),
  zip(Lengths, LOL, Zip),
  sort(0, @=<, Zip, Sorted),
  maplist(snd, Sorted, Res).

% b) Again, we suppose that a list (InList) contains elements that are lists themselves. But this time the objective is to sort the elements of InList according to their length frequency; i.e. in the default, where sorting is done ascendingly, lists with rare lengths are placed first, others with a more frequent length come later.
% lfsort(+InList, ?SortedList)/2
:- dynamic lenfreq/2.
lfsort(LOL, Res) :-
  retractall(lenfreq(_,_)),

  maplist(my_length, LOL, Lengths),

  msort(Lengths, LengthsSorted), % msort! sort is WRONG
  encode(LengthsSorted, LengthsSortedEncoded),
  forall(
    member([Freq,Len], LengthsSortedEncoded),
    assert(lenfreq(Freq,Len))
  ),

  maplist(lenfreq, Frequencies, Lengths),
  zip(Frequencies, LOL , Zip),

  sort(0, @=<, Zip, Sorted),
  maplist(snd, Sorted, Res).


