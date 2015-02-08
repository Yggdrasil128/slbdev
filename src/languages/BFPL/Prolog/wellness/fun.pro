% Wellness of function declarations
okFun(P, (N, (Ts, T), (Ns, E))) :-
  set(Ns),
  zip(Ns, Ts, X),
  okExpr(P, X, E, T).
