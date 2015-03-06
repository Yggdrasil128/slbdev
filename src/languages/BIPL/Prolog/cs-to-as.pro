% Lexical mapping for name
biplMapping(expr, binary(E1, O, E2), binary(O, E1, E2)).

% Lexical mapping for int
biplMapping(int, Digits, Int) :-
  number_codes(Int, Digits).

% Lexical mapping for name
biplMapping(name, (Char, String), Atom) :-
  name(Atom, [Char|String]).

