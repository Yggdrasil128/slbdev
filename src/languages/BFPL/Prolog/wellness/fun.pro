% Wellness of function declarations
okFun(P, (_, (Ts, T), (Ns, E))) :-
  set(Ns),
  zip(Ns, Ts, X),
  okExpr(P, X, E, T).
