module Post exposing (Post, postDecoder)

import Json.Decode exposing (Decoder, field, list, string)


type alias Post =
    String


postDecoder : Decoder (List String)
postDecoder =
    field "posts" (list string)
