module Route exposing (Route(..), toRoute)

import Url
import Url.Parser exposing (Parser, map, oneOf, parse, s, top)


type Route
    = Home
    | Contact


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        , map Contact <| s "contact"
        ]


toRoute : Url.Url -> Route
toRoute url =
    Maybe.withDefault Home (parse routeParser url)
