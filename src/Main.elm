module Main exposing (Model, Msg(..), init, main, update, view)

import Array
import Browser
import Browser.Navigation
import Html exposing (Html, button, div, form, h1, header, img, input, li, text, ul)
import Html.Attributes exposing (checked, class, placeholder, src, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)
import Url exposing (Url)



---- PROGRAM ----



type alias Images =
    { actionOkIcon : String
    , actionCancelIcon : String
    , appBabelfishIcon : String
    , wetPinkTulipSmall : String
    }



main : Program Images Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = ChangedUrl
        }


init : Images -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init images url key =
    ( initialModel images url key, Cmd.none )



---- MODEL ----

type TodoStatus
    = Incomplete
    | Completed


type alias Todo =
    { description : String
    , status : TodoStatus
    }


type alias TodoList =
    List Todo


type alias Model =
    { todos : TodoList
    , pendingTodo : String
    , url : Url.Url
    , key : Browser.Navigation.Key
    , img : Images
    }


initialModel : Images -> Url.Url -> Browser.Navigation.Key -> Model
initialModel images url key =
    { todos =
        [ { description = "First todo", status = Incomplete }
        , { description = "Second todo", status = Completed }
        ]
    , pendingTodo = ""
    , url = url
    , key = key
    , img = images
    }


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none



---- UPDATE ----


type Msg
    = NoOp
    | AddTodo
    | ToggleCompletedState Todo
    | UpdatePendingTodo String
    | ClickedLink Browser.UrlRequest
    | ChangedUrl Url.Url


toTodo : String -> Todo
toTodo content =
    { description = content, status = Incomplete }


toggleTodoStatus : TodoStatus -> TodoStatus
toggleTodoStatus status =
    case status of
        Completed ->
            Incomplete

        Incomplete ->
            Completed


toggleCompletedState : Todo -> TodoList -> TodoList
toggleCompletedState todo todos =
    List.map
        (\t ->
            if t.description == todo.description then
                { t | status = toggleTodoStatus todo.status }

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

        ClickedLink urlRequest ->
            ( model
            , Cmd.none
            )

        ChangedUrl url ->
            ( model
            , Cmd.none
            )




---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "Simple Todos"
    , body =
        [ div [ class "flex-grid" ]
            [ div [ class "upper-left" ]
                [ img [ src model.img.actionOkIcon ] []
                ]
            , div [ class "upper-right" ]
                [ img [ src model.img.actionCancelIcon ] []
                ]
            , div [ class "lower-left" ]
                [ img [ src model.img.appBabelfishIcon ] []
                ]
            , div [ class "lower-right" ]
                [ img [ src model.img.wetPinkTulipSmall ] []
                ]

            , div [ class "col" ] []
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
                , todoListView Incomplete "Incomplete" model.todos
                , todoListView Completed "Completed" model.todos
                ]
            , div [ class "col" ] []
            ]
        ]
    }


todoListView : TodoStatus -> String -> TodoList -> Html Msg
todoListView status statusName todolist =
    let
        filteredList =
            List.filter (\t -> t.status == status) todolist
    in
    if List.length filteredList == 0 then
        div [] []

    else
        div []
            [ header [] [ text statusName ]
            , ul [] <| List.map todoView <| filteredList
            ]


todoView : Todo -> Html Msg
todoView todo =
    li
        []
        [ input
            [ type_ "checkbox"
            , checked <| todo.status == Completed
            , onClick (ToggleCompletedState todo)
            ]
            []
        , text todo.description
        ]
