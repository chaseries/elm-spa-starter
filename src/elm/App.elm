module App exposing (..)

import Navigation
import Html exposing (..)
import Pages.Home as HomePage
import Pages.About as AboutPage
import Pages.NotFound as NotFoundPage
import Routing
import Task
import Api.Auth exposing (..)

import Skeleton


type alias Model =
  { page : Routing.Page 
  , homePageModel : HomePage.Model
  , aboutPageModel : AboutPage.Model
  , notFoundPageModel : NotFoundPage.Model
  }

initialModel : Model
initialModel =
  { page = Routing.home
  , homePageModel = HomePage.initialModel
  , aboutPageModel = AboutPage.initialModel
  , notFoundPageModel = NotFoundPage.initialModel
  }

type Msg
  = ChangeLocation Navigation.Location
  | HomePageMsg HomePage.Msg
  | AboutPageMsg AboutPage.Msg
  | NotFoundPageMsg NotFoundPage.Msg
  | IsLoggedIn Msg
  | NoOp

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
    (Routing.Unrestricted Routing.Home)->
      Html.map HomePageMsg (HomePage.view model.homePageModel)
    (Routing.Restricted Routing.About) ->
      Html.map AboutPageMsg (AboutPage.view model.aboutPageModel)
    (Routing.Unrestricted Routing.NotFound) ->
      Html.map NotFoundPageMsg (NotFoundPage.view model.notFoundPageModel)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeLocation loc ->
      { model | page = Routing.locationToPage loc } ! []
    IsLoggedIn msg ->
      update msg model
    _ ->
      model ! []

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
