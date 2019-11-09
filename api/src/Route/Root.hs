module Route.Root where

import           Servant
import           Types

handler :: AppM NoContent
handler = pure NoContent

type Type = Get '[JSON] NoContent
