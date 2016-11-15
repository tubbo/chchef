# chchef

Change your current **~/.chef** environment.

## Installation

```bash
source "/usr/local/share/chchef/chchef.sh"
```

## Usage

To initialize an org from your current config:

```bash
$ chchef init mycompany
```

This will also automatically switch you to the **mycompany**
environment.

When you get new environments, add them to `~/.chef/$new-company`. Then,
run the following command to switch to them:

```bash
$ chchef mynewcompany
```
