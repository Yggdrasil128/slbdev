% Lexical mapping for name
biplMapping(expression, binop(E1, O, E2), binop(O, E1, E2)).

% Lexical mapping for int
biplMapping(int, Digits, Int) :-
  number_codes(Int, Digits).

% Lexical mapping for name
biplMapping(name, (Char, String), Atom) :-
  name(Atom, [Char|String]).

