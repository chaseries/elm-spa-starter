module Skeleton exposing (layoutHeader, layoutFooter, applyLayout)

import Html exposing (..)
import Html.Events as Events
import Html.Attributes as Attrs

layoutHeader : Html msg
layoutHeader =
  header
    []
    [ text "Header" ]

layoutFooter : Html msg
layoutFooter =
  footer
    []
    [ text "Footer" ]

applyLayout : Html msg -> Html msg
applyLayout content =
  div
    []
    [ layoutHeader 
    , content
    , layoutFooter
    ]
