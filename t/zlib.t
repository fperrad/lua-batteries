#! /usr/bin/lua
-- Copyright (C) 2009-2010, Parrot Fondation.

--[[

=head1 LuaZlib

=head2 Synopsis

    % prove t/zlib.t

=head2 Description

Tests LuaZlib

=cut

]]

require 'Test.More'

plan(4)

if not require_ok 'zlib' then
    skip_rest "no lib"
    os.exit()
end

is( zlib._VERSION, "LuaZlib 1.0.0", "_VERSION" )

local data = "message"

local compressed = zlib.compress(data)
type_ok( compressed, "string", "compress" )

is( zlib.uncompress(compressed), data, "uncompress" )

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
