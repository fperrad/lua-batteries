#!/usr/bin/env parrot
# Copyright (C) 2009-2011, Parrot Foundation.

=head1 NAME

setup.pir - Python distutils style

=head1 DESCRIPTION

No Configure step, no Makefile generated.

=head1 USAGE

    $ parrot setup.pir build
    $ parrot setup.pir test
    $ sudo parrot setup.pir install

=cut

.sub 'main' :main
    .param pmc args
    $S0 = shift args
    load_bytecode 'distutils.pbc'

    .const 'Sub' build = 'build'
    register_step_before('build', build)

    .const 'Sub' clean = 'clean'
    register_step_before('clean', clean)

    $P0 = new 'Hash'
    $P0['name'] = 'Lua-Batteries'
    $P0['abstract'] = 'Libraries for Lua on Parrot'
    $P0['authority'] = 'http://github.com/fperrad'
    $P0['description'] = 'This is the port of many libraries for Lua on Parrot.'
    $P5 = split ',', 'lua'
    $P0['keywords'] = $P5
    $P0['license_type'] = 'Artistic License 2.0'
    $P0['license_uri'] = 'http://www.perlfoundation.org/artistic_license_2_0'
    $P0['copyright_holder'] = 'Parrot Foundation'
    $P0['checkout_uri'] = 'git://github.com/fperrad/lua-batteries.git'
    $P0['browser_uri'] = 'http://github.com/fperrad/lua-batteries'
    $P0['project_uri'] = 'http://github.com/fperrad/lua-batteries'

    # build
    $P1 = new 'Hash'
    $P1['Test/More.pir'] = 'Test/More.lua'
    $P0['pir_lua'] = $P1

    $P2 = new 'Hash'
    $P2['lua/library/_helpers.pbc'] = 'lua/library/_helpers.pir'
    $P2['lua/library/alarm.pbc'] = 'lua/library/alarm.pir'
    $P2['lua/library/base64.pbc'] = 'lua/library/base64.pir'
    $P2['lua/library/bc.pbc'] = 'lua/library/bc.pir'
    $P2['lua/library/bit.pbc'] = 'lua/library/bit.pir'
    $P2['lua/library/bitlib.pbc'] = 'lua/library/bitlib.pir'
    $P2['lua/library/complex.pbc'] = 'lua/library/complex.pir'
    $P2['lua/library/lfs.pbc'] = 'lua/library/lfs.pir'
    $P2['lua/library/lpeg.pbc'] = 'lua/library/lpeg.pir'
    $P2['lua/library/markdown.pbc'] = 'lua/library/markdown.pir'
    $P2['lua/library/mathx.pbc'] = 'lua/library/mathx.pir'
    $P2['lua/library/md5.pbc'] = 'lua/library/md5.pir'
    $P2['lua/library/random.pbc'] = 'lua/library/random.pir'
    $P2['lua/library/sha1.pbc'] = 'lua/library/sha1.pir'
    $P2['lua/library/struct.pbc'] = 'lua/library/struct.pir'
    $P2['lua/library/uuid.pbc'] = 'lua/library/uuid.pir'
    $P2['lua/library/zlib.pbc'] = 'lua/library/zlib.pir'
    $P2['Test/More.pbc'] = 'Test/More.pir'
    $P0['pbc_pir'] = $P2

    # test
    $S0 = get_bindir()
    $S0 .= "/parrot-lua"
    $S1 = get_exe()
    $S0 .= $S1
    $P0['prove_exec'] = $S0

    # install
    $P3 = split "\n", <<'LIBS'
lua/library/_helpers.pbc
lua/library/alarm.pbc
lua/library/base64.pbc
lua/library/bc.pbc
lua/library/bit.pbc
lua/library/bitlib.pbc
lua/library/complex.pbc
lua/library/lfs.pbc
lua/library/lpeg.pbc
lua/library/markdown.pbc
lua/library/mathx.pbc
lua/library/md5.pbc
lua/library/random.pbc
lua/library/sha1.pbc
lua/library/struct.pbc
lua/library/uuid.pbc
lua/library/zlib.pbc
LIBS
    $S0 = pop $P3
    $P0['inst_lang'] = $P3

    # dist
    $P4 = split ' ', 'Test/More.lua'
    $P0['manifest_includes'] = $P4
    $P5 = split ' ', 'lua/library/sha1.pir Test/More.pir'
    $P0['manifest_excludes'] = $P5
    $P0['doc_files'] = 'README'

    .tailcall setup(args :flat, $P0 :flat :named)
.end

.sub 'build' :anon
    .param pmc kv :slurpy :named
    $I0 = newer('lua/library/sha1.pir', 'lua/library/md5.pir')
    if $I0 goto L1
    .local string cmd
    cmd = 'perl -pe "s|md5|sha1|g; s|MD5|SHA1|g" lua/library/md5.pir > lua/library/sha1.pir'
    system(cmd)
  L1:

    $P0 = kv['pir_lua']
    build_pir_lua($P0)
.end

.sub 'build_pir_lua' :anon
    .param pmc hash
    $P0 = iter hash
  L1:
    unless $P0 goto L2
    .local string pir, lua
    pir = shift $P0
    lua = hash[pir]
    $I0 = newer(pir, lua)
    if $I0 goto L1
    .local string cmd
    cmd = get_bindir()
    cmd .= "/parrot-luap"
    $S0 = get_exe()
    cmd .= $S0
    cmd .= " --target=pir "
    cmd .= lua
    cmd .= " > "
    cmd .= pir
    system(cmd)
    goto L1
  L2:
.end

.sub 'clean' :anon
    .param pmc kv :slurpy :named
    unlink('lua/library/sha1.pir')
    $P0 = kv['pir_lua']
    clean_key($P0)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
