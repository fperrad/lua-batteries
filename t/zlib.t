#! /usr/bin/lua
--
-- lua-TestMore : <http://testmore.luaforge.net/>
--
-- Copyright (C) 2009, Perrad Francois
--
-- This code is licensed under the terms of the MIT/X11 license,
-- like Lua itself.
--

--[[

=head1 LuaZlib

=head2 Synopsis

    % prove lib/zlib.t

=head2 Description

Tests LuaZlib

=cut

]]

require 'Test.More'

plan(2)

if not require_ok 'zlib' then
    skip_rest "no lib"
    os.exit()
end

is( zlib._VERSION, "LuaZlib 1.0.0", "_VERSION" )

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
