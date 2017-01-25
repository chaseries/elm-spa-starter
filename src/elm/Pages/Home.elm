module Pages.Home exposing (Msg, Model, initialModel, view)

import Html exposing (Html, div, text, header)

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
    [ text "Welcome to the home page of an Elm SPA starter app." ]
