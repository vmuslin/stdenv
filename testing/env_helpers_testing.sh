#!/bin/bash

. ~/stdenv/tools/testing_funcs.sh
. ~/stdenv/env_helpers.sh

#-------------------------------------------------------------------------------
# Define unit tests
#-------------------------------------------------------------------------------

function test_copy_dir()
{
    local tmpfromdir=/tmp/test_copy_dir_$$_from
    local tmptodir=/tmp/test_copy_dir_$$_to

    if [[ -d $tmpfromdir ]]; then rm -rf $tmpfromdir; fi
    if [[ -d $tmptodir ]]; then rm -rf $tmptodir; fi

    copy_dir $tmpfromdir $tmptodir
    if [[ -d $tmpfromdir || -d $tmptodir ]]; then echo -e "$(testing__fail)"; else echo -e "$(testing__pass) - Nothing to copy"; fi

    mkdir $tmpfromdir
    echo "file" > $tmpfromdir/file
    copy_dir $tmpfromdir $tmptodir
    if [[ -d $tmptodir && -f $tmptodir/file ]]; then echo -e "$(testing__pass) - Copied"; else echo -e "$(testing__fail)"; fi

    if [[ -d $tmpfromdir ]]; then rm -rf $tmpfromdir; fi
    if [[ -d $tmptodir ]]; then rm -rf $tmptodir; fi
}

function test_copy_file()
{
    local tmpfromfile=/tmp/test_copy_file_$$_from
    local tmptofile=/tmp/test_copy_file_$$_to

    if [[ -f $tmpfromfile ]]; then rm $tmpfromfile; fi
    if [[ -f $tmptofile ]]; then rm $tmptofile; fi

    copy_file $tmpfromfile $tmptofile
    if [[ -f $tmpfromfile || -f $tmptofile ]]; then echo -e "$(testing__fail)"; else echo -e "$(testing__pass) - Nothing to copy"; fi

    echo "from" > $tmpfromfile
    copy_file $tmpfromfile $tmptofile
    if [[ -f $tmptofile ]]; then echo -e "$(testing__pass) - Copied"; else echo -e "$(testing__fail)"; fi

    if [[ -f $tmpfromfile ]]; then rm $tmpfromfile; fi
    if [[ -f $tmptofile ]]; then rm $tmptofile; fi
}

function test_create_symlink()
{
    local tmpfile=/tmp/test_create_symlink_file_$$
    local tmplink=/tmp/test_create_symlink_symlink_$$

    if [[ -f $tmpfile ]]; then rm $tmpfile; fi
    if [[ -L $tmplink ]]; then rm $tmplink; fi

    create_symlink $tmpfile $tmplink
    if [[ -L $tmplink ]]; then echo -e "$(testing__fail)"; else echo -e "$(testing__pass) - Nothing to copy"; fi

    touch $tmpfile
    create_symlink $tmpfile $tmplink
    if [[ -L $tmplink ]]; then echo -e "$(testing__pass) - Symlink created"; else echo -e "$(testing__fail)"; fi

    create_symlink $tmpfile $tmplink && echo -e "$(testing__fail)" || echo -e "$(testing__pass) - symlink already exists"

    if [[ -f $tmpfile ]]; then rm $tmpfile; fi
    if [[ -L $tmplink ]]; then rm $tmplink; fi
}

function test_exists_file_or_symlink()
{
    local tmpfile=/tmp/test_exists_file_$$
    local tmpsymlink=${tmpfile}_symlink

    if [[ -f $tmpfile ]]; then rm $tmpfile; fi
    if [[ -L $tmpsymlink ]]; then rm $tmpsymlink; fi

    exists_file_or_symlink $tmpfile && echo -e "$(testing__fail) - $tmpfile exists" || echo -e "$(testing__pass) - $tmpfile does not exist"

    touch $tmpfile
    exists_file_or_symlink $tmpfile && echo -e "$(testing__pass) - $tmpfile exists" || echo -e "$(testing__fail) - $tmpfile does not exist"

    ln -s $tmpfile $tmpsymlink
    exists_file_or_symlink $tmpsymlink && echo -e "$(testing__pass) - $tmpsymlink exists" || echo -e "$(testing__fail) - $tmpsymlink does not exist"
    
    if [[ -f $tmpfile ]]; then rm $tmpfile; fi
    if [[ -L $tmpsymlink ]]; then rm $tmpsymlink; fi
}

function test_move_file()
{
    local tmpfromfile=/tmp/tmpfromfile_$$
    local tmptofile=/tmp/tmptofile_$$

    if [[ -f $tmpfromfile ]]; then rm $tmpfromfile; fi
    if [[ -f $tmptofile ]]; then rm $tmptofile; fi

    move_file $tmpfromfile $tmptofile
    if [[ -f $tmptofile ]]; then echo -e "$(testing__fail)"; else echo -e "$(testing__pass) - nothing to move"; fi

    echo "from" > $tmpfromfile
    move_file $tmpfromfile $tmptofile
    if [[ -f $tmptofile || ! -f $tmpfromfile ]]; then echo -e "$(testing__pass) - moved file"; else echo -e "$(testing__fail)"; fi

    if [[ -f $tmpfromfile ]]; then rm $tmpfromfile; fi
    if [[ -f $tmptofile ]]; then rm $tmptofile; fi
}

function test_osVersion()
{
    [[ -n $(osVersion) ]] && echo "$(testing__pass) - OS Version: $(osVersion)" || echo "$(testing__fail)"
}

function test_remove_dir()
{
    local tmpdir=/tmp/test_remove_dir_$$

    if [[ -d $tmpdir ]]; then rm -rf $tmpdir; fi

    mkdir $tmpdir
    echo "file" > $tmpdir/file
    remove_dir $tmpdir
    if [[ -d $tmpdir ]]; then echo -e "$(testing__fail)"; else echo -e "$(testing__pass) - directory removed"; fi

    if [[ -d $tmpdir ]]; then rm -rf $tmpdir; fi
}

function test_remove_file()
{
    local tmpfile=/tmp/test_remove_file_$$

    if [[ -f $tmpfile ]]; then rm $tmpfile; fi

    touch $tmpfile
    remove_file $tmpfile
    if [[ -f $tmpfile ]]; then echo -e "$(testing__fail)"; else echo -e "$(testing__pass) - file removed"; fi

    if [[ -f $tmpfile ]]; then rm $tmpfile; fi
}

function test_safecopy_file()
{
    local tmpfromfile=/tmp/test_safecopy_file_$$_from
    local tmptofile=/tmp/test_safecopy_file_$$_to

    if [[ -f $tmpmfromfile ]]; then rm $tmpfromfile; fi
    if [[ -f $tmptofile ]]; then rm $tmptofile; fi

    echo "from" > $tmpfromfile
    safecopy_file $tmpfromfile $tmptofile
    if [[ -f $tmptofile ]]; then echo -e "$(testing__pass) - file copied"; else echo -e "$(testing__fail)"; fi

    safecopy_file $tmpfromfile $tmptofile && echo -e "$(testing__fail)" || echo -e "$(testing__pass) - could not copy over the existing file"

    if [[ -f $tmpfromfile ]]; then rm $tmpfromfile; fi
    if [[ -f $tmptofile ]]; then rm $tmptofile; fi
}

function test_safemove_file()
{
    local tmpfromfile=/tmp/test_savemove_file_from_$$
    local tmptofile=/tmp/test_savemove_file_to_$$

    if [[ -f $tmpmfromfile ]]; then rm $tmpfromfile; fi
    if [[ -f $tmptofile ]]; then rm $tmptofile; fi

    safemove_file $tmpfromfile $tmptofile && echo -e "$(testing__fail)" || echo -e "$(testing__pass) - nothing to move"

    echo "to" > $tmptofile
    safemove_file $tmpfromfile $tmptofile && echo -e "$(testing__fail)" || echo -e "$(testing__pass) - nothing to move"

    echo "from" > $tmpfromfile
    safemove_file $tmpfromfile $tmptofile && echo -e "$(testing__fail)" || echo -e "$(testing__pass) - could not move over the existing file"

    rm $tmptofile
    safemove_file $tmpfromfile $tmptofile && echo -e "$(testing__pass) - moved file" || echo -e "$(testing__fail)"

    if [[ -f $tmpmfromfile ]]; then rm $tmpfromfile; fi
    if [[ -f $tmptofile ]]; then rm $tmptofile; fi
}

#-------------------------------------------------------------------------------
# Run tests
#-------------------------------------------------------------------------------

testing__run_test \
    test_exists_file_or_symlink \
		test_copy_dir \
    test_copy_file \
    test_safecopy_file \
    test_create_symlink \
    test_move_file \
    test_safemove_file \
    test_remove_file \
    test_remove_dir \
    test_osVersion
