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

=head1 base64 library

=head2 Synopsis

    % prove lib/base64.t

=head2 Description

Tests base64

=cut

]]

require 'Test.More'

plan(4)

if not require_ok 'base64' then
    skip_rest "no lib"
    os.exit()
end

is( base64.version, "base64 library for Lua on Parrot", "version")

s = "Lua-scripting-language"
x = base64.encode(s)
is( x, "THVhLXNjcmlwdGluZy1sYW5ndWFnZQ==", "encode" )

is( base64.decode(x), s, "decode" )

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
