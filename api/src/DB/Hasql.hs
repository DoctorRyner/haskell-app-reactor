module DB.Hasql where

import           Config
import           Control.Monad.IO.Class         (MonadIO, liftIO)
import           Data.Generics.Internal.VL.Lens
import           Hasql.Connection
import           Hasql.Pool                     (Pool, UsageError, use)
import           Hasql.Session

convertSettings :: PostgreSQLConfig -> Settings
convertSettings psql =
    settings "localhost" 5432 (psql ^. #username) (psql ^. #password) (psql ^. #dbname)

-- connect :: IO Connection
-- connect = do
    -- Right connection <- acquire dbSettings
    -- pure connection

-- mkQuery :: MonadIO m => Session a -> m (Maybe a)
-- mkQuery query = liftIO (run query =<< connect) >>= \case
    -- Right val -> pure $ Just val
    -- Left  _   -> pure Nothing

errOrUnpack :: MonadIO m => m a -> m (Maybe a) -> m a
errOrUnpack err handler = handler >>= \case
    Just val -> pure val
    Nothing  -> err

db :: MonadIO m => Pool -> Session a -> m (Either UsageError a)
db pool query = liftIO $ use pool query
