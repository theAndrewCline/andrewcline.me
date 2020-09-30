module Route exposing (Route(..), toRoute)

import Url
import Url.Parser exposing (Parser, map, oneOf, parse, top)


type Route
    = Home


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        ]


toRoute : Url.Url -> Route
toRoute url =
    Maybe.withDefault Home (parse routeParser url)
