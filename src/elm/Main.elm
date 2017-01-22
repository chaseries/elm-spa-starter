module Main exposing (..)

import Navigation exposing (program)
import App exposing (Model, Msg(..), init, view, update, subscriptions)

main : Program Never Model Msg
main =
  program ChangeLocation
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
