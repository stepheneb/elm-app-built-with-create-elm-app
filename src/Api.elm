module Api exposing (Flags, Images, Todo, TodoList, TodoStatus(..), application)

import Browser
import Browser.Navigation
import Json.Decode as D exposing (Value)
import Url exposing (Url)


application :
    { init : Result D.Error Flags -> Url -> Browser.Navigation.Key -> ( model, Cmd msg )
    , view : model -> Browser.Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , onUrlRequest : Browser.UrlRequest -> msg
    , onUrlChange : Url -> msg
    }
    -> Program Value model msg
application config =
    let
        init flags url navKey =
            let
                resultFlags =
                    D.decodeValue flagsDecoder flags
            in
            config.init resultFlags url navKey
    in
    Browser.application
        { init = init
        , onUrlChange = config.onUrlChange
        , onUrlRequest = config.onUrlRequest
        , subscriptions = config.subscriptions
        , update = config.update
        , view = config.view
        }



---- modeling


type alias Todo =
    { description : String
    , status : TodoStatus
    }


type TodoStatus
    = Incomplete
    | Completed


type alias TodoList =
    List Todo


type alias Images =
    { actionOkIcon : String
    , actionCancelIcon : String
    , appBabelfishIcon : String
    , wetPinkTulipSmall : String
    , fivePointedStar : String
    }



---- FLAGS DECODING


type alias Flags =
    { todos : TodoList
    , images : Images
    }


fromResult : Result String a -> D.Decoder a
fromResult result =
    case result of
        Ok a ->
            D.succeed a

        Err errorMessage ->
            D.fail errorMessage


parseTodoStatus : String -> Result String TodoStatus
parseTodoStatus string =
    case string of
        "Incomplete" ->
            Ok Incomplete

        "Completed" ->
            Ok Completed

        _ ->
            Err ("Invalid status: " ++ string)


todoStatusDecoder : D.Decoder TodoStatus
todoStatusDecoder =
    D.field "status" D.string |> D.andThen (fromResult << parseTodoStatus)


todoDescriptionDecoder : D.Decoder String
todoDescriptionDecoder =
    D.field "description" D.string


todoDecoder : D.Decoder Todo
todoDecoder =
    D.map2 Todo
        todoDescriptionDecoder
        todoStatusDecoder


todoListDecoder : D.Decoder TodoList
todoListDecoder =
    D.list todoDecoder


imagesDecoder : D.Decoder Images
imagesDecoder =
    D.map5 Images
        (D.field "actionOkIcon" D.string)
        (D.field "actionCancelIcon" D.string)
        (D.field "appBabelfishIcon" D.string)
        (D.field "wetPinkTulipSmall" D.string)
        (D.field "fivePointedStar" D.string)


flagsDecoder : D.Decoder Flags
flagsDecoder =
    D.map2 Flags
        (D.field "todos" todoListDecoder)
        (D.field "images" imagesDecoder)
