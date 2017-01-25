module Routing exposing (..)

import List
import Dict exposing (Dict)
import Task exposing (Task)
import Navigation
import UrlParser

import Session exposing (Session)

type Page
  = Home
  | Dashboard
  | NotFound
  | Unauthorized

type alias Url =
  String

restrictedPages : List Page
restrictedPages =
  [ Dashboard 
  ]

unrestrictedPages : List Page
unrestrictedPages =
  [ Home
  , NotFound
  , Unauthorized 
  ]

getPageWithAuth : Session -> Page -> Page
getPageWithAuth session page =
  case session of
    Session.Anon ->
      case List.member page restrictedPages of
        True ->
          Unauthorized
        False ->
          page
    _ ->
      page

access : Session -> Page -> Cmd msg
access session page =
  getPageWithAuth session page
    |> pageToUrl
    |> Navigation.newUrl

requestLoggedInStatus : (Result x Bool -> msg) -> Cmd msg
requestLoggedInStatus handler =
  Task.attempt handler (Task.succeed True) 

pageToUrl : Page -> Url
pageToUrl page =
  case page of
    Home ->
      "/"
    Dashboard ->
      "/dashboard"
    NotFound ->
      "/404"
    Unauthorized ->
      "/unauthorized"

urlParser : UrlParser.Parser (Page -> a) a
urlParser =
  UrlParser.oneOf
    [ UrlParser.map Home (UrlParser.s "") 
    , UrlParser.map Dashboard (UrlParser.s "dashboard")
    , UrlParser.map NotFound (UrlParser.s "404")
    , UrlParser.map Unauthorized (UrlParser.s "unauthorized")
    ]

locationToPage : Session -> Navigation.Location -> Page
locationToPage session loc =
  case UrlParser.parsePath urlParser loc of
    Nothing ->
      NotFound
    Just page ->
      getPageWithAuth session page
