#!/bin/bash
#
# chchef - the chef environment switcher

chchef() {
  if [[ -z "$CHEF_HOME" ]]; then
    CHEF_HOME="$HOME/.chef"
  fi

  if [[ -z "$1" ]]; then
    echo "Usage: chchef [--init] NAME [CREDENTIALS]"
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
      # report to user that env changed successfully
      echo "You are now using Chef environment '$name'"
    else
      # report to user which dir could not be found
      echo "No such file or directory: $CHEF_HOME/$1"
      return
    fi

    ;;
  esac
}
