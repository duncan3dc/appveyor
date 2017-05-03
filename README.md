# appveyor
Script to setup a PHP environment on AppVeyor

Example usage:

```yaml
platform:
  - x86
  - x64

environment:
  matrix:
    - PHP_VERSION: 7.0
    - PHP_VERSION: 7.1

init:
  - SET DUNCAN3DC_CACHE=c:\duncan3dc

cache:
  - '%DUNCAN3DC_CACHE%'

install:
  - appveyor DownloadFile https://raw.githubusercontent.com/duncan3dc/appveyor/master/php.ps1
  - ps: .\php.ps1

test_script:
  - cd %APPVEYOR_BUILD_FOLDER%
  - vendor\bin\phpunit

build: false
clone_depth: 5
```
