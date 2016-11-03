#
# Update submodule
#
Invoke-Expression "git submodule update --init --recursive"

#
# Python configuration
#

# Deduce minimal version format from full version (ex: 3.5 gives 35).
$python_version_array = $env:python_version.Split('.')
$python_version_minimal = $python_version_array[0] + $python_version_array[1]

if ($env:arch -eq 32) {
    $python_path = "C:\Python$python_version_minimal;$env:PATH"
} else {
    $python_path = "C:\Python$python_version_minimal-x64;$env:PATH"
}

$env:PATH = "$python_path;$env:PATH"

#
# Node configuration
#

if ($env:arch -eq 32) {
    $node_arch = "x86"
} else {
    $node_arch = "x64"
}
Install-Product node 6.9.1 $node_arch
Invoke-Expresion "node --version"
Invoke-Expresion "npm -v"

#
# TypeScript configuration
#

Invoke-Expression "npm install -g typescript"

#
# Rust configuration
#

if ($env:arch -eq 32) {
    $rust_arch = "i686"
} else {
    $rust_arch = "x86_64"
}

$rust_installer = "rust-$env:rust_version-$rust_arch-pc-windows-msvc.msi"
$rust_url = "https://static.rust-lang.org/dist/$rust_installer"
$rust_output = "$env:APPVEYOR_BUILD_FOLDER\$rust_installer"
(New-Object System.Net.WebClient).DownloadFile($rust_url, $rust_output)
Start-Process "msiexec.exe" -ArgumentList "/i $rust_output /qn INSTALLDIR_MACHINE=C:\Rust" -Wait

$env:PATH = "C:\Rust\bin;$env:PATH"
