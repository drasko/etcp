-module(etcp).
-behaviour(gen_server).

-export([
    start_link/0,
    init/1,
    handle_info/2,
    handle_call/3,
    handle_cast/2
]).

-record(state, {socket}).

start_link() ->
    Port = os:getenv("ETCP_SERVER_PORT", "7000"),
    io:format("Genserver started"),
    {Port2, _} = string:to_integer(Port),
    gen_server:start_link(?MODULE, [Port2], []).
    

init([Port]) ->
	{ok, LSocket} = gen_tcp:listen(Port, [{active, true}]),
	{ok, Socket} = gen_tcp:accept(LSocket),
	{ok, #state{socket = Socket}}.

handle_info({tcp, _Socket, _Packet}, State) ->
    io:format("Received activity~n"),
    {noreply, State};
handle_info({tcp_closed, _Socket}, State) ->
    {noreply, State};
handle_info({tcp_error, _Socket, _Reason}, State) ->
    {noreply, State};
handle_info(Message, State) ->
    io:format("unexpected: ~p~n", [Message]),
    {noreply, State}.

% Currently unused, but kept to avoid compiler warnings (it expects handle_call/3 in the gen_server)
handle_call(Name, _From, State) ->
    Reply = lists:flatten(io_lib:format("Hello ~s from genserver handle_call", [Name])),
    {reply, Reply, State}.


handle_cast(Message, State) ->
    io:format("Unexpected cast: ~p~n", [Message]),
    {noreply, State}.

