%    ___   ___    _______        _       
%   / _ \ / _ \  |__   __|      | |      
%  | (_) | (_) |    | | ___  ___| |_ ___ 
%   \__, |\__, |    | |/ _ \/ __| __/ __|
%     / /   / /     | |  __/\__ \ |_\__ \
%    /_/   /_/      |_|\___||___/\__|___/

%   _     ____            _               _     _     _       
%  / |   |  _ \ _ __ ___ | | ___   __ _  | |   (_)___| |_ ___ 
%  | |   | |_) | '__/ _ \| |/ _ \ / _` | | |   | / __| __/ __|
%  | |_  |  __/| | | (_) | | (_) | (_| | | |___| \__ \ |_\__ \
%  |_(_) |_|   |_|  \___/|_|\___/ \__, | |_____|_|___/\__|___/
%                                 |___/                       

% 1.01 (*) Find the last element of a list.
% my_last(?Elem, +List)/2
:- begin_tests(my_last).
test(my_last, [true(X =@= d)]) :- my_last(X, [a,b,c,d]).
:- end_tests(my_last).

% 1.02 (*) Find the last but one element of a list.
% my_snd_last(?Elem, +List)/2
:- begin_tests(my_snd_last).
test(my_snd_last, [true(X =@= c)]) :- my_snd_last(X, [a,b,c,d]).
:- end_tests(my_snd_last).

% 1.03 (*) Find the K'th element of a list.
% element_at(?Elem, +List, +Index)/3
:- begin_tests(element_at).
test(element_at, [true(X =@= c)]) :- element_at(X, [a,b,c,d,e], 3).
:- end_tests(element_at).

% 1.04 (*) Find the number of elements of a list.
% my_length(Length, List)/2
:- begin_tests(my_length).
test(my_length, [true(X =:= 4)]) :- my_length([a,b,c,d], X).
test(my_length) :- L = [a,b,c,d], my_length(L, Len), length(L, Len).
:- end_tests(my_length).

% 1.05 (*) Reverse a list.
% my_reverse(List, ReverseList).
:- begin_tests(my_reverse).
test(my_reverse) :- my_reverse([a,b,c,d], [d,c,b,a]).
test(my_reverse, [true(R1 =@= R2)]) :-
  L = [a,b,c,d], my_reverse(L, R1), reverse(L, R2).
test(my_reverse, [true(R =@= L)]) :-
  L = [a,b,c,d], my_reverse(L, X), reverse(X, R).
:- end_tests(my_reverse).

% 1.06 (*) Find out whether a list is a palindrome.
% palindrome(List1)/1
:- begin_tests(palindrome).
test(palindrome) :- L = [x,a,m,a,x], my_reverse(L, L), reverse(L, L).
:- end_tests(palindrome).

% 1.07 (**) Flatten a nested list structure.
% my_flatten(List, FlatList)/2
:- begin_tests(my_flatten).
test(my_flatten, [true(X =@= [a,b,c,d,e])]) :-
  my_flatten([a,[b,[c,d],e]], X).
test(my_flatten, [true(Flat1 =@= Flat2)]) :-
  L = [a,[b,[c,d],e]],
  my_flatten(L, Flat1),
  flatten(L, Flat2).
:- end_tests(my_flatten).

% 1.08 (**) Eliminate consecutive duplicates of list elements.
% compress(List, CompressedList)/2
:- begin_tests(compress).
test(compress, [true(X =@= [a,b,c,a,d,e])]) :-
  compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e], X).
:- end_tests(compress).

% 1.09 (**) Pack consecutive duplicates of list elements into sublists.
% pack(+List, ?List of Lists).
:- begin_tests(pack).
test(pack, [true(X =@= [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]])]) :-
  pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e], X).
:- end_tests(pack).

% 1.10 (*) Run-length encoding of a list.
% encode(List, EncodedList)/2
:- begin_tests(encode).
test(encode, [true(X =@= [[4,a],[1,b],[2,c],[2,a],[1,d],[4,e]])]) :-
  encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e], X).
:- end_tests(encode).

% 1.11 (*) Modified run-length encoding.
% encode_modified(List, ModifiedEncodedList)/2
:- begin_tests(encode_modified).
test(encode_modified, [true(X =@= [[4,a],b,[2,c],[2,a],d,[4,e]])]) :-
  encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e], X).
:- end_tests(encode_modified).

% 1.12 (**) Decode a run-length encoded list.
% decode(Encoded, Decoded).
:- begin_tests(decode).
test(decode, [true(D =@= L)]) :-
  L = [a,a,a,a,b,c,c,a,a,d,e,e,e,e],
  encode(L, E), decode(E, D).
:- end_tests(decode).

% 1.13 (**) Run-length encoding of a list (direct solution).
% encode_direct(List, EncodedList)/2
:- begin_tests(encode_direct).
test(encode_direct, [true(X =@= [[4,a],b,[2,c],[2,a],d,[4,e]])]) :-
  encode_direct([a,a,a,a,b,c,c,a,a,d,e,e,e,e], X).
:- end_tests(encode_direct).

% 1.14 (*) Duplicate the elements of a list.
% dupli(List, DupliList)/2
:- begin_tests(dupli2).
test(dupli2, [true(X =@= [a,a,b,b,c,c,c,c,d,d])]) :-
  dupli([a,b,c,c,d], X).
:- end_tests(dupli2).

% 1.15 (**) Duplicate the elements of a list a given number of times.
% dupli(+List, +Number, ?DupliList)/3
:- begin_tests(dupli3).
test(dupli3, [true(X =@= [a,a,a,b,b,b,c,c,c])]) :-
  dupli([a,b,c], 3, X).
:- end_tests(dupli3).

% 1.16 (**) Drop every N'th element from a list.
% drop(+List, +N, ?DropList)/3
:- begin_tests(drop).
test(drop, [true(X =@= [a,b,d,e,g,h,k])]) :-
  drop([a,b,c,d,e,f,g,h,i,k], 3, X).
:- end_tests(drop).

% 1.17 (*) Split a list into two parts; the length of the first part is given.
% split(+List, +Len1, ?Part1, ?Part2).
:- begin_tests(split).
test(split) :-
  List =[a,b,c,d,e,f,g,h,i,k],
  split(List, 3, L1, L2),
  !,
  L1 = [a,b,c],
  L2 = [d,e,f,g,h,i,k],
  append(L1, L2, List).
:- end_tests(split).

% 1.18 (**) Extract a slice from a list.
% slice(+List, +Start, +End, ?SliceList)/4
:- begin_tests(slice).
test(slice, [true(X =@= [c,d,e,f,g])]) :-
  slice([a,b,c,d,e,f,g,h,i,k], 3, 7, X).
test(slice, [true(X =@= [a,b,c,d,e])]) :-
  slice([a,b,c,d,e,f,g,h,i,k], 1, 5, X).
test(slice, [true(X =@= [h,i,k])]) :-
  slice([a,b,c,d,e,f,g,h,i,k], 8, 10, X).
test(slice, [true(X =@= [i,k])]) :-
  slice([a,b,c,d,e,f,g,h,i,k], 9, 12, X).
:- end_tests(slice).

% 1.19 (**) Rotate a list N places to the left.
% rotate(List, Num, RotatedList)/3
:- begin_tests(rotate).
test(rotate, [true(X =@= [d,e,f,g,h,a,b,c])]) :-
  rotate([a,b,c,d,e,f,g,h], 3, X).
test(rotate, [true(X =@= [g,h,a,b,c,d,e,f])]) :-
  rotate([a,b,c,d,e,f,g,h], -2, X).
:- end_tests(rotate).

% 1.20 (*) Remove the K'th element from a list.
% remove_at(?Elem, +List, +Index, ?RestList)/4
:- begin_tests(remove_at).
test(remove_at) :- remove_at(X, [a,b,c,d], 1, R), !, X =@= a, R = [b,c,d].
test(remove_at) :- remove_at(X, [a,b,c,d], 2, R), !, X =@= b, R = [a,c,d].
test(remove_at) :- remove_at(X, [a,b,c,d], 3, R), !, X =@= c, R = [a,b,d].
test(remove_at) :- remove_at(X, [a,b,c,d], 4, R), !, X =@= d, R = [a,b,c].
:- end_tests(remove_at).

% 1.21 (*) Insert an element at a given position into a list.
% insert_at(?Elem, +List, +Index, ?NewList)/4
:- begin_tests(insert_at).
test(insert_at, [true(L =@= [a,alfa,b,c,d])]) :-
  insert_at(alfa, [a,b,c,d], 2, L).
:- end_tests(insert_at).

% 1.22 (*) Create a list containing all integers within a given range.
% range(+Lower, +Upper, ?RangeList)/3
:- begin_tests(range).
test(range, [true(L = [4,5,6,7,8,9])]) :-
  range(4, 9, L).
:- end_tests(range).

% 1.23 (**) Extract a given number of randomly selected elements from a list.
% rnd_select(+List, +Number, ?RandomElemList)/3
:- begin_tests(rnd_select).
test(rnd_select, [nondet]) :- % how to test random predicates...
  List = [a,b,c,d,e,f,g,h],
  rnd_select(List, 3, L), !,
  sublist(L, List). % ensure that L is-sublist-of List
:- end_tests(rnd_select).

% 1.24 (*) Lotto: Draw N different random numbers from the set 1..M.
% rnd_lotto(+Num, +Maximum, ?NumberList).
:- begin_tests(rnd_lotto).
test(rnd_lotto, [nondet]) :- % how to test random predicates, part 2
  Nums = 6, Max = 49,
  rnd_lotto(Nums, Max, L),
  !,
  length(L, Nums),
  forall( % all numbers in range
    member(Z, L),
    (Z >= 1 , Z =< Max)
  ),
  pairwise_disjunct2(L).
:- end_tests(rnd_lotto).

% 1.25 (*) Generate a random permutation of the elements of a list.
% rnd_permu(+List, ?PermList)/2
:- begin_tests(rnd_permu).
test(rnd_permu, [nondet]) :- % how to test random predicates, part 3
  List = [a,b,c,d,e,f], rnd_permu(List, Perm), !,
  length(List, Len1), length(Perm, Len2), Len1 =:= Len2, % lengths the same
  sublist(List, Perm), % List is-sublist-of Perm
  sublist(Perm, List). % Perm is-sublist-of List
:- end_tests(rnd_permu).

% 1.26 (**) Generate the combinations of K distinct objects chosen from the N elements of a list
% combination(+K, +List, ?SubListWithLengthK)/3
:- begin_tests(combination). % how to test with nondet in a cool way, part 1
test(combination, [true(SublistsLen =:= NCR), nondet]) :-
  Len = 3, List = [a,b,c,d,e,f],

  % collect all solutions
  bagof(L, combination(Len, List, L), Sublists),

  % length(Sublists) =!= length(List) `nCr` Len
  length(Sublists, SublistsLen),
  length(List, ListLen),
  nCr(ListLen, Len, NCR),

  % ∀L:
  forall(
    member(L, Sublists),
    (
      length(L, Len), % L has length Len
      sublist(L, List) % and L is-sublist-of List
    )
  ).
:- end_tests(combination).

% 1.27 (**) Group the elements of a set into disjoint subsets.
% a) group3(+NamesList, ?Group2, ?Group3, ?Group4).
% b) group(+NamesList, +SizesList, ?Groups).
:- begin_tests(group3).
test(group3, [nondet]) :- % grad keine Lust hier alles zu checken
  group3([aldo,beat,carla,david,evi,flip,gary,hugo,ida],G1,G2,G3),
  G1 = [aldo,beat], G2 = [carla,david,evi], G3 = [flip,gary,hugo,ida].
:- end_tests(group3).
:- begin_tests(group).
test(group, [nondet]) :- % grad keine Lust hier alles zu checken
  group([aldo,beat,carla,david,evi,flip,gary,hugo,ida],[2,2,5],Gs),
  Gs = [[aldo,beat],[carla,david],[evi,flip,gary,hugo,ida]].
:- end_tests(group).


% 1.28 (**) Sorting a list of lists according to length of sublists
% a) lsort(+InList, ?SortedByLengthList)/2
% b) lfsort(+InList, ?SortedList)/2
:- begin_tests(lsort).
test(lsort) :-
  List = [[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]],
  lsort(List, L),
  L = [H|T],
  H = [o],
  my_last([i, j, k, l], T),
  length(List, Len), length(L, Len).
:- end_tests(lsort).
:- begin_tests(lfsort).
test(lfsort) :-
  List = [[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]],
  lfsort(List, L),
  L = [H|T],
  ( H=[i, j, k, l] ; H=[o] ),
  length(List, Len), length(L, Len).
:- end_tests(lfsort).
















