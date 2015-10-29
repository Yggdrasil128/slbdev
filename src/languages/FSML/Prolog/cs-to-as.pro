% Lexical mapping for name
fsmlMapping(name, String, Atom) :-
  name(Atom, String).

% Mapping for states
fsmlMapping(state, (I1, N, Ts1), (I2, N, Ts2)) :-
  toBoolean(\+ I1==[], I2), % initial or not
  map(normalizeTargetState(N), Ts1, Ts2).

% Make target state mandatory
normalizeTargetState(_, (I, A, [S]), (I, A, S)).

% Make implicit target state explicit
normalizeTargetState(N, (I, A, []), (I, A, N)).
