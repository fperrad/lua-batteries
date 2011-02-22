#! /usr/bin/lua
-- Copyright (C) 2009, Parrot Fondation.

--[[

=head1 Lua File System Library

=head2 Synopsis

    % prove t/lfs.t

=head2 Description

Tests Lua File System Library

=cut

--]]

require 'Test.More'

plan(28)

if not require_ok 'lfs' then
    skip_rest "no lib"
    os.exit()
end

is( lfs._VERSION, "LuaFileSystem 1.4.0", "version" )

local cwd = lfs.currentdir()
type_ok( cwd, 'string', "lfs.currentdir" )
diag(cwd)

is( lfs.chdir('t'), true, "lfs.chdir" )
is( lfs.chdir('..'), true )

local r, msg = lfs.chdir("bad_dir")
is( r, nil, "lfs.chdir (bad)" )
is( msg, "Unable to change working directory to 'bad_dir'\nchdir failed: No such file or directory\n" )

lfs.rmdir('xpto')
is( lfs.mkdir('xpto'), true, "lfs.mkdir" )
ok( lfs.chdir('xpto') )
diag( lfs.currentdir() )
ok( lfs.chdir('..') )

is( lfs.mkdir('xpto'), nil, "lfs.mkdir (exists)" )

local str = ''
for file in lfs.dir('xpto') do
    str = str .. file
end
is( str, '...', "lfs.dir" )

error_like(function () lfs.dir('bad_dir') end,
           "No such file or directory",
           "lfs.dir (bad)")

is( lfs.rmdir('xpto'), true, "lfs.rmdir" )
is( lfs.chdir('xpto'), nil )

local r, msg = lfs.rmdir('xpto')
is( r, nil, "lfs.rmdir (not exists)" )
like( msg, "No such file or directory" )

os.remove('file.txt')
f = io.open('file.txt', 'w')
f:write("file with text")
f:close()

local attr = lfs.attributes('file.txt')
type_ok( attr, 'table', "lfs.attributes" )
is( attr.mode, 'file' )
is( attr.size, 14 )

is( lfs.attributes('file.txt', 'mode'), 'file', "lfs.attributes 'mode'" )
is( lfs.attributes('file.txt', 'size'), 14, "lfs.attributes 'size'" )

error_like(function () lfs.attributes('file.txt', 'bad') end,
           "bad argument #2 to 'attributes' %(invalid option 'bad'%)",
           "lfs.attributes (bad)")

local r, msg = lfs.attributes("no_file.txt")
is( r, nil, "lfs.attributes (no file)" )
is( msg, "cannot obtain information from file `no_file.txt'" )

f = io.open("file.txt")
f:close()
error_like(function () lfs.lock(f) end,
           "lock: closed file",
           "lfs.lock (closed)")

is( lfs.symlinkattributes('file.txt', 'mode'), 'file', "lfs.symlinkattributes 'mode'" )
is( lfs.symlinkattributes('file.txt', 'size'), 14, "lfs.symlinkattributes 'size'" )

os.remove('file.txt') -- clean up

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
