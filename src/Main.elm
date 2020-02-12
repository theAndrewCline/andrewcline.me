module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, h3, img, text)
import Html.Attributes exposing (class, src)



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
    div []
        [ h1 [ class "cursive" ] [ text "Andrew Cline" ]
        , img [ src "./headshot.jpg" ] []
        , h3 [ class "serif" ] [ text "Software Developer" ]
        , h3 [ class "serif" ] [ text "Peoria, IL" ]
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
