#! /usr/bin/lua
-- Copyright (C) 2009, Parrot Fondation.

--[[

=head1 Lua Alarm Library

=head2 Synopsis

    % prove t/alarm.t

=head2 Description

Tests Lua Alarm Library

=cut

]]

require 'Test.More'

plan(7)

if not require_ok 'alarm' then
    skip_rest "no lib"
    os.exit()
end

type_ok( alarm, 'function' )

error_like(function () alarm('bad') end,
           "bad argument #1 to 'alarm' %(number expected, got string%)",
           "function alarm (bad delay)")

error_like(function () alarm(1) end,
           "no alarm handler set",
           "function alarm (no handler)")

error_like(function () alarm(1, {}) end,
           "bad argument #2 to 'alarm' %(function expected, got table%)",
           "function alarm (bad handler)")

local function delay (d)
    local s = os.time()
    local e = s
    while (os.difftime(e, s) < d) do
        e = os.time()
    end
end

function myalarm ()
    print "# in alarm!"
end

print("# hello")
type_ok( alarm(2, myalarm), 'number', "alarm" )
type_ok( alarm(2), 'number' )
delay(3)

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
