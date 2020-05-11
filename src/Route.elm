module Route exposing (Route(..), cleanPostTitle, toRoute)

import CmsInfo exposing (Post)
import Url
import Url.Parser exposing ((</>), Parser, map, oneOf, parse, s, string, top)


type Route
    = Home
    | Posts
    | PostRoute String


cleanPostTitle : String -> String
cleanPostTitle title =
    String.toLower title
        |> String.map
            (\c ->
                if c == ' ' then
                    '-'

                else
                    c
            )


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        , map Posts (s "posts")
        , map PostRoute (s "posts" </> string)
        ]


toRoute : Url.Url -> Route
toRoute url =
    Maybe.withDefault Home (parse routeParser url)
