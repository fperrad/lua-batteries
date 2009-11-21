#! /usr/bin/lua
-- Copyright (C) 2009, Parrot Fondation.

--[[

=head1 uuid library

=head2 Synopsis

    % prove t/uuid.t

=head2 Description

Tests uuid

=cut

]]

require 'Test.More'

plan(10)

if not require_ok 'uuid' then
    skip_rest "no lib"
    os.exit()
end

is( uuid.version, "uuid library for Lua on Parrot", "version" )

local patt = '^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$'
local u = '84949cc5-4701-4a84-895b-354c584a981b'

like( tostring(uuid.new()), patt, "uuid.new ()" )

like( tostring(uuid.new('default')), patt, "uuid.new ('default')" )

like( tostring(uuid.new('random')), patt, "uuid.new ('random')" )

like( tostring(uuid.new('time')), patt, "uuid.new ('time')" )

is( uuid.isvalid(''), false, "uuid.isvalid ()" )
is( uuid.isvalid(u), true)

is( uuid.time(u), -1, "uuid.time ()" )

is( uuid.time('12345678-12345-123-1234-123456789012'), nil, "uuid.time (invalid)" )

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
