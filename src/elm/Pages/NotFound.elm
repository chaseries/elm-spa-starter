module Pages.NotFound exposing (Msg, Model, initialModel, view)

import Html exposing (..)

type Msg
  = NoOp

type alias Model =
  ()

initialModel : Model
initialModel =
  ()

view : Model -> Html Msg
view model =
  div
    []
    [ text "That's a 404" ]
