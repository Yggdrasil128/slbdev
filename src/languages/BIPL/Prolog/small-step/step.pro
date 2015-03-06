% BEGIN ...
:- module(biplStep, []).
% END ...
% An assignment modifies the store
step((assign(X, E), Sto1), (skip, Sto2)) :-
  biplBigStep:evaluate(E, Sto1, V), 
  modify(X, V, Sto1, Sto2).

% Execute then branch for true condition
step((if(E, S1, _), Sto), (S1, Sto)) :-
  biplBigStep:evaluate(E, Sto, boolval(true)).

% Execute else branch for true condition
step((if(E, _, S2), Sto), (S2, Sto)) :-
  biplBigStep:evaluate(E, Sto, boolval(false)).

% Rephrase while statement to rely on "if"
step((while(E, S), Sto), (if(E, block([S, while(E, S)]), skip), Sto)).

% An empty block equals a skip statement
step((block([]), Sto), (skip, Sto)).

% Shorten block when skip is in front
step((block([skip|Ss]), Sto), (block(Ss), Sto)).

% Make a step for first statement in a sequence
step((block([S1|Ss]), Sto1), (block([S2|Ss]), Sto2)) :-
  step((S1, Sto1), (S2, Sto2)).
