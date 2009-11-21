#! /usr/bin/lua
-- Copyright (C) 2009, Parrot Fondation.

--[[

=head1 md5 library

=head2 Synopsis

    % prove t/md5.t

=head2 Description

Tests md5

=cut

]]

require 'Test.More'

plan(21)

if not require_ok 'md5' then
    skip_rest "no lib"
    os.exit()
end

is( md5.version, "md5 library for Lua on Parrot", "md5.version" )

d = md5.new()
type_ok( d, 'userdata', "md5.new()" )

like( tostring(d), '^md5 context %x+$', "md5.__tostring" )

s = d:tostring()
type_ok( s, 'string', "md5:tostring()" )
like( s, '^md5 context %x+$' )

s = 'message digest'
known = 'f96b697d7cb7938d525a2f31aaf161d0'
is( md5.digest(s), known, "md5.digest(s [, raw])")
is( md5.digest(s, false), known)
md = md5.digest(s, true)
type_ok( md, 'string', "raw digest is a string")
is( md:len(), 16, "length of raw digest")

d = md5.new()
d:update('message')
d:update(' ')
d:update('digest')
is( d:digest(), known, "md5:digest()")

d = md5.new()
d:update('message')
d:update(' ')
d:update('digest')
is( d:digest(false), known, "md5:digest(false)" )

d = md5.new()
d:update('message')
d:update(' ')
d:update('digest')
md = d:digest(true)
type_ok( md, 'string', "raw digest is not a string")
is( md:len(), 16, "length of raw digest is not 16")
fmt = string.rep('%2x', 16)
is( string.format(fmt, string.byte(md, 1, 16)), known, "md5:digest(true)" )

s = 'message digest'
d = md5.new()
d:update(s)
ok( d:digest() == known, "md5:reset()" )
ok( d:digest() ~= known )
d:reset()
d:update(s)
ok( d:digest() == known )

s = 'message digest'
d = md5.new()
d:update(s)
d2 = d:clone()
ok( d:digest() == known, "md5:clone()" )
ok( d:digest() ~= known )
ok( d2:digest() == known )

-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
