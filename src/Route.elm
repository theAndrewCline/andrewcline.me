module Route exposing (Route(..), toRoute)

import Url
import Url.Parser exposing (Parser, map, oneOf, parse, s, top)


type Route
    = Home
    | PostSearch


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        , map PostSearch (s "posts")
        ]


toRoute : Url.Url -> Route
toRoute url =
    Maybe.withDefault Home (parse routeParser url)
