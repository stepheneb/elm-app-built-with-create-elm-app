module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, img, input, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



---- MODEL ----


type alias Todo =
    String


type alias Model =
    { todos : List Todo }


initialModel : Model
initialModel =
    { todos = [ "hello", "world" ] }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Todos" ]
        , ul [] <| List.map todoView model.todos
        ]


todoView : String -> Html Msg
todoView string =
    li [] [ text string ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
