
if (!(Test-Path env:PHP_VERSION)) {
    $env:PHP_VERSION = "7.1"
}

if ($env:PHP_VERSION -eq "7.1") {
    $env:PHP_VERSION += ".7"
} elseif ($env:PHP_VERSION -eq "7.0") {
    $env:PHP_VERSION += ".21"
}

if (Test-Path env:DUNCAN3DC_CACHE) {
    Set-Variable -Name "cache" -Value $env:DUNCAN3DC_CACHE
} else {
    Set-Variable -Name "cache" -Value "c:\duncan3dc"
}

if (!(Test-Path $cache)) {
    mkdir $cache
}

Set-Variable -Name "zip" -Value "$($cache)\php-$($env:PHP_VERSION).zip"
if (!(Test-Path $zip)) {
    Invoke-WebRequest -Uri "http://windows.php.net/downloads/releases/archives/php-$($env:PHP_VERSION)-nts-Win32-VC14-$($env:PLATFORM).zip" -OutFile $zip
    if (Test-Path $cache\php) {
        rm $cache\php -r
    }
}

if (!(Test-Path $cache\php)) {
    7z x $zip -y -o"$cache\php"
}

if (!(Test-Path $cache\composer.phar)) {
    Invoke-WebRequest -Uri https://getcomposer.org/composer.phar -OutFile $cache\composer.phar
}

if (Test-Path $cache\php\php.ini) {
    rm $cache\php\php.ini
}

Invoke-WebRequest -Uri https://raw.githubusercontent.com/duncan3dc/appveyor/master/php.ini -OutFile $cache\php\php.ini

$env:PATH += ";$cache\php"

cd $env:APPVEYOR_BUILD_FOLDER
$env:COMPOSER_CACHE_DIR = "$cache\composer"

php $cache\composer.phar update --no-interaction
