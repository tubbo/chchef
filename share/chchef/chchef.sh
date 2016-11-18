#!/bin/bash
#
# chchef - the chef environment switcher

chchef() {
  if [[ -z "$CHEF_HOME" ]]; then
    CHEF_HOME="$HOME/.chef"
  fi

  CHEF_ENV_PATH="$CHEF_HOME/.chchef-current-env"
  CHEF_ENV=$(cat "$CHEF_ENV_PATH")

  if [[ -z "$1" ]]; then
    echo "Usage: chchef [--init] ORG_NAME [ORG_CREDENTIALS_FILE]"
    echo "Run \`man chef\` for more information"
    echo "You are currently within the '$CHEF_ENV' Chef environment"
    return
  fi

  case "$1" in
  # define new environment
  --init)
    name=$2
    archive=$3
    # create directory where files will be kept, block adding dirs that
    # already exist
    if ! mkdir "$CHEF_HOME/$name"; then
      return
    fi
    # unpack archive if given in arguments
    if [[ -n "$archive" ]]; then
      if ! tar -zxvf "$archive" "$CHEF_HOME"; then
        return
      fi
    fi
    # move files to their org directory
    mv "$CHEF_HOME/knife.rb" "$CHEF_HOME/$name/knife.rb"
    mv "$CHEF_HOME/${USER}.pem" "$CHEF_HOME/$name/${USER}.pem"
    if [[ -f $CHEF_HOME/$name-validator.pem ]]; then
      mv "$CHEF_HOME/$name-validator.pem" "$CHEF_HOME/$name/$name-validator.pem"
    fi
    # symlink files from their org directory to their original position
    chchef "$name"
    ;;
  # switch environment
  *)
    name=$1
    if [[ -d $CHEF_HOME/$1 ]]; then
      # remove existing symlinks
      rm -f "$CHEF_HOME/knife.rb" "$CHEF_HOME/${USER}.pem" "$CHEF_HOME/${name}-validator.pem"
      # link files from given org directory
      ln -s "$CHEF_HOME/$name/knife.rb" "$CHEF_HOME/knife.rb"
      ln -s "$CHEF_HOME/$name/${USER}.pem" "$CHEF_HOME/${USER}.pem"
      if [[ -f "$CHEF_HOME/$name/$name-validator.pem" ]]; then
        ln -s "$CHEF_HOME/$name/$name-validator.pem" "$CHEF_HOME/$name-validator.pem"
      fi
      echo "$name" > "$CHEF_ENV_PATH"
    else
      # report to user which dir could not be found
      echo "chchef: no such file or directory '$CHEF_HOME/$1'"
      return
    fi

    ;;
  esac
}
