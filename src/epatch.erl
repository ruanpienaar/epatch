-module(epatch).
-export([main/1]).

main([NodeStr, CookieStr, SourceModuleAbsPath]) ->
    io:format("Epatcher\n", []),
    case string:take(SourceModuleAbsPath, "/", true, trailing) of
        {[], BeamFilename} ->
            usage();
        {Path, BeamFilename} ->
            {BeamStr, _} = string:take(BeamFilename, ".", true, leading),
            Beam = list_to_atom(BeamStr),
            io:format("Going to add path ~p\n", [Path]),
            true = code:add_patha(Path),
            case c:l(Beam) of
                {error, R} ->
                    {error, R};
                {module, testme} ->
                    c:m(Beam),
                    Node = list_to_atom(NodeStr),
                    Cookie = list_to_atom(CookieStr),
                    io:format("Remote node ~p~n", [Node]),
                    ok = spike:connect_and_do(Node, Cookie, inject, [epatch_remote]),
                    io:format("epatch node ~p\n", [node()]),
                    ok = rpc:call(Node, epatch_remote, backup_mod, [Beam]),
                    ok = spike:inject(Node, Beam),
                    done = spike:do_purge(Node, [epatch_remote])
            end
    end;
main(_) ->
    usage().

usage() ->
    io:format("Usage:\n", []),
    io:format(" Use the absolute path of the beam to be patched. /some/path/file.beam\n"),
    io:format(" epatch node@host cookie /tmp/some_module.beam\n", []).