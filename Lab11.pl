
:- dynamic letters/1.

% Initial set of letters
letters([a,b,c]).

% Display menu
menu :-
    nl,
    write('Hi. This is the "Name Game".'), nl,
    write('You will be given a set of English letters'), nl,
    write('in which you will add, delete or move to create your name.'), nl,
    nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice.... '),
    read(Choice),
    process(Choice).

% Display current letters
process(1) :-
    letters(List),
    write('Current letters: '),
    write(List), nl,
    menu.

% Add a letter at the end
process(2) :-
    write('Enter a letter: '),
    read(Letter),
    retract(letters(List)),
    add_at_end(Letter, List, NewList),
    assertz(letters(NewList)),
    write('Letter added.'), nl,
    menu.

% Add a letter at the top (front)
process(3) :-
    write('Enter a letter: '),
    read(Letter),
    retract(letters(List)),
    NewList = [Letter|List],
    assertz(letters(NewList)),
    write('Letter added at the top.'), nl,
    menu.

% Add a letter at the bottom (end)
process(4) :-
    write('Enter a letter: '),
    read(Letter),
    retract(letters(List)),
    add_at_end(Letter, List, NewList),
    assertz(letters(NewList)),
    write('Letter added at the bottom.'), nl,
    menu.

% Delete the first occurrence of a letter
process(5) :-
    write('Enter the letter to delete: '),
    read(Letter),
    retract(letters(List)),
    remove_first(Letter, List, NewList),
    assertz(letters(NewList)),
    write('Letter deleted if it existed.'), nl,
    menu.

% Delete all letters
process(6) :-
    retract(letters(_)),
    assertz(letters([])),
    write('All letters deleted.'), nl,
    menu.

% Exit
process(7) :-
    write('Goodbye!'), nl.

% Invalid choice
process(_) :-
    write('Invalid choice.'), nl,
    menu.

% Add an element at the end of a list
add_at_end(X, [], [X]).

add_at_end(X, [Head|Tail], [Head|Result]) :-
    add_at_end(X, Tail, Result).

% Remove the first occurrence of an element
remove_first(_, [], []).

remove_first(X, [X|Tail], Tail).

remove_first(X, [Head|Tail], [Head|Result]) :-
    X \= Head,
    remove_first(X, Tail, Result).

% Start the program
start :-
    menu.
