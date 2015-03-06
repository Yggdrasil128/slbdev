% BEGIN ...
:- module(biplBigStep, []).
% END ...
% Begin with an empty store if no store is provided
execute(S, Sto) :- execute(S, [], Sto).

% A skip statement completes trivially
execute(skip, Sto, Sto). 

% An assignment modifies the store
execute(assign(X, E), Sto1, Sto2) :-
  evaluate(E, Sto1, V), 
  modify(X, V, Sto1, Sto2).

% Execute then branch for true condition
execute(if(E, S1, _), Sto1, Sto2) :-
  evaluate(E, Sto1, boolval(true)), 
  execute(S1, Sto1, Sto2).

% Execute else branch for true condition
execute(if(E, _, S2), Sto1, Sto2) :-
  evaluate(E, Sto1, boolval(false)), 
  execute(S2, Sto1, Sto2).

% Rephrase while statement to rely on "if"
execute(while(E, S), Sto1, Sto2) :-
  execute(if(E, block([S, while(E, S)]), skip), Sto1, Sto2).

% An empty block equals a skip statement
execute(block([]), Sto, Sto).

% Execute statements of a block sequentially
execute(block([S|Ss]), Sto1, Sto3) :-
  execute(S, Sto1, Sto2),				
  execute(block(Ss), Sto2, Sto3).

% A constant evaluates to itself
evaluate(intconst(I), _, intval(I)).

% Look-up variable from store
evaluate(var(N), Sto, V) :- member((N, V), Sto).

% Evaluate operator application
evaluate(binary(O, E1, E2), Sto, V0) :-
  evaluate(E1, Sto, V1),
  evaluate(E2, Sto, V2),
  opVal(O, V1, V2, V0).
