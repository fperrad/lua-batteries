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

=head1 LPeg library

=head2 Synopsis

    % prove lib/lpeg.t

=head2 Description

Tests LPeg

=cut

]]

require 'Test.More'

plan(15)

if not require_ok 'lpeg' then
    skip_rest "no lib"
    os.exit()
end

is( lpeg.version(), '0.9', "version")

local a = lpeg.P"str"
is( lpeg.type(a), 'pattern', "lpeg.P'str'" )

local a = lpeg.P(0)
is( lpeg.type(a), 'pattern', "lpeg.P(0)" )

local a = lpeg.P(2)
is( lpeg.type(a), 'pattern', "lpeg.P(2)" )

local a = lpeg.P(-2)
is( lpeg.type(a), 'pattern', "lpeg.P(-2)" )

local a = lpeg.P(-300)
is( lpeg.type(a), 'pattern', "lpeg.P(-300)" )

local a = lpeg.P(true)
is( lpeg.type(a), 'pattern', "lpeg.P(true)" )

local a = lpeg.P(false)
is( lpeg.type(a), 'pattern', "lpeg.P(false)" )

local a = lpeg.P'A'
local b = lpeg.P(a)
is( lpeg.type(b), 'pattern', "lpeg.P(patt)" )

error_like(function () local a = lpeg.P(nil) end,
           "bad argument #1 to 'P' %(pattern expected, got nil%)",
           "lpeg.P(nil)")

local a = lpeg.S'A'
is( lpeg.type(a), 'pattern', "lpeg.S'A'" )

local a = lpeg.V'A'
is( lpeg.type(a), 'pattern', "lpeg.V'A'" )

error_like(function () local a = lpeg.V() end,
           "bad argument #1 to 'V' %(non%-nil value expected%)",
           "lpeg.V()")

error_like(function () local a = lpeg.V(nil) end,
           "bad argument #1 to 'V' %(non%-nil value expected%)",
           "lpeg.V(nil)")

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
