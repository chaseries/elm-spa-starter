module Routing exposing (..)

import Navigation
import UrlParser


type Page 
  = Home
  | About 
  | NotFound

type alias Url =
  String

pageToUrl : Page -> Url
pageToUrl page =
  case page of
    Home ->
      "/"
    About ->
      "/about"
    NotFound ->
      "404"

urlParser : UrlParser.Parser (Page -> a) a
urlParser =
  UrlParser.oneOf
    [ UrlParser.map Home (UrlParser.s "") 
    , UrlParser.map About (UrlParser.s "about")
    , UrlParser.map NotFound (UrlParser.s "404")
    ]

locationToPage : Navigation.Location -> Page
locationToPage loc =
  case UrlParser.parsePath urlParser loc of
    Nothing ->
      NotFound
    Just page ->
      page
