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

    % prove t/bitlib.t

=head2 Description

Tests bitlib

=cut

]]

require 'Test.More'

local longsize = (platform and platform.longsize) or 4
local bit_bits = longsize * 8 - 1
if bit_bits == 63 then
    bit_bits = 53
end

plan(17 + 18 * bit_bits)

if not require_ok 'bitlib' then
    skip_rest "no lib"
    os.exit()
end

type_ok( bit.bits, 'number', "bit.bits" )
is( bit.bits, bit_bits )

is( bit.bnot(0), bit.cast(-1), "bit.bnot" )
is( bit.bnot(-1), bit.cast(0) )
for nb = 1, bit.bits do
    local a = 2 ^ nb - 1
    -- print("nb = " .. nb .. ", a = " .. a)
    is( bit.bnot(a), bit.cast(-1 - a) )
end

is( bit.band(0, 0), bit.cast(0), "bit.band" )
is( bit.band(0, -1), bit.cast(0) )
is( bit.band(-1, -1), bit.cast(-1) )
for nb = 1, bit.bits do
    local a = 2 ^ nb - 1
    -- print("nb = " .. nb .. ", a = " .. a)
    is( bit.band(a, 0), bit.cast(0) )
    is( bit.band(a, 1), bit.cast(1) )
    is( bit.band(a, -1), bit.cast(a) )
    is( bit.band(a, a), bit.cast(a) )
end

is( bit.bor(0, 0), bit.cast(0), "bit.bor" )
is( bit.bor(0, -1), bit.cast(-1) )
is( bit.bor(-1, -1), bit.cast(-1) )
for nb = 1, bit.bits do
    local a = 2 ^ nb - 1
    -- print("nb = " .. nb .. ", a = " .. a)
    is( bit.bor(a, 0), bit.cast(a) )
    is( bit.bor(a, 1), bit.cast(a) )
    is( bit.bor(a, -1), bit.cast(-1) )
    is( bit.bor(a, a), bit.cast(a) )
end

is( bit.bxor(0, 0), bit.cast(0), "bit.bxor" )
is( bit.bxor(0, -1), bit.cast(-1) )
is( bit.bxor(-1, -1), bit.cast(0) )
for nb = 1, bit.bits do
    local a = 2 ^ nb - 1
    -- print("nb = " .. nb .. ", a = " .. a)
    is( bit.bxor(a, 0), bit.cast(a) )
    is( bit.bxor(a, 1), bit.cast(a - 1) )
    is( bit.bxor(a, -1), bit.cast(-a - 1) )
    is( bit.bxor(a, a), bit.cast(0) )
end

is( bit.lshift(0, 0), bit.cast(0), "bit.lshift" )
is( bit.lshift(-1, 0), bit.cast(-1) )
for nb = 1, bit.bits - 1 do
    local a = 2 ^ nb - 1
    -- print("nb = " .. nb .. ", a = " .. a)
    is( bit.lshift(a, 1), bit.cast(a + a) )
    is( bit.lshift(1, nb), bit.cast(2 ^ nb) )
end

is( bit.rshift(0, 0), bit.cast(0), "bit.rshift" )
is( bit.rshift(-1, 0), bit.cast(-1) )
for nb = 1, bit.bits do
    local a = 2 ^ nb - 1
    -- print("nb = " .. nb .. ", a = " .. a)
    is( bit.rshift(a, 1), math.floor(a / 2) )
    is( bit.rshift(a, nb), bit.cast(0) )
    is( bit.rshift(a, nb - 1), bit.cast(1) )
end

is( bit.arshift(-1, 1), bit.cast(-1), "bit.arshift" )

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
