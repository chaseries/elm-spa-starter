module Pages.About exposing (Msg, Model, initialModel, view)

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
    [ text "About the Elm SPA starter." ]
