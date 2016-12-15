module Input exposing (..)

import Html exposing (input, Html, span, text, div, br)
import Html.Events exposing (onInput)
import Html.Attributes exposing (placeholder, class, value)


type alias Model =
    { text : String
    , value : Float
    , errText : String
    , errCls : String
    , caption : String
    }


type Msg
    = Change String


validate : Model -> Model
validate model =
    let
        val =
            Result.withDefault 0 (String.toFloat model.text)

        hasErr =
            val <= 0 && model.text /= ""

        errText =
            if hasErr then
                "Skriv en siffra större än 0"
            else
                ""

        errCls =
            if hasErr then
                "err-span"
            else
                ""
    in
        { model
            | value = val
            , errText = errText
            , errCls = errCls
        }


init : String -> Model
init caption =
    Model "" 0.0 "" "" caption


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change s ->
            { model | text = s }
                |> validate


input : Model -> Html Msg
input model =
    div [ class "input-block" ]
        [ span [] [ text <| model.caption ++ ":" ]
        , br [] []
        , Html.input
            [ placeholder "Text here"
            , onInput Change
            , value model.text
            ]
            []
        , br [] []
        , span [ class model.errCls ] [ text model.errText ]
        ]
