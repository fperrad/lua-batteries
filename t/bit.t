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

=head1 bitwise operations library

=head2 Synopsis

    % prove t/bit.t

=head2 Description

Tests bit

=cut

]]

require 'Test.More'

plan(9)

if not require_ok 'bit' then
    skip_rest "no lib"
    os.exit()
end

is( bit.tobit(1), 1, "bit.tobit" )

is( bit.band(1), 1, "bit.band" )

is( bit.bxor(1, 2), 3, "bit.bxor" )

is( bit.bor(1,2,4,8,16,32,64,128), 255, "bit.bor" )

is( bit.bswap(0x12345678), 0x78563412, "bit.bswap" )
is( bit.bswap(0x9ABCDEF0), 0xF0DEBC9A)

local r, msg = pcall(dofile, 't/bit/bittest.lua')
ok( r, "bittest" )
if not r then
    diag(msg)
end

local r, msg = pcall(dofile, 't/bit/nsievebits.lua')
ok( r, "nsievebits" )
if not r then
    diag(msg)
end

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
