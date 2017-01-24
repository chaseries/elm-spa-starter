module Routing exposing (..)

import Dict
import Task exposing (Task)
import Navigation
import UrlParser
import Session exposing (Session)

type Page
  = Restricted RPage
  | Unrestricted UPage

type UPage
  = Home
  | NotFound

type RPage
  = About

type alias Url =
  String

requestLoggedInStatus : (Result x Bool -> msg) -> Cmd msg
requestLoggedInStatus handler =
  Task.attempt handler (Task.succeed True) 

goTo : Session -> Page -> Cmd msg
goTo session piw =
  let 
    access =
      pageToUrl piw |> Navigation.newUrl
    deny =
      pageToUrl (Unrestricted NotFound) |> Navigation.newUrl
  in
  case piw of
    Unrestricted page  ->
      access
    Restricted page  ->
      case session of
        Session.Active _ ->
          access
        Session.Anon ->
          deny

pageToUrl : Page -> Url
pageToUrl piw =
  case piw of
    Unrestricted page -> 
      case page of
        Home -> "/"
        NotFound -> "/404"
    Restricted page ->
      case page of
        About -> "/about"

urlParser : UrlParser.Parser (Page -> a) a
urlParser =
  UrlParser.oneOf
    [ UrlParser.map home (UrlParser.s "") 
    , UrlParser.map about (UrlParser.s "about")
    , UrlParser.map notFound (UrlParser.s "404")
    ]

locationToPage : Navigation.Location -> Page
locationToPage loc =
  case UrlParser.parsePath urlParser loc of
    Nothing ->
      notFound
    Just page ->
      page

-- Routes
home = Unrestricted Home
about = Restricted About
notFound = Unrestricted NotFound

