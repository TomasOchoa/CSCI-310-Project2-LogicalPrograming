% CSCI 310 Organization of Programming Languages, Spring 2015
% Program #2: Logical Programming
% Author: Tomas Ochoa
% Date Due: 30 March 2015

% The point of this program is to familiarize ourselves
% with logical programing and how it functions and works
%---------------------------------------------------------------------------------------------------
% NAME: "hlbackwards"

% This part of the program is to warm up and take a list as input.
% The list is then reversed (sub lists are not reversed just the
% the general list)

hlbackwards([],[]).                        % The reverse of an empty list is the empty list
hlbackwards([X],X).
hlbackwards([X|Y],Z):-
     hlbackwards(Y,W),
         append(W,[X],Z).
%---------------------------------------------------------------------------------------------------
% NAME: "llbackwards"

% This function takes a list as input and reverses the list
% including sublists
%
llbackwards(X,Y):-
    llbackwards(X,[],Y).

llbackwards([],L,L).
llbackwards([X|Y],Z,L):-
    is_list(X) ,!,
    llbackwards(X,[],T),
    llbackwards(Y,[T|Z],L).

llbackwards([X|Y],Z,L):-
    llbackwards(Y,[X|Z],L).


% Check to see if list
%
is_list(X):-
    var(X),!,
    fail.
is_list([]).
is_list([_|_]).

%---------------------------------------------------------------------------------------------------
% NAME: palindrome

% This function takes a list as input and returns the original list if the list is a palindrome
% and otherwise returns the original list made into a palindrome by reversing it and appending
% it to itself, but not replicating the last element.

palindrome([],[]).
palindrome([X],[X]).
palindrome(L,L):-
    llbackwards(L,L).

palindrome(X,L):-
    llbackwards(X,[_|T]),
    append(X,T,L).
%---------------------------------------------------------------------------------------------------
% NAME: permutations

% This function takes a list as input and generates a list containing all possible permutations
% of the list elements.

car([_|X],[X]).
cdr([X|_],[X]).

%%  Main function

permutations([],[]).
permutations(List,[H|Perm]):-
    delete(H,List,Rest),
    permutations(Rest,Perm).
delete(X,[X|T],T).
delete(X,[H|T],[H|NT])
    :-delete(X,T,NT).

%---------------------------------------------------------------------------------------------------
% NAME: ionah

% This function takes a single number as input and prints ot the solution to the inverted disk
% problem for that many disks.
%
doIonah(1,Beg,_,End) :-
    write('Move disk from peg '),
    write(Beg),
    write(' to '),
    write(End),
    nl.
doIonah(N,Beg,Mid,End) :-
    N>0,
    M is N-1,
    doIonah(M,Beg,End,Mid),
    doIonah(1,Beg,Mid,End),
    doIonah(M,Mid,Beg,End).

ionah(N):-
 doIonah(N,1,2,3).
%---------------------------------------------------------------------------------------------------
% NAME: sequence

% This function takes a single integer as input and prints out a list containing that many
% terms of the sequence defined by the given conditions

% Helper function that defines the sequence
seqDef(1,0).
seqDef(2,1).
seqDef(S,N):-
    S > 2,
    X is S-1,
    Y is S-2,
    seqDef(X,A),
    seqDef(Y,B),
    N is 2*A + B.

% another helper function to get the sequence list
doSequence([],[]).
doSequence(1,0).
doSequence(2,1).
doSequence(N,[H|T]):-
    seqDef(N,T),
    M is N-1,
    doSequence(M,H).

% Main sequence function
sequence(X,Z):-
    doSequence(X,W),
    hlbackwards(W,Z).
%---------------------------------------------------------------------------------------------------
% NAME: argue

% This function takes statements typed into a list and changes pronouns and negates them.
% (A simple AI program)

replace([],_,_,[]).
replace([X|Y],X,A,[A|Z]):-!,
    replace(Y,X,A,Z).

replace([X|Y],A,B,[X|Z]):-!,
    replace(Y,A,B,Z).

words([],[]).
words(X,Y):-
    member('i',X),
    replace(X,'i','you',Y);
    member('am',X),
    replace(X,'am','arent',Y);
    member('are',X),
    replace(X,'are','aint',Y);
    member('is',X),
    replace(X,'is','isnt',Y);
    member('isnt',X),
    replace(X,'isnt','is',Y);
    member('your',X),
    replace(X,'your','my',Y);
    member('my',X),
    replace(X,'my','your',Y);
    member('does',X),
    replace(X,'does','doesnt',Y);
    member('doesnt',X),
    replace(X,'doesnt','does',Y).



%---------------------------------------------------------------------------------------------------
% NAME: bubblesort

% This function takes a list of numbers as input and returns the list sorted in ascending order

% Bubble sort function
bubblesort(L,SortedL):-
    swap(L,L1),!,
    bubblesort(L1,SortedL) .

bubblesort(L,L).
% Helper function to swap the neighboring elements
% depending if one s greater than the other or not

swap([X,Y|Z],[Y,X|Z]):-
    X>Y,!.

swap([X|Y],[X|Z]):-
    swap(Y,Z).
%---------------------------------------------------------------------------------------------------
