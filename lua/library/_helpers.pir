# Copyright (C) 2008-2009, Parrot Foundation.
# $Id$

=head1 helpers library

=head2 Description

=head3 Functions

=over 4

=cut

.HLL 'lua'
.loadlib 'lua_group'
.namespace []

.sub '__onload' :anon :load
#    print "__onload _helpers\n"
    .const 'Sub' entry = 'luaopen__helpers'
    set_hll_global 'luaopen__helpers', entry
.end

.sub 'luaopen__helpers'

#    print "luaopen__helpers\n"

    .local pmc _lua__GLOBAL
    _lua__GLOBAL = get_hll_global '_G'

    new $P1, 'LuaString'

    .local pmc __helpers
    new __helpers, 'LuaTable'
    set $P1, '_helpers'
    _lua__GLOBAL[$P1] = __helpers

    $P2 = split "\n", <<'LIST'
lua_isboolean
lua_isfunction
lua_isnil
lua_isnumber
lua_isstring
lua_istable
lua_isuserdata
LIST
    lua_register($P1, __helpers, $P2)

    .return (__helpers)
.end


=back

=cut


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
