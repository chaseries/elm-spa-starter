module Routing exposing (..)

import List
import Dict exposing (Dict)
import Task exposing (Task)
import Navigation
import UrlParser
import Session exposing (Session)

type Page
  = Home
  | About
  | NotFound
  | Unauthorized

type alias Url =
  String

restrictedPages : List Page
restrictedPages =
  [ About ]

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
    Home -> "/"
    NotFound -> "/404"
    About -> "/about"
    Unauthorized -> "/unauthorized"


urlParser : UrlParser.Parser (Page -> a) a
urlParser =
  UrlParser.oneOf
    [ UrlParser.map Home (UrlParser.s "") 
    , UrlParser.map About (UrlParser.s "about")
    , UrlParser.map NotFound (UrlParser.s "404")
    , UrlParser.map Unauthorized (UrlParser.s "unauthorized")
    ]

locationToPage : Navigation.Location -> Page
locationToPage loc =
  case UrlParser.parsePath urlParser loc of
    Nothing ->
      NotFound
    Just page ->
      page
