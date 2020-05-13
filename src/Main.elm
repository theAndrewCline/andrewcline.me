module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import CmsInfo exposing (CmsInfo, Post, cmsDecoder)
import Html exposing (Html, a, button, div, h1, h3, hr, img, input, li, text, ul)
import Html.Attributes exposing (class, href, placeholder, src)
import Html.Events exposing (onInput)
import Http
import Markdown
import Route exposing (Route(..), cleanPostTitle, toRoute)
import Simple.Fuzzy as Fuzzy
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
    , posts : List Post
    , postSearchKey : String
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url [] ""
    , getPosts
    )



---- UPDATE ----


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotCmsInfo (Result Http.Error CmsInfo)
    | UpdatePostSearchKey String


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

        GotCmsInfo result ->
            case result of
                Ok json ->
                    ( { model | posts = json.posts }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        UpdatePostSearchKey newKey ->
            ( { model | postSearchKey = newKey }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



---- SUBS ----


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = titleForRoute model.url
    , body = [ div [ class "min-h-screen flex flex-col align-center bg-gray-100" ] [ navBar, router model ] ]
    }


navBar : Html msg
navBar =
    ul [ class "flex bg-black py-4 font-body font-bold" ]
        [ li [ class "mr-auto" ]
            [ a [ class "mx-4 text-gray-100 bold font-display", href "/" ] [ text "Andrew Cline" ]
            ]

        -- DISABLED MENU OPTIONS UNTIL PAGES ARE CREATED
        -- , li [ class "mx-4 text-gray-100" ] [ text "Bio" ]
        -- , li [ class "mx-4 text-gray-100" ] [ text "Resume" ]
        -- , li [ class "mx-4 text-gray-100" ] [ text "Projects" ]
        , li []
            [ a [ class "mx-4 text-gray-100", href "/posts" ] [ text "Posts" ]
            ]
        ]


titleForRoute : Url.Url -> String
titleForRoute url =
    case toRoute url of
        Home ->
            "Andrew Cline"

        Posts ->
            "Posts | Andrew Cline"

        PostRoute title ->
            title ++ " | Andrew Cline"


router : Model -> Html Msg
router model =
    case toRoute model.url of
        Home ->
            homeView

        Posts ->
            postListView model.posts model.postSearchKey

        PostRoute title ->
            postRouteView title model


homeView : Html msg
homeView =
    div []
        [ div
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


findPostByTitle : String -> List Post -> Maybe Post
findPostByTitle title posts =
    List.head <| List.filter (\post -> title == cleanPostTitle post.title) posts


postRouteView : String -> Model -> Html msg
postRouteView title model =
    let
        postToView =
            findPostByTitle title model.posts
    in
    case postToView of
        Just post ->
            div
                [ class "flex flex-col items-center justify-center" ]
                [ h1 [ class "text-2xl font-bold mt-4" ] [ text post.title ]
                , h3 [ class "italic" ] [ text post.description ]
                , Markdown.toHtml [ class "mt-4" ] post.body
                ]

        Nothing ->
            div [] [ text "post not found" ]


postListView : List Post -> String -> Html Msg
postListView posts searchTerm =
    if List.isEmpty posts then
        div [ class "flex flex-col items-center justify-center" ] [ text "Posts coming soon!" ]

    else
        div []
            [ div []
                [ input [ class "m-4 px-2 h-8 border-solid border-grey-500 border-2 rounded", placeholder "Search Posts", onInput UpdatePostSearchKey ]
                    []
                ]
            , hr [ class "mx-4" ] []
            , div
                [ class "flex flex-col items-center justify-center" ]
                (List.map
                    postListItem
                    (Fuzzy.filter
                        .title
                        searchTerm
                        posts
                    )
                )
            ]


postListItem : Post -> Html msg
postListItem post =
    a [ href ("/posts/" ++ cleanPostTitle post.title) ]
        [ div [ class "mt-4" ]
            [ h1 [ class "text-2xl font-bold" ] [ text post.title ]
            , h3 [] [ text post.description ]
            , hr [ class "mt-4" ] []
            ]
        ]



-- HTTP


getPosts : Cmd Msg
getPosts =
    Http.get
        { url = "./cms.json"
        , expect = Http.expectJson GotCmsInfo cmsDecoder
        }
