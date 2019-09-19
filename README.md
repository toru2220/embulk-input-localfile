# Localfile input plugin for Embulk

TODO: Write short description here and embulk-input-localfile.gemspec file.

## Overview

* **Plugin type**: input
* **Resume supported**: yes
* **Cleanup supported**: yes
* **Guess supported**: no

## Configuration

- **dir**: description (string, default: `"."`)
- **recurse**: description (bool, default: `false`)
- **fileonly**: description (bool, default: `false`)
- **filter**: description (string, default: `"*"`)

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

