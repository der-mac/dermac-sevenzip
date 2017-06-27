# 7-Zip module for puppet

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with sevenzip](#setup)
    * [What sevenzip affects](#what-sevenzip-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with sevenzip](#beginning-with-sevenzip)
4. [Limitations](#limitations)

## Overview

The sevenzip-module installs the application 7-Zip

## Module Description

The sevenzip-module installs the application by downloading the given link and runs the installer in silent mode.
This happens only if the installed version is older (or not present) than the version that should be installed

## Setup

### What sevenzip affects

The sevenzip-module downloads the installation-file to the temp-directory of the user running the puppet-agent.

### Setup Requirements

The sevenzip-module uses the puppet-download_file module

### Beginning with sevenzip

for a simple sevenzip-installation use:

```puppet
    class { "sevenzip" :
    }
```

To install a specific version of sevenzip on Windows in the msi-format:

```puppet
    class { "sevenzip" :
      package_version => '16.04',
      download_link => 'http://7-zip.org/a/7z1700-x64.msi',
    }
```

To install a specific version of sevenzip on Windows in the exe-format:

```puppet
    class { "sevenzip" :
      package_version => '16.04',
      download_link => 'http://7-zip.org/a/7z1700-x64.exe',
    }
```

## Limitations

At the Moment, only windows 7 and windows 10 are supported.
