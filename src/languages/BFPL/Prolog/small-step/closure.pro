% Evaluate main expression of program
smallSteps((Fs, E1), E2) :-
  smallSteps(Fs, E1, E2).

% Reflexive case
smallSteps(_, E, E) :-
  normal(E).

% Transitive case
smallSteps(Fs, E1, E3) :-
  smallStep(Fs, E1, E2),
  smallSteps(Fs, E2, E3).
