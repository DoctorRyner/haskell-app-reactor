module DB.SimpleResult
    ( module DB.SimpleResult
    , module DB.Hasql
    , module Hasql.Decoders
    , module Hasql.Session
    , module Hasql.Statement
    , Text
    ) where

import           Data.ByteString
import           Data.Text
import           DB.Hasql
import           Hasql.Decoders
import qualified Hasql.Encoders  as E
import           Hasql.Session
import           Hasql.Statement
import           Types

query' :: ByteString -> Result b -> Session b
query' sqlCode decoder = statement () $ Statement sqlCode mempty decoder True

query :: ByteString -> Result a -> AppM a
query sqlCode decoder = either (fail . show) pure =<< db (query' sqlCode decoder)

queryParams :: ByteString -> a -> E.Params a -> Result b -> AppM b
queryParams sqlCode val encoder decoder =
    either (fail . show) pure =<< db (statement val $ Statement sqlCode encoder decoder True)
