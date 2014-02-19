%%%-------------------------------------------------------------------
%%% @author PHP
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. Февр. 2014 20:51
%%%-------------------------------------------------------------------
-module(pb).
-author("PHP").

%% API
-export([last/1, last2/1, element_at/2, len/1, reverse/1, is_palindrome/1, flatten/1, compress/1, pack/1,
  encode/1, encode_modified/1, decode_modified/1, decode/1, duplicate/1, replicate/2]).


last([]) -> "list is empty";
last([H | []]) -> [H];
last([_ | T]) -> last(T).

last2([]) -> "list is empty";
last2([H | [H2 | []]]) -> [H, H2];
last2([_ | T]) -> last2(T).

element_at([], _) -> "Element index is greater then list size";
element_at([H | _], 1) -> H;
element_at([_ | T], N) when N > 0 -> element_at(T, N - 1);
element_at([_ | _], _) -> "N must be greater 0".

len(List) -> len(List, 0).
len([], Length) -> Length;
len([_ | T], Length) -> len(T, Length + 1).

reverse(List) -> reverse(List, []).
reverse([], Acc) -> Acc;
reverse([H | T], Acc) -> reverse(T, [H | Acc]).

is_palindrome(List) -> is_palindrome(List, reverse(List)).
is_palindrome([], []) -> true;
is_palindrome([H | T1], [H | T2]) -> is_palindrome(T1, T2);
is_palindrome(_, _) -> false.

flatten(X) -> reverse(flatten(X, [])).
flatten([], Acc) -> Acc;
flatten([H | T], Acc) when is_list(H) -> flatten(T, flatten(H, Acc));
flatten([H | T], Acc) -> flatten(T, [H | Acc]).

compress(List) -> compress(reverse(List), []).
compress([], Acc) -> Acc;
compress([H | [H | T2]], Acc) -> compress([H | T2], Acc);
compress([H | T], Acc) -> compress(T, [H | Acc]).

pack(List) -> pack(reverse(List), [], []).
pack([], Acc, Pack) -> [Pack | Acc];
pack([H | T], Acc, []) -> pack(T, Acc, [H]);
pack([H | T], Acc, [H | _] = Pack) -> pack(T, Acc, [H | Pack]);
pack([H | T], Acc, Pack) -> pack(T, [Pack | Acc], [H]).

encode(List) -> encode(List, [], {}).
encode([H | T], Acc, {}) -> encode(T, Acc, {1, H});
encode([], Acc, Pack) -> reverse([Pack | Acc]);
encode([H | T], Acc, {N, H}) -> encode(T, Acc, {N + 1, H});
encode([H | T], Acc, Pack) -> encode(T, [Pack | Acc], {1, H}).

encode_modified(List) -> encode_modified(List, [], {}).
encode_modified([H | T], Acc, {}) -> encode_modified(T, Acc, {1, H});
encode_modified([], Acc, Pack) -> reverse([Pack | Acc]);
encode_modified([H | T], Acc, {N, H}) -> encode_modified(T, Acc, {N + 1, H});
encode_modified([H | T], Acc, {N, X}) when N == 1 -> encode_modified(T, [X | Acc], {1, H});
encode_modified([H | T], Acc, Pack) -> encode_modified(T, [Pack | Acc], {1, H}).

decode_modified(List) -> decode_modified(reverse(List), []).
decode_modified([], Acc) -> Acc;
decode_modified([{N, X} | T], Acc) -> decode_modified(T, make_list(N, X, []) ++ Acc);
decode_modified([H | T], Acc) -> decode_modified(T, [H | Acc]).

make_list(0, _, Acc) -> Acc;
make_list(N, X, Acc) when N > 0 -> make_list(N - 1, X, [X | Acc]).

decode(List) -> decode(reverse(List), []).
decode([], Acc) -> Acc;
decode([{N, X} | T], Acc) -> decode(T, make_list(N, X, []) ++ Acc).

duplicate(List) -> duplicate(reverse(List), []).
duplicate([], Acc) -> Acc;
duplicate([H | T], Acc) -> duplicate(T, [H | [H | Acc]]).

replicate(List, N) -> replicate(reverse(List), N, []).
replicate([], _, Acc) -> Acc;
replicate([H | T], N, Acc) -> replicate(T, N, make_list(N, H, []) ++ Acc).