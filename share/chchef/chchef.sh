#!/bin/bash
#
# chchef - the chef environment switcher

chchef() {
  if [[ -z "$CHEF_HOME" ]]; then
    CHEF_HOME="$HOME/.chef"
  fi

  if [[ -z "$1" ]]; then
    echo "Usage: chchef [init] NAME"
    return
  fi

  case "$1" in
  init)
    name=$2
    mkdir -p "$CHEF_HOME/$name"
    mv "$CHEF_HOME/knife.rb" "$CHEF_HOME/$name/knife.rb"
    mv "$CHEF_HOME/${USER}.pem" "$CHEF_HOME/$name/${USER}.pem"
    if [[ -f $CHEF_HOME/$name-validator.pem ]]; then
      mv "$CHEF_HOME/$name-validator.pem" "$CHEF_HOME/$name/$name-validator.pem"
    fi
    chchef "$name"
    ;;
  *)
    name=$1

    if [[ -d $CHEF_HOME/$1 ]]; then
      rm -f "$CHEF_HOME/knife.rb" "$CHEF_HOME/${USER}.pem" "$CHEF_HOME/${name}-validator.pem"
      ln -s "$CHEF_HOME/$name/knife.rb" "$CHEF_HOME/knife.rb"
      ln -s "$CHEF_HOME/$name/${USER}.pem" "$CHEF_HOME/${USER}.pem"

      if [[ -f "$CHEF_HOME/$name/$name-validator.pem" ]]; then
        ln -s "$CHEF_HOME/$name/$name-validator.pem" "$CHEF_HOME/$name-validator.pem"
      fi
      echo "You are now using Chef environment '$name'"
    else
      echo "No such file or directory: $CHEF_HOME/$1"
      return
    fi

    ;;
  esac
}
