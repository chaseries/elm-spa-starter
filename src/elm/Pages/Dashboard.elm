module Pages.Dashboard exposing (Msg, Model, initialModel, view)

import Html exposing (..)

type Msg
  = NoOp

type alias Model =
  ()

initialModel : Model
initialModel =
  ()

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  model ! []

view : Model -> Html Msg
view model =
  div
    []
    [ text "An dashboard page." ]
