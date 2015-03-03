opConst(add, intconst(X1), intconst(X2), intconst(X0)) :- X0 is X1 + X2.
opConst(sub, intconst(X1), intconst(X2), intconst(X0)) :- X0 is X1 - X2.
opConst(mul, intconst(X1), intconst(X2), intconst(X0)) :- X0 is X1 * X2.
opConst(eq, intconst(X1), intconst(X2), boolconst(X0)) :-
    X1==X2 -> X0 = true; X0 = false.
