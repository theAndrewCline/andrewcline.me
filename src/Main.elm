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
                    [ text "Hi, I am Andrew, I live in Peoria Illinois with my wife, Kristin, and our two dogs. My hobbies include making excellent coffee, hiking with my dogs, playing guitar, and of course writing code. I typicially spend my weekends helping my church with various technical or musical needs, learning something new, or spending time with my loved ones. I love that, as a fullstack software developer, I get to create unique experiances and solve problems for people every day." ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "I am excited to get to know you" ]
                ]
            ]
        , div [ class "container mx-auto flex justify-start rounded px-12 py-8" ]
            [ div [ class "flex flex-col items-start justify-center" ]
                [ div [ class "flex flex-col bold mx-auto md:m-2  justify-center items-center md:flex-row items-end " ]
                    [ h1
                        [ class "font-display text-5xl mb-2 " ]
                        [ text "Currently Working On" ]
                    ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "Currently, most of the projects I am working on are related to creating and deploying frontend applications for Enterprise IOT solutions. I spend most of my time in Vim (my prefered code editor) writting JavaScript or TypeScript using libraries like Vue, React, or Angular. Some of the features I have helped develop include real time diagnostic dashboards, live interactive maps, and various services to aggrigate data." ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "Some of the applications my team has created at my current job are deployed on small touch screen displays running a custom distibution of Linux. This has given me a great handle on working with command line tools such as ssh, scp, and grep. Our frontend applications are usually either deployed on Node or C++ web servers." ]
                ]
            ]
        , div [ class "container mx-auto flex justify-start rounded px-12 py-8" ]
            [ div [ class "flex flex-col items-start justify-center" ]
                [ div [ class "flex flex-col bold mx-auto md:m-2  justify-center items-center md:flex-row items-end " ]
                    [ h1
                        [ class "font-display text-5xl mb-2 " ]
                        [ text "Self Taught?" ]
                    ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "Yep, I am self taught, while I did have friends and the internet to help teach me, I did not finish collage. This was a very intetional choice though, when I switched my major to web design at my community collage I found myself watching videos that I could access without paying for collage. I started to feel like I was not benefiting from my collage experance. I decided the best thing for me to do was find a job and learn programming in my free time." ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "4 years later, I think it was the best choice I could have made. I have no school debt and I have cultivated an attitude of life long learning and self motivation. I currently have 2 years of on the job development experiance. I have been put in many situations where the only person available to solve a hard issue was me. Using my ability to learn on my own, I learned new technical skills and provided solutions to these hard issues. I think the disipline and self motivation skills I learned though teaching myself have made me a better developer." ]
                ]
            ]
        , div [ class "container mx-auto flex justify-start rounded px-12 py-8" ]
            [ div [ class "flex flex-col items-start justify-center" ]
                [ div [ class "flex flex-col bold mx-auto md:m-2  justify-center items-center md:flex-row items-end " ]
                    [ h1
                        [ class "font-display text-5xl mb-2 " ]
                        [ text "Currently Hacking On" ]
                    ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "I got introducted to functional programing through the React and RxJS libraries. I later heard about Elm and really fell in love. For those who do not know, Elm is pure functional programming language for building web applications. Elm boasts of near zero runtime exceptions, all with in a nice ML style syntax and simple standard library. In fact, this website is an Elm app." ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "From there I got more interested in doing backend programming. I wanted to find a good complement to Elm on the backend so I could do more outside of the browser. In my quest to find another programing language for the backend (aside from NodeJS) I tried out Rust, Go, Haskell, and a few others. I am going to continue learning Rust and Go as they both have features that I really enjoy and seem to have exciting futures." ]
                ]
            ]
        , div
            [ class "container mx-auto flex flex-col justify-start rounded px-12 py-8 bg-gray-100" ]
            [ h1 [ class "font-display text-5xl mb-2 " ] [ text "Key Skills" ]
            , ul [ class "list-disc" ]
                [ li [ class "font-body text-xl mb-4" ] [ text "Languages - JavaScript, Elm, Go, Rust" ]
                , li [ class "font-body text-xl mb-4" ] [ text "JS Frameworks - React.js, Vue.js Angular" ]
                , li [ class "font-body text-xl mb-4" ] [ text "Graphic Design - Photoshop, InDesign" ]
                , li [ class "font-body text-xl mb-4" ] [ text "SW Workflow - Git, vim, Azure DevOps, AWS, Google Cloud Platform, Netlify" ]
                , li [ class "font-body text-xl mb-4" ] [ text "Testing - TDD, Mocha, Jest, Cypress" ]
                , li [ class "font-body text-xl mb-4" ] [ text "Server - Node.js, Express.js, MongoDB, SQLite, REST API, Postgres" ]
                , li [ class "font-body text-xl mb-4" ] [ text "Office Applications - Word, Powerpoint, Excel" ]
                ]
            ]
        ]
