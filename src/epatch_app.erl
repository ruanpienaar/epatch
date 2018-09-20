-module(epatch_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-include("epatch.hrl").

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    epatch_sup:start_link().

stop(_State) ->
    ok.
