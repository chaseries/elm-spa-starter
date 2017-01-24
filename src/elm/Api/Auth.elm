module Api.Auth exposing (..)

import Task exposing (Task)


getIsAdmin : Task x Bool
getIsAdmin =
  Task.succeed False

getIsLoggedIn : Task x Bool
getIsLoggedIn =
  Task.succeed True

doIfLoggedIn : (Result x Bool -> msg) -> Cmd msg
doIfLoggedIn handler =
  Task.attempt handler getIsLoggedIn
