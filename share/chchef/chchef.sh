#!/bin/bash

chchef() {
  if [[ -z "$1" ]]; then
    echo "Usage: chchef [init] NAME"
    return
  fi
  case "$1" in
  init)
    name=$2
    mkdir -p "$HOME/.chef/$name"
    mv "$HOME/.chef/knife.rb" "$HOME/.chef/$name/knife.rb"
    mv "$HOME/.chef/${USER}.pem" "$HOME/.chef/$name/${USER}.pem"
    if [[ -f $HOME/.chef/$name-validator.pem ]]; then
      mv "$HOME/.chef/$name-validator.pem" "$HOME/.chef/$name/$name-validator.pem"
    fi
    chchef "$name"
    ;;
  *)
    name=$1

    if [[ -d $HOME/.chef/$1 ]]; then
      rm -f "$HOME/.chef/knife.rb" "$HOME/.chef/${USER}.pem" "$HOME/.chef/${name}-validator.pem"
      ln -s "$HOME/.chef/$name/knife.rb" "$HOME/.chef/knife.rb"
      ln -s "$HOME/.chef/$name/${USER}.pem" "$HOME/.chef/${USER}.pem"

      if [[ -f "$HOME/.chef/$name/$name-validator.pem" ]]; then
        ln -s "$HOME/.chef/$name/$name-validator.pem" "$HOME/.chef/$name-validator.pem"
      fi
      echo "You are now using ~/.chef environment $name"
    else
      echo "No such file or directory: $HOME/.chef/$1"
      return
    fi

    ;;
  esac
}
