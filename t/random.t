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

=head1 random library

=head2 Synopsis

    % prove lib/random.t

=head2 Description

Tests random

=cut

]]

require 'Test.More'

plan(15)

if not require_ok 'random' then
    skip_rest "no lib"
    os.exit()
end

is( random.version, "random library for Lua on Parrot", "version" )

r = random.new()
type_ok( r, 'userdata', "random.new()" )

like( tostring(r), '^random handle %x+$', "random.__tostring" )

s = r:tostring()
type_ok( s, 'string', "random:tostring()" )
like( s, '^random handle %x+$' )

r = random.new(1234)
v = r:value()
type_ok( v, 'number', "random:value()" )
like( v, '^0%.1915' )

r = random.new()
output = {}
for i = 1, 4 do
    table.insert(output, r:valuei(11, 16))
end
eq_array( output, {14, 15, 12, 14}, "random:valuei(a, b)" )

r = random.new()
output = {}
for i = 1, 4 do
    table.insert(output, r:valuei(6))
end
eq_array( output, {4, 5, 2, 4}, "random:valuei(a)" )

r = random.new()
v = r:valuex()
type_ok( v, 'number', "random:valuex()" )
like( v, '^0%.643' )

r = random.new(1234)
r1 = {}
r1[1] = r:value()
r1[2] = r:value()
r1[3] = r:value()
r:seed(1234)
r2 = {}
r2[1] = r:value()
ok( r1[1] == r2[1], "random:seed()" )
r:seed()
r3 = {}
r3[1] = r:value()
ok( r1[1] ~= r3[1])

r = random.new(1234)
s = r:clone()
r1 = {}
r1[1] = r:value()
r1[2] = r:value()
r1[3] = r:value()
r2 = {}
r2[1] = s:value()
ok( r1[1] == r2[1], "random:clone()" )

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
