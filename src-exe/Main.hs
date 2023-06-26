{-# LANGUAGE OverloadedStrings #-}

import Latest
import Network.Wai.Handler.Warp
import Data.Function

settings =
  defaultSettings &
  setPort 8081 &
  setHost "172.28.10.244"

main = runSettings settings app
