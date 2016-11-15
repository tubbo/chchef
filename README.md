# chchef

Change your current **~/.chef** environment.

## Installation

Clone this repo and run `make install`:

```bash
$ git clone https://github.com/tubbo/chchef.git
$ cd chchef
$ make install
```

Then in your shell init file (like **~/.bashrc**)...

```bash
source "/usr/local/share/chchef/chchef.sh"
```

## Usage

To initialize an org from your current config:

```bash
$ chchef init mycompany
You are now using Chef environment 'mycompany'
```

This will also automatically switch you to the **mycompany**
environment.

When you get new environments, add them in named subdirectories within
the **~/.chef/** directory, representing the environment or chef server
that they connect to. You can then run the following command to switch
to them:

```bash
$ chchef mynewcompany
You are now using Chef environment 'mynewcompany'
```

If `chchef` can't find configuration in that folder...

```bash
$ chchef bogus
No such file or directory ~/.chef/bogus
```

## Development

To run shellcheck:

```bash
$ make check
````

To run tests:

```bash
$ make test
```

This project uses the MIT License.

```
Copyright (c) 2016 Tom Scott

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
