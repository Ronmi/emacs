My emacs settings

# What's inside

- `auto-complete-mode`, `flycheck`, `yasnippet` and `projectile`
- `magit`
- `restclient`
- docker controlling and dockerfile editing
- nginx config file editing
- go env includes eldoc, auto complete and error checking
- php env includes `php-mode`, `phpcbf`, `php-boris`
- html/css/js/ts env including `emmet`, `web-mode`, `typescript-mode` and `tide`
- yaml, json and markdown support
- fixed size font for both Chinese and English

# Requirement for external environment

### Go env

- `GOROOT` set to `~/goroot`
- `GOPATH` set to `~/go`
- Install `gocode`, `errcheck`, `vet`, `guru` and `goimports`

### PHP env

- Install `boris.phar` in your path or `~/bin`
- Install `phpcbf` in your path or `~/bin`

# Install

Backup and remove your `.emacs.d` and `.emacs` first.

### With curl

```sh
curl https://raw.githubusercontent.com/Ronmi/emacs/master/install.sh | bash
```

### With wget

```sh
wget -q -O - https://raw.githubusercontent.com/Ronmi/emacs/master/install.sh | bash
```

### With php

You need `allow_url_fopen` to be true in your `php.ini`.

```sh
echo '<?php echo file_get_contents("https://raw.githubusercontent.com/Ronmi/emacs/master/install.sh");' | php | bash
```

### With node.js

```sh
echo 'require("https").get("https://raw.githubusercontent.com/Ronmi/emacs/master/install.sh", (r) => {r.on("data", (d) => {process.stdout.write(d);});});' | node | bash
```
