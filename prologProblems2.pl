%    ___   ___    _____           _     _
%   / _ \ / _ \  |  __ \         | |   | |
%  | (_) | (_) | | |__) | __ ___ | |__ | | ___ _ __ ___  ___
%   \__, |\__, | |  ___/ '__/ _ \| '_ \| |/ _ \ '_ ` _ \/ __|
%     / /   / /  | |   | | | (_) | |_) | |  __/ | | | | \__ \
%    /_/   /_/   |_|   |_|  \___/|_.__/|_|\___|_| |_| |_|___/

%   ____         _         _ _   _                    _   _
%  |___ \       / \   _ __(_) |_| |__  _ __ ___   ___| |_(_) ___
%    __) |     / _ \ | '__| | __| '_ \| '_ ` _ \ / _ \ __| |/ __|
%   / __/ _   / ___ \| |  | | |_| | | | | | | | |  __/ |_| | (__
%  |_____(_) /_/   \_\_|  |_|\__|_| |_|_| |_| |_|\___|\__|_|\___|


:- consult(helper).
:- consult(prologProblems1).


% 2.01 (**) Determine whether a given integer number is prime.
% is_prime(+Number)/1
:- dynamic prime/1.
is_prime(2) :- !.
is_prime(3) :- !.
is_prime(X) :- prime(X), !.
is_prime(N) :-
  SqrtN is sqrt(N),
  range(2, SqrtN, Range),
  forall(
    member(X, Range),
    ( 
      N rem X \= 0
    )
  ),
  assert(prime(N)).


% 2.02 (**) Determine the prime factors of a given positive integer.
% prime_factors(+Number, ?PrimeFactorList)/2
prime_factors(X, _) :- X < 0, !, fail.
prime_factors(X, [X]) :- X < 2, !.
prime_factors(N, L) :-
  prime_factors(N, 2, L).
prime_factors(1, _F, []) :- !.
%prime_factors(N, F, []) :- F > N, !.
prime_factors(N, F, [H|T]) :- % Number, Factor, Length
  R is N rem F, % Remainder, Number, Factor
  R =:= 0 % Remainder zero
    -> ( H=F, N1 is N//F, prime_factors(N1,F,T) ) % dont increment yet
     ; ( F1 is F+1, prime_factors(N,F1,[H|T]) ). % increment F.


% 2.03 (**) Determine the prime factors of a given positive integer (2).
% prime_factors_mult(+Number, ?PrimeFactorListRunLengthEncoded)/2
prime_factors_mult(N, L) :-
  prime_factors(N, P),
  encode(P, L).


% 2.04 (*) A list of prime numbers.
% prime_list(+Lower, +Upper, ?PrimesList)/3
prime_list(L, U, P) :-
  range(L, U, R),
  include(is_prime, R, P).


% 2.05 (**) Goldbach's conjecture.
% goldbach(+Number, ?ListWithTwoPrimes)/2
goldbach(N, _) :- N =< 2, fail, !.
goldbach(N, [P1,P2]) :-
  prime_list(2, N, Primes),
  member(P1, Primes),      % get one prime
  Half is N/2, P1 < Half,  % hack to avoid redundant results
  member(P2, Primes),      % get another prime
  N =:= P1+P2.             % succeed if N is the sum of P1 and P2


% 2.06 (**) A list of Goldbach compositions.

% a) Given a range of integers by its lower and upper limit, print a list of all even numbers and their Goldbach composition.

% goldbach_list(+Lower, +Upper)/2
goldbach_list(L, U) :-
  goldbach_list(L, U, _, _, _).
% goldbach_list(+Lower, +Upper, -Num, -Prime1, -Prime2)/2
goldbach_list(L, U, N, P1, P2) :-
  range(L, U, R),
  include(even, R, R2),
  member(N, R2),
  call(goldbach1(N, [P1,P2])), printEquation(N,P1,P2).
goldbach1(N,PP) :- goldbach(N,PP), !. % goldbach that only yields first result
even(X) :- R is X rem 2, R =:= 0.
printEquation(S, A1, A2) :-
  write(S), write(' = '), write(A1), write(' + '), writeln(A2).

% b) In most cases, if an even number is written as the sum of two prime numbers, one of them is very small. Very rarely, the primes are both bigger than say 50.
% goldbach_list(+Lower, +Upper, +Minimum)/3
goldbach_list(L, U, M) :-
  range(L, U, R),
  include(even, R, R2),
  member(N, R2),
  goldbachM(N, [P1,P2], M),
  printEquation(N,P1,P2).
% goldbach that only yields first result with both numbers >=M
goldbachM(N, [P1,P2], M) :-
  goldbach(N, [P1,P2]),
  P1 >= M, P2 >= M, !.


% 2.07 (**) Determine the greatest common divisor of two positive integer numbers.
% gcd(+Number1, +Number2, ?GCD)/3
:- arithmetic_function(gcd/2).
gcd(A, B, G) :-
  B > A, !,      % switch numbers when A < B
  gcd(B, A, G).
gcd(A, B, G) :- % A >= B
  Rem is A rem B,
  Rem == 0,
  !,
  G=B.
gcd(A, B, G) :- % assert A >= B
  Rem is A rem B, % assert Rem != 0
  gcd(B,Rem,G).


% 2.08 (*) Determine whether two positive integer numbers are coprime.
% Two numbers are coprime if their greatest common divisor equals 1.
% coprime(+Prime1, +Prime2)/2
coprime(P1, P2) :- (P1<2 ; P2<2), fail, !.
coprime(P1, P2) :-
  gcd(P1, P2, 1).


% 2.09 (**) Calculate Euler's totient function phi(m).
% totient_phi(+Num, ?Phi)/2
:- arithmetic_function(totient_phi/1).
:- dynamic m/1.
totient_phi(1, 1) :- !.
totient_phi(M, Phi) :-
  retractall(m(_)),
  range(1, M, R),
  assert(m(M)),
  include(copM, R, R2),
  length(R2, Phi),
  retractall(m(_)).
copM(X) :- m(M), coprime(M, X).


% 2.10 (**) Calculate Euler's totient function phi(m) (2).
% phi(m) = (p1-1)*p1^(m1-1) * (p2-1)*p2^(m2-1) * (p3-1)*p3^(m3-1) * ...
% where p,m are prime factors and their multiplicities
% phi(+Num, ?Phi)/2
:- arithmetic_function(phi/1).
phi(1, 1) :- !.
phi(M, Phi) :-
  prime_factors_mult(M, PrimFacs), % [Frequency, Element]
  maplist(totientHelper, PrimFacs, Nums),
  foldl(product, Nums, 1, Phi).
totientHelper([M, P], X) :- % M=Multiplicity P=Prime
  X is (P-1)*P^(M-1).
product(X,Y,Z) :- Z is X*Y. % stupid helper


% 2.11 (*) Compare the two methods of calculating Euler's totient function.
% test_totient()/0
% test_totient(+Maximum)/1
% test_totient(+Minimum, +Maximum)/2
test_totient :-
  test_totient(1000).
test_totient(Max) :-
  test_totient(1, Max).
test_totient(Min, Max) :-
  range(Min, Max, Range),
  maplist(totient_phi, Range, Totient),
  maplist(phi,         Range, Phi),
  maplist(test_cmp, Totient, Phi, Diffs),
  foldl(sum, Diffs, 0, Sum),
  Sum =:= 0.
test_cmp(T, P, D) :- D is T - P.
sum(X,Y,Z) :- Z is X+Y.


