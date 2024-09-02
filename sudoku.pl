:- use_module(library(clpfd)).

% A valid Sudoku board is ...
sudoku(Rows) :-
    % ... a 9x9 grid
    length(Rows, 9),
    maplist(same_length(Rows), Rows),
    % ... with entries from 1 to 9
    append(Rows, Vs),
    Vs ins 1..9,
    % ... with all row and column entries distinct
    maplist(all_distinct, Rows),
    transpose(Rows, Columns),
    maplist(all_distinct, Columns),
    % ... and entries in 3x3 blocks distinct
    Rows = [As, Bs, Cs, Ds, Es, Fs, Gs, Hs, Is],
    blocks(As, Bs, Cs),
    blocks(Ds, Es, Fs),
    blocks(Gs, Hs, Is).

% a helper predicate to impose the block constraint.
blocks([], [], []).
blocks([N1, N2, N3 | Ns1],
       [N4, N5, N6 | Ns2],
       [N7, N8, N9 | Ns3]) :-
    all_distinct([N1, N2, N3, N4, N5, N6, N7, N8, N9]),
    blocks(Ns1, Ns2, Ns3).

% look for an explicit solution
solve(Rows) :-
    sudoku(Rows),
    maplist(label, Rows),
    maplist(portray_clause, Rows).

