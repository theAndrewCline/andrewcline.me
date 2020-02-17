module Main exposing (..)

import Browser
import Html exposing (Html, a, button, div, h1, h3, img, li, text, ul)
import Html.Attributes exposing (class, href, src)



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "min-h-screen flex flex-col align-center bg-gray-100" ]
        [ ul [ class "flex bg-black py-4 font-body font-bold" ]
            [ li [ class "mx-4 text-gray-100 bold mr-auto font-display" ] [ text "Andrew Cline" ]

            -- , li [ class "mx-4 text-gray-100" ] [ text "Bio" ]
            -- , li [ class "mx-4 text-gray-100" ] [ text "Resume" ]
            -- , li [ class "mx-4 text-gray-100" ] [ text "Projects" ]
            ]
        , div
            [ class "container mx-auto my-4 py-4" ]
            [ h1 [ class "font-display text-4xl" ] [ text "Andrew Cline" ]
            , img [ src "./headshot.jpg", class "mx-auto rounded" ] []
            , h3 [ class "font-body font-bold text-xl" ] [ text "Software Developer" ]
            , h3 [ class "font-body text-lg" ] [ text "Peoria, IL" ]
            , button [ class "bg-black text-gray-100 p-2" ]
                [ a [ class "font-body underline", href "https://github.com/theAndrewCline" ] [ text "Github" ]
                ]
            ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
