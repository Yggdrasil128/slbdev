% Evaluate main expression of program
bigStep((Fs, E), V) :-
  bigStep(Fs, [], E, V).

% A constant bigSteps to itself
bigStep(_, _, intconst(I), intval(I)).

% A variable bigSteps to its binding
bigStep(_, X, name(N), V) :-
  member((N, V), X).

% True condition
bigStep(P, X, if(E1, E2, _), V) :-
  bigStep(P, X, E1, boolval(true)),
  bigStep(P, X, E2, V).

% False condition
bigStep(P, X, if(E1, _, E2), V) :-
  bigStep(P, X, E1, boolval(false)),
  bigStep(P, X, E2, V).
 
% BigStep operator application
bigStep(P, X, op(O, E1, E2), V0) :-
  bigStep(P, X, E1, V1),
  bigStep(P, X, E2, V2),
  opVal(O, V1, V2, V0).

% BigStep function application
bigStep(P, X1, apply(N, Es), V) :-
  map(bigStep(P, X1), Es, Vs),
  member((N, _, (Ns, E)), P),
  zip(Ns, Vs, X2),
  bigStep(P, X2, E, V).
