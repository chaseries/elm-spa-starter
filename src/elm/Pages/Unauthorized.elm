module Pages.Unauthorized exposing (..)


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
    [ text "You're not authorized to do that." ]
