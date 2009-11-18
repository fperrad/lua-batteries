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

=head1 bc library

=head2 Synopsis

    % prove lib/bc.t

=head2 Description

Tests bc

=cut

]]

require 'Test.More'

plan(57)

if not require_ok 'bc' then
    skip_rest "no lib"
    os.exit()
end

is( bc.version, "bc library for Lua on Parrot", "version" )

n = bc.number '12'
type_ok( n, 'userdata', "bc.number (string)" )
is(tostring(n), '12' )

n = bc.number(12)
type_ok( n, 'userdata', "bc.number (number)" )
is(tostring(n), '12' )

n = bc.number(12)
n = bc.number(n)
type_ok( n, 'userdata', "bc.number (bc)" )
is(tostring(n), '12' )

n = bc.number '12'
is( bc.tostring(n), '12', "bc.tostring ()")

bc.digits(10)
is( bc.digits(), 10, "bc.digits ()")

a = bc.number(12)
n = - a
type_ok( n, 'userdata', "bc.__unm" )
is(tostring(n), '-12' )

n = bc.add(12, 34)
type_ok( n, 'userdata', "bc.add ()" )
is(tostring(n), '46' )

a = bc.number(12)
n = a + 34
type_ok( n, 'userdata', "bc.__add" )
is(tostring(n), '46' )

n = bc.sub(12, 34)
type_ok( n, 'userdata', "bc.sub ()" )
is(tostring(n), '-22' )

a = bc.number(12)
n = a - 34
type_ok( n, 'userdata', "bc.__sub" )
is(tostring(n), '-22' )

n = bc.mul(2, 3)
type_ok( n, 'userdata', "bc.mul ()" )
is(tostring(n), '6' )

a = bc.number(2)
n = a * 3
type_ok( n, 'userdata', "bc.__mul" )
is(tostring(n), '6' )

n = bc.div(12, 3)
type_ok( n, 'userdata', "bc.div ()" )
is(tostring(n), '4' )

n = bc.div(12, 0)
is( n, nil, "bc.div (by zero)")

a = bc.number(12)
n = a / 3
type_ok( n, 'userdata', "bc.__div" )
is(tostring(n), '4' )

n = bc.mod(13, 3)
type_ok( n, 'userdata', "bc.mod ()" )
is(tostring(n), '1' )

n = bc.mod(13, 0)
is( n, nil, "bc.mod (by zero)")

a = bc.number(13)
n = a % 3
type_ok( n, 'userdata', "bc.__mod" )
is(tostring(n), '1' )

n = bc.pow(2, 3)
type_ok( n, 'userdata', "bc.pow ()" )
is(tostring(n), '8' )

a = bc.number(2)
n = a ^ 3
type_ok( n, 'userdata', "bc.__pow" )
is(tostring(n), '8' )

todo( "sqrt not implemented with BigNum", 2 )
n = bc.sqrt(4)
type_ok( n, 'userdata', "bc.sqrt ()" )
is(tostring(n), '2' )

n = bc.sqrt(-4)
is( n, nil, "bc.sqrt (negative)" )

is( bc.isneg(12), false, "bc.isneg ()")
is( bc.isneg(-34), true )
is( bc.isneg "0", false )
todo( "isneg '-0'" )
is( bc.isneg "-0", true )

is( bc.iszero(12), false, "bc.iszero ()" )
is( bc.iszero(-34), false )
is( bc.iszero "0", true )
is( bc.iszero "-0", true )

is( bc.compare(12, 34), -1, "bc.compare ()" )
is( bc.compare(12, 12), 0)
is( bc.compare(34, 12), 1)

a = bc.number(12)
is( a == bc.number(10), false, "bc.__eq" )
is( a == bc.number(12), true )

a = bc.number(12)
is( a < bc.number(10), false, "bc.__lt" )
is( a < bc.number(12), false )
is( a < bc.number(14), true )

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
