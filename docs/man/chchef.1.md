# chchef 17 "Nov 2016" chchef "User Manuals"

## SYNOPSIS

`chchef` [--init] ORG_NAME [ORG_CREDENTIALS_FILE]

## DESCRIPTION

An environment switcher for Chef organizations. Allows a developer to
move easily between multiple Chef servers and orgs. A single command is
all that is needed to use a different Chef server or organization within
the same server.

## ARGUMENTS

*ORG_NAME*
          Name of the org directory in ~/.chef that is being switched
          to.

*ORG_CREDENTIALS_FILE*
          If the `--init` option is given (described below), this
          argument is a .tar.gz file path that will be unpacked into the
          ~/.chef directory, then moved to the folder given by ORG_NAME.

## OPTIONS

`--init`
          When this option is given, create a new directory in ~/.chef
          matching the ORG_NAME, and move the files in ~/.chef to the
          newly created org folder. If ORG_CREDENTIALS_FILE is given,
          its contents are unpacked into ~/.chef before symlinking.

## AUTHOR

Tom Scott <tubbo@psychedeli.ca>

## SEE ALSO

chef(1), knife(1)
