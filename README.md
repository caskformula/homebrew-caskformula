# caskformula

caskformula is a tap for providing [homebrew](http://brew.sh/) formulae for software packaged as [casks](https://caskroom.github.io/).

## Inkscape

### Install

```bash
brew install caskformula/caskformula/inkscape
```

* git 0.92.x branch

```bash
brew install caskformula/caskformula/inkscape --HEAD --branch-0.92
```

* git master branch

```bash
brew install caskformula/caskformula/inkscape --HEAD
```

### Known issues

* Locale must me manually specified using the `LANG` environment variable. For example:

```bash
LANG=fr inkscape
```

* Inkscape fails on launch with a critical error when using certain locales: `ar`, `de`, `doi`, `el`, `es`, `es_MX`, `hu`, `is`, `ja`, `ks@deva`, `lv`, `ru`, `sat`, `sat@deva`, `sk`, `sr`, `sr@latin`, `tr`, `uk`, `ur`
