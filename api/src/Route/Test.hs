module Route.Test where

import           DB.Simple
import           Servant
import           Types

type Type = "test" :> Get '[JSON] NoContent

handler :: AppM NoContent
handler = do
    exec_ "drop table kek"
    pure NoContent
