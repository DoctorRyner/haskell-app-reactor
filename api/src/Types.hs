module Types where

import           Config
import           Control.Monad.Trans.Reader
import           Servant

data State = State
    { pool   :: ()
    , config :: Config
    }

mkState :: Config -> State
mkState config = State
    { pool   = ()
    , config = config
    }

type AppM = ReaderT State Handler

nt :: State -> AppM a -> Handler a
nt s x = runReaderT x s
