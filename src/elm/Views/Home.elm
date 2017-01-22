module Views.Home exposing (view)

import Html exposing (Html, div)

type Msg
  = NoOp

type alias Model =
  ()

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  model ! []

view : Html Msg
view = div [] []
