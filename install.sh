#!/bin/bash

mypath="$(dirname "`readlink -f "$0"`")"

package=$1

stow -d "$mypath" -t "$HOME" $@

