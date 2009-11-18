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

=head1 OpenGL library

=head2 Synopsis

    % prove lib/gl.t

=head2 Description

Tests OpenGL

=cut

]]

require 'Test.More'

plan(5)

if not require_ok 'glut' then
    skip_rest "no lib"
    os.exit()
end

if not require_ok 'gl' then
    skip_rest "no lib"
    os.exit()
end

error_like(function () gl.Begin(nil) end,
           "incorrect argument to function 'gl.Begin'",
           "bad type")

error_like(function () gl.Begin('BAD_VALUE') end,
           "incorrect string argument to function 'gl.Begin'",
           "bad value")

gl.Begin('TRIANGLES')
gl.End()
pass("Begin/End")

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
