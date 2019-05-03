module Main exposing (Model, Msg(..), init, main, update, view)

import Array
import Browser
import Html exposing (Html, button, div, form, h1, img, input, li, text, ul)
import Html.Attributes exposing (checked, class, placeholder, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)



---- MODEL ----


type alias Todo =
    { description : String
    , completed : Bool
    }


type alias TodoList =
    List Todo


type alias Model =
    { todos : TodoList, pendingTodo : String }


initialModel : Model
initialModel =
    { todos = [], pendingTodo = "" }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | AddTodo
    | ToggleCompletedState Todo
    | UpdatePendingTodo String


toTodo : String -> Todo
toTodo content =
    { description = content, completed = False }


toggleCompletedState : Todo -> TodoList -> TodoList
toggleCompletedState todo todos =
    List.map
        (\t ->
            if t.description == todo.description then
                { t | completed = not t.completed }

            else
                t
        )
        todos


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        AddTodo ->
            ( { model | todos = toTodo model.pendingTodo :: model.todos, pendingTodo = "" }
            , Cmd.none
            )

        UpdatePendingTodo content ->
            ( { model | pendingTodo = content }
            , Cmd.none
            )

        ToggleCompletedState todo ->
            ( { model | todos = toggleCompletedState todo model.todos }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "flex-grid" ]
        [ div [ class "col" ] []
        , div [ class "col" ]
            [ h1 [] [ text "Todos" ]
            , form [ onSubmit AddTodo ]
                [ input
                    [ value model.pendingTodo
                    , placeholder "Enter new Todo here ..."
                    , onInput UpdatePendingTodo
                    ]
                    []
                ]
            , ul [] <| List.map todoView model.todos
            ]
        , div [ class "col" ] []
        ]


todoView : Todo -> Html Msg
todoView todo =
    li
        []
        [ input
            [ type_ "checkbox"
            , checked <| todo.completed
            , onClick (ToggleCompletedState todo)
            ]
            []
        , text todo.description
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
