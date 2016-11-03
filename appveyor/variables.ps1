# Input environment variables:
#   arch: Architecture (32 or 64)
#   msvc: Microsoft Visual C++ version (11, 12, 14)
#   appveyor_repo_tag_name: AppVeyor tag (Vim tags are in vX.Y.Z form)
#   python_version: Python version
#   rust_version: Rust version
#   bintray_username: Bintray username
#
# Output environment variables:
#   vim_version: Vim version in X.Y.Z form
#   vim_artifact: Vim executable name
#   vim_tweet: message send on Twitter
#   git_description: release notes on GitHub
#   bintray_description: description on Bintray

function GetMajorVersion($version) {
    $version_array = $version.Split('.')
    $version_array[0]
}


function GetMajorMinorVersion($version) {
    $version_array = $version.Split('.')
    $version_array[0] + '.' + $version_array[1]
}

# TODO: use commit hash
$ycmd_version = "BETA"

if ($env:arch -eq 32) {
    $ycmd_arch = "x86"
} else {
    $ycmd_arch = "x64"
}

$python_major_version = GetMajorVersion $env:python_version

$ycmd_archive_name = "ycmd$ycmd_version-$ycmd_arch-python$python_major_version.zip"

$python_major_minor_version = GetMajorMinorVersion $env:python_version
$rust_major_minor_version = GetMajorMinorVersion $env:rust_version

# AppVeyor uses "\n" as a convention for newlines in GitHub description
# TODO: write a description for GitHub.
$github_description = ""

$env:ycmd_version = $ycmd_version
$env:ycmd_artifact = $ycmd_archive_name
$env:ycmd_tweet = "ycmd $ycmd_version $env:arch-bit for Windows released: https://bintray.com/artifact/download/$env:bintray_username/generic/$ycmd_archive_name"
$env:bintray_description = "ycmd $ycmd_version 32-bit and 64-bit for Windows. Depends on Python $python_major_version. Compiled with MSVC $env:msvc."
$env:git_description = $git_description
