module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, img, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



---- MODEL ----


type alias Model =
    { content : String
    }


init : ( Model, Cmd Msg )
init =
    ( { content = "" }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | ReverseString String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ReverseString string ->
            ( { model | content = string }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working on this rainy morning in Boston!" ]
        , input [ placeholder "Enter text to reverse", value model.content, onInput ReverseString ] []
        , div [] [ text (String.reverse model.content) ]
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
