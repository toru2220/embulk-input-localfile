# Localfile input plugin for Embulk

TODO: Write short description here and embulk-input-localfile.gemspec file.

## Overview

* **Plugin type**: input
* **Resume supported**: yes
* **Cleanup supported**: yes
* **Guess supported**: no

## Configuration

- **dir**: target root dir (string, default: `"."`)
- **recurse**: search sub-directory (bool, default: `false`)
- **fileonly**: search file only (bool, default: `false`)
- **filter**: file filter ex. *.csv (string, default: `"*"`)

## Example

```yaml
  type: localfile
  dir: /path/to/dir
  recurse: true
  fileonly: true
  filter: csv
  columns:
    - { name: name, type: string }
    - { name: dir, type: string }
    - { name: size, type: long }
    - { name: timestamp, type: timestamp }
```

## Build

```
$ rake
```

