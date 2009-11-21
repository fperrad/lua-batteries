#! /usr/bin/lua
-- Copyright (C) 2009, Parrot Fondation.

--[[

=head1 complex library

=head2 Synopsis

    % prove t/complex.t

=head2 Description

Tests complex

=cut

]]

require 'Test.More'

plan(37)

if not require_ok 'complex' then
    skip_rest "no lib"
    os.exit()
end

is( complex.version, "complex library for Lua on Parrot", "version" )

is( tostring(complex.I), '0+1i', "complex.I" )

is( tostring(complex.new()), '0+0i', "complex.new" )
is( tostring(complex.new(2)), '2+0i' )
is( tostring(complex.new(3, 4)), '3+4i' )

z = complex.new(3, 4)
is( z:real(), 3, "complex:real & imag" )
is( z:imag(), 4)

is( complex.real(2), 2, "complex cast" )
is( complex.real('2'), 2 )

error_like(function () complex.real({}) end,
           "bad argument #1 to 'real' %(complex number expected, got table%)",
           "complex bad cast")

error_like(function () complex.real('str') end,
           "bad argument #1 to 'real' %(number expected, got string%)",
           "complex bad cast")

z = complex.new(3, 4)
ok( z == z , "complex __eq (same)" )

ok( z == complex.new(3, 4), "complex __eq" )

is( -z, complex.new(-3, -4), "complex __unm" )

is( z + 1, complex.new(4, 4), "complex __add" )

is( z - complex.I, complex.new(3, 3), "complex __sub" )

is( z * 2, complex.new(6, 8), "complex __mul" )

is( z / 2, complex.new(1.5, 2), "complex __div" )

is( z:abs(), 5, "function abs" )

is( tostring(z:acos()), '0.936812-2.30551i', "function acos" )

is( tostring(z:acosh()), '2.30551+0.936812i', "function acosh" )

is( tostring(z:asin()), '0.633984+2.30551i', "function asin" )

is( tostring(z:asinh()), '2.29991+0.917617i', "function asinh" )

is( tostring(z:atan()), '1.44831+0.158997i', "function atan" )

is( tostring(z:atanh()), '0.117501+1.40992i', "function atanh" )

is( tostring(z:conj()), '3-4i', "function conj" )

is( tostring(z:cos()), '-27.0349-3.85115i', "function cos" )

is( tostring(z:cosh()), '-6.58066-7.58155i', "function cosh" )

is( tostring(z:exp()), '-13.1288-15.2008i', "function exp" )

is( tostring(z:log()), '1.60944+0.927295i', "function log" )

w = complex.new(2, 1)
is( tostring(z:pow(w)), '-9.38086-3.1341i', "function pow" )

is( tostring(z:sin()), '3.85374-27.0168i', "function sin" )

is( tostring(z:sinh()), '-6.54812-7.61923i', "function sinh" )

is( tostring(z:sqrt()), '2+1i', "function sqrt" )

is( tostring(z:tan()), '-0.000187346+0.999356i', "function tan" )

is( tostring(z:tanh()), '1.00071+0.00490826i', "function tanh" )

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
