module Config where

import           Data.Generics.Labels ()
import           Data.Text
import           Data.Yaml
import           GHC.Generics

data PostgreSQLConfig = PostgreSQLConfig
    { dbname
    , username
    , password :: Text
    } deriving Generic

instance FromJSON PostgreSQLConfig

newtype Config = Config
    { psql :: PostgreSQLConfig
    } deriving Generic

instance FromJSON Config

load :: IO Config
load = either (error . show) pure =<< decodeFileEither "config/config.yaml"
