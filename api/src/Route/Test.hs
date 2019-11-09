module Route.Test where

import           Servant
import           Types

handler :: AppM NoContent
handler = pure NoContent

type Type = "test" :> Get '[JSON] NoContent
