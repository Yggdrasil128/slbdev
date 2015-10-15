% [], numbers, etc. as applied terms
appliedTerm(Term) :-
  atomic(Term).

% Compound terms including cons lists and pairs
appliedTerm(Term) :-
  Term =.. [Symbol|Terms],
  atom(Symbol),
  map(appliedTerm, Terms).
