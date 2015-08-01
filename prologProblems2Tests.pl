%    ___   ___    _______        _       
%   / _ \ / _ \  |__   __|      | |      
%  | (_) | (_) |    | | ___  ___| |_ ___ 
%   \__, |\__, |    | |/ _ \/ __| __/ __|
%     / /   / /     | |  __/\__ \ |_\__ \
%    /_/   /_/      |_|\___||___/\__|___/

%   ____         _         _ _   _                    _   _
%  |___ \       / \   _ __(_) |_| |__  _ __ ___   ___| |_(_) ___
%    __) |     / _ \ | '__| | __| '_ \| '_ ` _ \ / _ \ __| |/ __|
%   / __/ _   / ___ \| |  | | |_| | | | | | | | |  __/ |_| | (__
%  |_____(_) /_/   \_\_|  |_|\__|_| |_|_| |_| |_|\___|\__|_|\___|


:- consult(helper).
:- consult(prologProblems2).


% 2.01 (**) Determine whether a given integer number is prime.
% is_prime(+Number)/1
:- begin_tests(is_prime).
test(is_prime) :-
  is_prime(7).
:- end_tests(is_prime).


% 2.02 (**) Determine the prime factors of a given positive integer.
% prime_factors(+Number, ?PrimeFactorList)/2
:- begin_tests(prime_factors).
test(prime_factors, [true(L = [3,3,5,7])]) :-
  prime_factors(315, L).
:- end_tests(prime_factors).


% 2.03 (**) Determine the prime factors of a given positive integer (2).
% prime_factors_mult(+Number, ?PrimeFactorListRunLengthEncoded)/2
:- begin_tests(prime_factors_mult).
test(prime_factors_mult, [true(L = [[2,3],[1,5],[1,7]])]) :-
  prime_factors_mult(315, L).
:- end_tests(prime_factors_mult).


% 2.04 (*) A list of prime numbers.
% prime_list(+Lower, +Upper, ?PrimesList)/3
:- begin_tests(prime_list).
test(prime_list) :-
  goldbach(28, L), L = [5,23], !. % 5,23 is among the solutions
:- end_tests(prime_list).


% 2.05 (**) Goldbach's conjecture.
% goldbach(+Number, ?ListWithTwoPrimes)/2
% This is highly nondeterministic, maybe bother about this test later...
%:- begin_tests(goldbach).
%test(goldbach) :-
%  % collect all solutions
%  bagof(N=P1+P2, goldbach_list(9,20,N,P1,P2), Goldbach),
%  forall( % ∀
%    member(Z=X+Y, Goldbach),
%    (
%      R is X+Y, % evaluate and check if formula is true
%      Z =:= R
%    )
%  ).
%:- end_tests(goldbach).


% 2.06 (**) A list of Goldbach compositions.

% a) Given a range of integers by its lower and upper limit, print a list of all even numbers and their Goldbach composition.
% goldbach_list(+Lower, +Upper)/2
% This is highly nondeterministic, maybe bother about this test later...
%:- begin_tests(goldbach_list2).
%test(goldbach_list2) :- .
%:- end_tests(goldbach_list2).

% b) In most cases, if an even number is written as the sum of two prime numbers, one of them is very small. Very rarely, the primes are both bigger than say 50.
% goldbach_list(+Lower, +Upper, +Minimum)/3
% This is highly nondeterministic, maybe bother about this test later...
%:- begin_tests(goldbach_list3).
%test(goldbach_list3) :- .
%:- end_tests(goldbach_list3).


% 2.07 (**) Determine the greatest common divisor of two positive integer numbers.
% gcd(+Number1, +Number2, ?GCD)/3
:- begin_tests(gcd).
test(gcd, [true(G = 9)]) :-
  G is gcd(36,63).
:- end_tests(gcd).


% 2.08 (*) Determine whether two positive integer numbers are coprime.
% Two numbers are coprime if their greatest common divisor equals 1.
% coprime(+Prime1, +Prime2)/2
:- begin_tests(coprime).
test(coprime) :-
  coprime(35, 64).
:- end_tests(coprime).


% 2.09 (**) Calculate Euler's totient function phi(m).
% totient_phi(+Num, ?Phi)/2
:- begin_tests(totient_phi).
test(totient_phi, [true(Phi =:= 4)]) :-
  Phi is totient_phi(10).
:- end_tests(totient_phi).


% 2.10 (**) Calculate Euler's totient function phi(m) (2).
% phi(m) = (p1-1)*p1^(m1-1) * (p2-1)*p2^(m2-1) * (p3-1)*p3^(m3-1) * ...
% where p,m are prime factors and their multiplicities
% phi(+Num, ?Phi)/2
:- begin_tests(phi).
test(phi, [true(Phi =:= 4)]) :-
  Phi is phi(10).
:- end_tests(phi).


% 2.11 (*) Compare the two methods of calculating Euler's totient function.
% test_totient()/0
% test_totient(+Maximum)/1
% test_totient(+Minimum, +Maximum)/2
:- begin_tests(test_totient).
%test(test_totient, [true()]) :-
%  .
% well... the problem itself is a test, so why test it.
:- end_tests(test_totient).


