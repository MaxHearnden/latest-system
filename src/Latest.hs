{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}

module Latest where

import Servant
import Control.Monad.IO.Class
import System.Directory
import System.FilePath

type LatestAPI = Capture "machine" String :> Get '[PlainText] FilePath

server :: Server LatestAPI
server = readMachineLink
  where
    readMachineLink name = do
      links <- liftIO $ listDirectory "/nix/var/nix/profiles/all"
      if elem name links then
        liftIO $ getSymbolicLinkTarget $ "/nix/var/nix/profiles/all" </> name
      else
        throwError $ err404 { errBody = "hostname not found in profile" }

latestAPI :: Proxy LatestAPI
latestAPI = Proxy

app = serve latestAPI server
