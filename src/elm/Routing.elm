module Routing exposing (..)

type Page 
  = Home
  | About 

pageToUrl page =
  case page of
    Home -> "/"
    Login -> "/about"
