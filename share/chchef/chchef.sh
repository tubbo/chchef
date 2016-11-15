#!/bin/bash

chchef() {
  if [[ -z "$1" ]]; then
    echo "Usage: chchef [init] NAME"
    return
  fi
  case "$1" in
  init)
    name=$2
    mkdir -p ~/.chef/$name
    mv ~/.chef/knife.rb ~/.chef/$name/knife.rb
    mv ~/.chef/${USER}.pem ~/.chef/$name/${USER}.pem
    if [[ -f ~/.chef/$name-validator.pem ]]; then
      mv ~/.chef/$name-validator.pem ~/.chef/$name/$name-validator.pem
    fi
    chchef $name
    ;;
  *)
    name=$1

    if [[ -d ~/.chef/$1 ]]; then
      rm -f ~/.chef/knife.rb ~/.chef/${USER}.pem ~/.chef/${name}-validator.pem
      ln -s ~/.chef/$name/knife.rb ~/.chef/knife.rb
      ln -s ~/.chef/$name/${USER}.pem ~/.chef/${USER}.pem

      if [[ -f ~/.chef/$name/$name-validator.pem ]]; then
        ln -s ~/.chef/$name/$name-validator.pem ~/.chef/$name-validator.pem
      fi
    else
      echo "No such file or directory: ~/.chef/$1"
      return
    fi

    ;;
  esac
}
