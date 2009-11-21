#! /usr/bin/lua
-- Copyright (C) 2009, Parrot Fondation.

--[[

=head1 sha1 library

=head2 Synopsis

    % prove t/sha1.t

=head2 Description

Tests sha1

=cut

]]

require 'Test.More'

plan(4)

if not require_ok 'sha1' then
    skip_rest "no lib"
    os.exit()
end

is( sha1.version, "sha1 library for Lua on Parrot", "version" )

d = sha1.new()
type_ok( d, 'userdata', "sha1.new()" )

like( tostring(d), '^sha1 context %x+$', "sha1.__tostring" )

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
