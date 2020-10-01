module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, h1, h2, h3, img, li, p, span, text, ul)
import Html.Attributes exposing (class, href, src)
import Route exposing (Route(..), toRoute)
import Url



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }



---- MODEL ----


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )



---- SUBS ----


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = titleForRoute model.url
    , body =
        [ div
            [ class "min-h-screen flex flex-col align-center" ]
            [ navBar, router model ]
        ]
    }


navBar : Html msg
navBar =
    ul [ class "flex m-8 font-body font-bold" ]
        [ li [ class "mr-auto flex justify-center items-center h-100" ]
            [ h1
                [ class "pr-4 bold text-2xl font-display ", href "/" ]
                [ text "Andrew Cline" ]
            , span [ class "items-center hidden md:flex" ]
                [ h2
                    [ class "pl-4 text-md bold mr-1 self-center border-l border-solid border-gray-400" ]
                    [ text "Software Developer" ]
                , h2
                    [ class "text-sm mr-1 self-center" ]
                    [ text " - Peoria, IL" ]
                ]
            ]

        -- , li [ class "mx-4 text-gray-600 font-display" ] [ text "Bio" ]
        -- , li [ class "mx-4 text-gray-600 font-display" ] [ text "Resume" ]
        -- , li [ class "mx-4 text-gray-600 font-dispaly" ] [ text "Projects" ]
        ]


titleForRoute : Url.Url -> String
titleForRoute url =
    case toRoute url of
        Home ->
            "Andrew Cline"


router : Model -> Html Msg
router model =
    case toRoute model.url of
        Home ->
            homeView



-- GITHUB BUTTON
-- , div [ class "container mx-auto flex items-center justify-center" ]
--     [ a [ class "mx-2", href "https://github.com/theAndrewCline" ]
--         [ button [ class "bg-black rounded shadow-lg text-gray-100 p-2 font-body w-32" ] [ text "Github" ]
--         ]
--      ]


homeView : Html msg
homeView =
    div []
        [ div
            [ class "container mx-auto flex justify-start bg-gray-100 rounded px-12 py-8" ]
            [ div [ class "flex flex-col items-start justify-center" ]
                [ div [ class "flex flex-col bold mx-auto md:m-2 md:mb-8 justify-center items-center md:flex-row items-end " ]
                    [ img [ src "./headshot.jpg", class "rounded-full mb-4 md:mr-8" ] []
                    , h1
                        [ class "font-display text-5xl md:text-6xl mb-2 " ]
                        [ text "Hello, World!" ]
                    ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "I am a creative, self-motivated, servant leader. As a developer, I use modern technologies and best common practices to create performant web applications." ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "I am excited to get to know you" ]
                ]
            ]
        ]
