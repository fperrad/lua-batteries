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

=head1 Markdown library

=head2 Synopsis

    % prove t/markdown.t

=head2 Description

Tests Markdown

=cut

]]

require 'Test.More'

plan(2)

if not require_ok 'markdown' then
    skip_rest "no lib"
    os.exit()
end

html = markdown.markdown [=[
# Title

Some text.

]=]

is( html, "<h1>Title</h1>\n\n<p>Some text.</p>\n", "markdown" )


-- Local Variables:
--   mode: lua
--   lua-indent-level: 4
--   fill-column: 100
-- End:
-- vim: ft=lua expandtab shiftwidth=4:
