-module(epatch_remote).
-export([
    beam_location/1,
    patch/1,
    backup_mod/1
]).

patch(Beam) ->
    %% TODO: maybe check remote vsn, erlang vsn, compile macros ...
    %%       check if the new and old compiled beams share the same options ...
    ok = backup_mod(Beam),
    ok.

beam_location(Beam) ->
    [LoadedBeamFilePath] = [ BeamLocation || {B, BeamLocation} <- code:all_loaded(), Beam == B ],
    LoadedBeamFilePath.

backup_mod(Beam) ->
    io:format("Going to backup mod ~p\n", [Beam]),
    [LoadedBeamFilePath] = [ BeamLocation || {B, BeamLocation} <- code:all_loaded(), Beam == B ],
    {Path, BeamFileName} = string:take(LoadedBeamFilePath, "/", true, trailing),
    NowSeconds = calendar:datetime_to_gregorian_seconds(calendar:now_to_datetime(os:timestamp())),
    BackupPatchDir = Path ++ "patch_backup_" ++ BeamFileName ++ "_" ++ integer_to_list(NowSeconds),
    ok = file:make_dir(BackupPatchDir),
    BackupBeamLocation = BackupPatchDir++"/"++BeamFileName,
    {ok, _} = file:copy(LoadedBeamFilePath, BackupBeamLocation),
    io:format("Backup created in ~p\n", [BackupBeamLocation]).