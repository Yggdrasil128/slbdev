:- module(biplStore, []).

store([]).
store([(N, V)|Sto]) :- atom(N), value(V), store(Sto).

