#! /usr/bin/lua
-- Copyright (C) 2009, Parrot Fondation.

--[[

=head1 mathx library

=head2 Synopsis

    % prove t/mathx.t

=head2 Description

Tests mathx
(implemented in F<languages/lua/src/lib/mathx.pir>).

=cut

]]

require 'Test.More'

plan(44)

if not require_ok 'mathx' then
    skip_rest "no lib"
    os.exit()
end

like( math.pi, '3%.14' )

type_ok( math.infinity, 'number', "infinity" )
is( tostring(math.infinity), 'Inf' )

type_ok( math.nan, 'number', "nan" )
is( tostring(math.nan), 'NaN' )

like( math.acosh(2), '^1%.316', "function acosh" )

like( math.asinh(0.5), '^0%.481', "function asinh" )

like( math.atanh(0.5), '^0%.549', "function atanh" )

like( math.cbrt(2), '^1%.259', "function cbrt")

like( math.copysign(3.14, -2), '^%-3%.14', "function copysign" )

like( math.erf(2), '^0%.995', "function erf" )

like( math.erfc(2), '^0%.004', "function erfc" )

like( math.exp2(3), '^8$', "function exp2" )

like( math.expm1(2), '^6%.389', "function expm1" )

like( math.fdim(7, 3), '^4$', "function fdim" )

like( math.fma(2, 3, 4), '^10$', "function fma" )

is( math.fmax(1), 1, "function fmax" )
is( math.fmax(1, 2), 2 )
is( math.fmax(1, 2, 3, -4), 3 )

is( math.fmin(1), 1, "function fmin" )
is( math.fmin(1, 2), 1 )
is( math.fmin(1, 2, 3, -4), -4 )

is( math.fpclassify(1), 'normal', "function fpclassify" )

like( math.gamma(0.5), '^1%.772', "function gamma" )

like( math.hypot(2, 3), '^3%.605', "function hypot" )

like( math.ilogb(47), '^5$', "function ilogb" )

is( math.isfinite(1), true, "function isfinite" )

is( math.isinf(1), false, "function isinf" )

is( math.isnan(1), false, "function isnan" )

is( math.isnormal(1), true, "function isnormal" )

like( math.lgamma(0.5), '^0%.572', "function lgamma" )

like( math.log1p(47), '^3%.871', "function log1p" )

like( math.log2(47), '^5%.554', "function log2" )

like( math.logb(47), '^5$', "function logb" )

like( math.nearbyint(3.14), '^3$', "function nearbyint" )

like( math.nextafter(3.14, 5), '^3%.14$', "function nextafter" )

like( math.nexttoward(3.14, 5), '^3%.14$', "function nexttoward" )

like( math.remainder(4, 3), '^1$', "function remainder" )

like( math.rint(3.14), '^3$', "function rint" )

like( math.round(3.14), '^3$', "function round" )

like( math.scalbn(2, 3), '^16$', "scalbn")

is( math.signbit(3.14), 0, "function signbit" )

like( math.trunc(3.14), '^3$', "function trunc" )

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
