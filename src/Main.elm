module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, h1, h3, img, li, text, ul)
import Html.Attributes exposing (class, href, src)
import Url
import Url.Parser exposing (Parser, (</>), int, map, oneOf, s, string)



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
init flags url key =
    ( Model key url, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
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

   NoOp ->
      ( model, Cmd.none )



---- SUBS ----


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "Andrew Cline"
    , body =
        [ div [ class "min-h-screen flex flex-col align-center bg-gray-100" ]
            [ ul [ class "flex bg-black py-4 font-body font-bold" ]
                [ li [ class "mx-4 text-gray-100 bold mr-auto font-display" ] [ text "Andrew Cline" ]

                -- DISABLED MENU OPTIONS UNTIL PAGES ARE CREATED
                -- , li [ class "mx-4 text-gray-100" ] [ text "Bio" ]
                -- , li [ class "mx-4 text-gray-100" ] [ text "Resume" ]
                -- , li [ class "mx-4 text-gray-100" ] [ text "Projects" ]
                , li [] [
                    a [ class "mx-4 text-gray-100", href "/posts"] [ text "Posts" ]
                    ]
                ]
                , routeView model
            ]
        ]
    }

routeView : Model -> Html msg
routeView model =
    case Url.toString model.url of
        "posts" ->
            postView

        _ -> 
            homeView



homeView : Html msg
homeView =
    div [] [
        div
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
                [ button [ class "bg-black rounded shadow-lg text-gray-100 p-2 font-body w-32" ] [ text "Github" ]
                ]

            -- Disabled temporarily
            -- , a [ class "mx-2", href "https://github.com/theAndrewCline" ]
            --     [ button [ class "bg-blue-600 rounded shadow-lg text-gray-100 p-2 font-body w-20" ] [ text "Linkedin" ]
            --     ]
            -- , a [ class "mx-2", href "https://github.com/theAndrewCline" ]
            --     [ button [ class "bg-red-600 rounded shadow-lg text-gray-100 p-2 font-body w-20" ] [ text "Resume" ]
            --     ]
            ]
    ] 

postView : Html msg
postView =
    div [] [ text "Posts" ]

-- ROUTE PARSER

type Route
  = Home
  | Posts

routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ map    (s "topic" </> string)
    , map Blog    (s "blog" </> int)
    ]