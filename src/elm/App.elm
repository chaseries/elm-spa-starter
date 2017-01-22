module App exposing (..)

import Navigation
import Html exposing (..)
import Pages.Home as HomePage
import Pages.About as AboutPage
import Pages.NotFound as NotFoundPage
import Routing

import Skeleton

type alias Model =
  { page : Routing.Page 
  , homePageModel : HomePage.Model
  , aboutPageModel : AboutPage.Model
  , notFoundPageModel : NotFoundPage.Model
  }

initialModel : Model
initialModel =
  { page = Routing.Home
  , homePageModel = HomePage.initialModel
  , aboutPageModel = AboutPage.initialModel
  , notFoundPageModel = NotFoundPage.initialModel
  }

type Msg
  = ChangeLocation Navigation.Location
  | HomePageMsg HomePage.Msg
  | AboutPageMsg AboutPage.Msg
  | NotFoundPageMsg NotFoundPage.Msg

init : Navigation.Location -> (Model, Cmd Msg)
init loc =
  update (ChangeLocation loc) initialModel

view : Model -> Html Msg
view model =
  selectView model
    |> Skeleton.applyLayout

selectView : Model -> Html Msg
selectView model =
  case model.page of
    Routing.Home ->
      Html.map HomePageMsg (HomePage.view model.homePageModel)
    Routing.About ->
      Html.map AboutPageMsg (AboutPage.view model.aboutPageModel)
    Routing.NotFound ->
      Html.map NotFoundPageMsg (NotFoundPage.view model.notFoundPageModel)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeLocation loc ->
      { model | page = Routing.locationToPage loc } ! []
    _ ->
      model ! []

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
