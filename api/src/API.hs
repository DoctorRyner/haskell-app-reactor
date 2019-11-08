module API where

import           Control.Monad.Trans.Class (lift)
import           Servant
import           Servant.Swagger
import           Servant.Swagger.UI
import           Types

type Routes = Get '[JSON] NoContent

server :: ServerT API AppM
server = serverDocs
    :<|> pure NoContent

type AppDocs = SwaggerSchemaUI "swagger-ui" "swagger.json"

type API = AppDocs :<|> Routes

api :: Proxy API
api = Proxy

serverDocs :: ServerT AppDocs AppM
serverDocs = hoistServer (Proxy :: Proxy AppDocs) lift $ swaggerSchemaUIServer (toSwagger (Proxy :: Proxy Routes))
