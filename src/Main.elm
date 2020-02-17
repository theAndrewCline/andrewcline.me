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

            -- DISABLED MENU OPTIONS UNTIL PAGES ARE CREATED
            -- , li [ class "mx-4 text-gray-100" ] [ text "Bio" ]
            -- , li [ class "mx-4 text-gray-100" ] [ text "Resume" ]
            -- , li [ class "mx-4 text-gray-100" ] [ text "Projects" ]
            -- , li [ class "mx-4 text-gray-100" ] [ text "Blog" ]
            ]
        , div
            [ class "container mx-auto my-4 py-4 flex justify-center" ]
            [ img [ src "./headshot.jpg", class "mr-4 h-40 rounded shadow-lg" ] []
            , div [ class "flex flex-col items-start justify-center" ]
                [ h1 [ class "font-display text-3xl mb-2" ] [ text "Andrew Cline" ]
                , h3 [ class "font-body font-bold text-xl" ] [ text "Software Developer" ]
                , h3 [ class "font-body text-lg mb-2" ] [ text "Peoria, IL" ]
                ]
            ]
        , div [ class "container mx-auto flex items-center justify-center" ]
            [ a [ class "mx-2", href "https://github.com/theAndrewCline" ]
                [ button [ class "bg-black rounded shadow-lg text-gray-100 p-2 font-body w-20" ] [ text "Github" ]
                ]
            , a [ class "mx-2", href "https://github.com/theAndrewCline" ]
                [ button [ class "bg-blue-600 rounded shadow-lg text-gray-100 p-2 font-body w-20" ] [ text "Linkedin" ]
                ]
            , a [ class "mx-2", href "https://github.com/theAndrewCline" ]
                [ button [ class "bg-red-600 rounded shadow-lg text-gray-100 p-2 font-body w-20" ] [ text "Resume" ]
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
