module Main exposing (..)

import Html exposing (program)
import App exposing (Model, Msg, init, view, update, subscriptions)

main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
