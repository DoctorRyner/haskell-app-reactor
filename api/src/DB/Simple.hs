module DB.Simple
    ( module DB.Simple
    , module DB.Hasql
    , module Hasql.Encoders
    , module Hasql.Session
    , module Hasql.Statement
    , Text
    ) where

import           Control.Monad.Trans.Reader
import           Data.ByteString                (ByteString)
import           Data.Generics.Internal.VL.Lens
import           Data.Text
import           DB.Hasql
import qualified Hasql.Decoders                 as D
import           Hasql.Encoders
import           Hasql.Pool                     (UsageError)
import           Hasql.Session
import           Hasql.Statement
import           Types

query' :: ByteString -> a -> Params a -> Session ()
query' sqlCode val encoder = statement val $ Statement sqlCode encoder D.noResult True

query :: ByteString -> a -> Params a -> AppM (Either UsageError ())
query sqlCode val encoder = ask >>= \state ->
    db (state ^. #pool) $ query' sqlCode val encoder
