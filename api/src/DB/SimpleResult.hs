module DB.SimpleResult
    ( module DB.SimpleResult
    , module DB.Hasql
    , module Hasql.Decoders
    , module Hasql.Session
    , module Hasql.Statement
    , Text
    ) where

import           Control.Monad.Trans.Reader
import           Data.ByteString

import           Data.Generics.Internal.VL.Lens
import           Data.Text
import           DB.Hasql
import           Hasql.Decoders
import qualified Hasql.Encoders                 as E
import           Hasql.Pool                     (UsageError)
import           Hasql.Session
import           Hasql.Statement
import           Types

query' :: ByteString -> Result b -> Session b
query' sqlCode decoder = statement () $ Statement sqlCode mempty decoder True

query :: ByteString -> Result a -> AppM (Either UsageError a)
query sqlCode decoder = ask >>= \state ->
    db (state ^. #pool) $ query' sqlCode decoder

queryParams :: ByteString -> a -> E.Params a -> Result b -> AppM (Either UsageError b)
queryParams sqlCode val encoder decoder = ask >>= \state ->
    db (state ^. #pool) $ statement val $ Statement sqlCode encoder decoder True
