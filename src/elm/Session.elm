module Session exposing (..)

import Lib.User as User exposing (User)

type Session
  = Anon
  | Active User
