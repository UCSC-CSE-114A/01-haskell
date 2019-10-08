module Paths_hw1_haskell (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/vishal/workspace/f19/cse116/01-haskell/.stack-work/install/x86_64-linux/lts-5.9/7.10.3/bin"
libdir     = "/home/vishal/workspace/f19/cse116/01-haskell/.stack-work/install/x86_64-linux/lts-5.9/7.10.3/lib/x86_64-linux-ghc-7.10.3/hw1-haskell-0.1.0.0-GauvwzAVOjwBWn5bS0RixW"
datadir    = "/home/vishal/workspace/f19/cse116/01-haskell/.stack-work/install/x86_64-linux/lts-5.9/7.10.3/share/x86_64-linux-ghc-7.10.3/hw1-haskell-0.1.0.0"
libexecdir = "/home/vishal/workspace/f19/cse116/01-haskell/.stack-work/install/x86_64-linux/lts-5.9/7.10.3/libexec"
sysconfdir = "/home/vishal/workspace/f19/cse116/01-haskell/.stack-work/install/x86_64-linux/lts-5.9/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hw1_haskell_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hw1_haskell_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "hw1_haskell_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hw1_haskell_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hw1_haskell_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
