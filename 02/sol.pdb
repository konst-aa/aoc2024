within(A, B) :-
    D is A - B,
    abs(D) >= 0,
    abs(D) =< 3.

part_1(L, 1) :-
    % are all pairs of consecutive elements decreasing and satisfy
    % the diff requirement?
    forall(append(_, [A, B|_], L), (A < B, within(A, B)));
    % or decreasing
    forall(append(_, [A, B|_], L), (A > B, within(A, B))).

part_1(_, 0).

part_2(L, 1) :-
    % could we partition L into two lists, excluding an item
    append(LH, [_|RH], L),
    % such that when we concat the lists
    append(LH, RH, T),
    % it satisfies the conditions?
    part_1(T, 1),
    % argh, need to cut to prevent multiple successes?
    !.

part_2(_, 0).

main :-
   open('prolog-inp.txt',read,Str),
   read(Str, Lines),
   close(Str),
   findall(O, (member(L, Lines), part_1(L, O)), T1),
   findall(O, (member(L, Lines), part_2(L, O)), T2),
   sum_list(T1, Ans1),
   sum_list(T2, Ans2),
   write(Ans1),
   nl,
   write(Ans2),
   nl.

