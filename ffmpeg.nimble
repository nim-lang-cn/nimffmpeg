# Package

version       = "0.1.0"
author        = "Rahmatullah"
description   = "Ffmpeg C APIs binding"
license       = "MIT"
srcDir        = "src"
installDirs   = @["../cinclude"]
installExt    = @[".h", ".nim"]

# Dependencies

requires "nim >= 1.0.2"
