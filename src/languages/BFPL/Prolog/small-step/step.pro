% Simplify condition
smallStep(P, if(E1a, E2, E3), if(E1b, E2, E3)) :-
  smallStep(P, E1a, E1b).

% Commit to then branch
smallStep(_, if(boolconst(true), E, _), E).

% Commit to else branch
smallStep(_, if(boolconst(false), _, E), E).

% Simplify left operand
smallStep(P, op(O, E1a, E2), op(O, E1b, E2)) :-
  smallStep(P, E1a, E1b).

% Simplify right operand
smallStep(P, op(O, E1, E2a), op(O, E1, E2b)) :-
  normal(E1),
  smallStep(P, E2a, E2b).

% Apply operator
smallStep(_, op(O, E1, E2), E0) :-
  normal(E1),
  normal(E2),
  opConst(O, E1, E2, E0).

% Simplify operand of function application
smallStep(P, apply(F, Es1), apply(F, Es4)) :-
  append(Es2, [E1|Es3], Es1),
  map(normal, Es2),
  smallStep(P, E1, E2),
  append(Es2, [E2|Es3], Es4).

% Apply function
smallStep(P, apply(N, Es), E2) :-
  map(normal, Es),
  member((N, _, (Ns, E1)), P),
  zip(Ns, Es, L),
  star(substitute, L, E1, E2).
