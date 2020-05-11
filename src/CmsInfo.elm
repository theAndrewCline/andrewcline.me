module CmsInfo exposing (CmsInfo, Post, cmsDecoder)

import Json.Decode exposing (Decoder, field, list, map, map4, string)


type alias CmsInfo =
    { posts : List Post }


cmsDecoder : Decoder CmsInfo
cmsDecoder =
    map CmsInfo
        (field "posts" (list postDecoder))


type alias Post =
    { title : String
    , date : String
    , description : String
    , body : String
    }


postDecoder =
    map4 Post
        (field "title" string)
        (field "date" string)
        (field "description" string)
        (field "body" string)
