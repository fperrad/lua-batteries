#! /usr/bin/lua
-- Copyright (C) 2009, Parrot Fondation.

--[[

=head1 struct library

=head2 Synopsis

    % prove t/struct.t

=head2 Description

Tests struct

=cut

]]

require 'Test.More'

plan(3)

if not require_ok 'struct' then
    skip_rest "no lib"
    os.exit()
end

is( struct.size('i'), (platform and platform.longsize) or 4, "struct.size 'i'" )

error_like(function () struct.size('s') end,
           "options `c0' %- `s' have undefined sizes",
           "struct.size 's'")

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
