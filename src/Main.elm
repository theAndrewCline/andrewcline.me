module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, button, div, form, h1, h2, img, input, label, li, p, span, text, ul)
import Html.Attributes exposing (action, attribute, class, href, method, name, src, type_, value)
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

        Contact ->
            "Contact | Andrew Cline"


router : Model -> Html Msg
router model =
    case toRoute model.url of
        Home ->
            homeView

        Contact ->
            contactView


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
                    [ text "Hi, I am Andrew, I live in Peoria Illinois with my wife, Kristin, and our two dogs. My hobbies include making excellent coffee, hiking with my dogs, playing guitar, and of course writing code. I typically spend my weekends helping my church with various technical or musical needs, learning something new, or spending time with my loved ones. I love that, as a full-stack software developer, I get to create unique experiences and solve problems for people every day." ]
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
                        [ text "Who Am I" ]
                    ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "If you are into personality tests, I am an enneagram type nine and an ENFJ. I would say that my best qualities are adaptability, loyalty, and commitment to doing things right. I love working in teams to accomplish a clear goal. I enjoy learning and teaching others. I believe that dignity and respect are the inherent rights of all humans. I believe that by listening to one another and working together, we can solve the world's toughest issues. Obviously, I am a glass-half-full kind of guy." ]
                ]
            ]
        , div [ class "container mx-auto flex justify-start rounded px-12 py-8" ]
            [ div [ class "flex flex-col items-start justify-center" ]
                [ div [ class "flex flex-col bold mx-auto md:m-2  justify-center items-center md:flex-row items-end " ]
                    [ h1
                        [ class "font-display text-5xl mb-2 " ]
                        [ text "How I Work" ]
                    ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "I like to work in teams, being able to interact with a dynamic team with clear objectives is very motivating for me. I like receiving consistent feedback and having clear goals. I always want to improve, whether that be technical or interpersonal skills, I want to keep growing." ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "As far as project management, I am not picky. I think what is important is creating a backlog of what is truly important to the end-users, releasing it to them quickly, and receiving quality feedback from them. I like Facebook's idea of personal responsibility, \"If you see something wrong, it's your job to fix it.\"" ]
                ]
            ]
        , div [ class "container mx-auto flex justify-start rounded px-12 py-8 bg-gray-100" ]
            [ div [ class "flex flex-col items-start justify-center" ]
                [ div [ class "flex flex-col bold mx-auto md:m-2  justify-center items-center md:flex-row items-end " ]
                    [ h1
                        [ class "font-display text-5xl mb-2 " ]
                        [ text "Things I Am Good At" ]
                    ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "Most of my tech career has been spent writing JavaScript. My Favorite JavaScript Tools are currently Vue, React, Jest, Cypress, and RxJS, but I would be comfortable in any JavaScript Framework. I also enjoy writting in Elm. On the backend, I use Node and Express, I also have experience with SQLite and MongoDB." ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "I have recently been expanding my skills to include other languages, including Rust, Go, and Haskell. I can make a basic web service in any of these languages. I am also good at learning, so I can pick anything up quickly." ]
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
                    [ text "Currently, most of the projects I am working on are related to creating and deploying front-end applications for Enterprise IoT solutions. I spend most of my time in Vim (my preferred code editor) writing JavaScript or TypeScript using libraries like Vue, React, or Angular. Some of the features I have helped develop include real-time diagnostic dashboards, live interactive maps, and various services to aggregate data." ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "Some of the applications my team has created at my current job are deployed on small touch screen displays running a custom distribution of Linux. This has given me a great handle on working with command-line tools such as ssh, scp, and grep. Our frontend applications are usually either deployed on Node or C++ web servers." ]
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
                    [ text "Yep, I am self-taught, while I did have friends and the internet to help teach me, I did not finish college. This was a very intentional choice though, when I switched my major to web design at my community college I found myself watching videos that I could access without paying for college. I started to feel like I was not benefiting from my college experience. I decided the best thing for me to do was find a job and learn programming in my free time." ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "Four years later, I think it was the best choice I could have made. I have no school debt and I have cultivated an attitude of lifelong learning and self-motivation. I currently have two years of on the job development experience. I have been in many situations where the only person available to solve a difficult issue was me. Using my ability to learn on my own, I learned new technical skills and provided solutions to these hard issues. I think the discipline and self-motivation skills I learned through teaching myself have made me a better developer." ]
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
                    [ text "I got introduced to functional programming through the React and RxJS libraries. I later heard about Elm and fell in love. For those who do not know, Elm is a pure functional programming language for building web applications. Elm boasts of near-zero runtime exceptions, all within a nice ML style syntax and simple standard library. This website is an Elm app." ]
                , p
                    [ class "font-body text-xl mb-4" ]
                    [ text "From there I got more interested in doing backend programming. I wanted to find a good complement to Elm on the backend so I could do more outside of the browser. In my quest to find another programing language for the backend (aside from NodeJS) I tried out Rust, Go, Haskell, and a few others. I am going to continue learning Rust and Go as they both have features that I enjoy and seem to have exciting futures." ]
                ]
            ]
        ]


contactView : Html msg
contactView =
    div [ class "container mx-auto flex" ]
        [ h1 [ class "text-5xl font-display" ] [ text "Contact" ]
        , form [ name "contact", method "POST", attribute "data-netlify" "true" ]
            [ div []
                [ label [] [ text "Name", input [ type_ "text", name "name" ] [] ]
                ]
            , div []
                [ label [] [ text "Email", input [ type_ "email", name "email" ] [] ]
                ]
            , div []
                [ label [] [ text "Message", input [ type_ "textarea", name "message" ] [] ]
                ]
            , div []
                [ button [ type_ "submit" ] [ text "Submit" ]
                ]
            ]
        ]
