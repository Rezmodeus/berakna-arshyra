module Menu exposing (..)

import Html exposing (Html, div, text, a, button, span, ul, li)
import Html.Attributes exposing (class, id, attribute)
import Html.Events exposing (onClick)


type alias MenuItem =
    ( String, Float )


type alias Model =
    { open : Bool
    , selected : MenuItem
    , items : List MenuItem
    }


type Msg
    = Toggle
    | SetValue MenuItem


init : List MenuItem -> Model
init entries =
    Model False
        (Maybe.withDefault ( "No menu data available", 0 ) (List.head entries))
        entries


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle ->
            { model | open = not model.open }

        SetValue val ->
            update Toggle { model | selected = val }


menuItem : MenuItem -> Html Msg
menuItem item =
    let
        ( str, val ) =
            item
    in
        li []
            [ a
                [ onClick (SetValue ( str, val )) ]
                [ text str ]
            ]


menu : Model -> Html Msg
menu model =
    let
        buttonGroupCls =
            if model.open then
                "open"
            else
                ""

        expanded =
            model.open
                |> (toString >> String.toLower)
    in
        div [ class <| "btn-group " ++ buttonGroupCls ]
            [ button
                [ class "btn btn-primary dropdown-toggle"
                , attribute "type" "button"
                , attribute "data-toggle" "dropdown"
                , attribute "aria-haspopup" "true"
                , attribute "aria-expanded" expanded
                , onClick Toggle
                ]
                [ text <| (Tuple.first model.selected) ++ "  "
                , span [ class "caret" ] []
                ]
            , ul
                [ class "dropdown-menu"
                ]
                (List.map menuItem model.items)
            ]


{--}
