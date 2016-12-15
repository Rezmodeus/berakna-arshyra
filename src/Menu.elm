module Menu exposing (..)

import Html exposing (Html, div, text, a, button)
import Html.Attributes exposing (class, id)
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
        a
            [ onClick (SetValue ( str, val )) ]
            [ text str ]


menu : Model -> Html Msg
menu model =
    let
        cls =
            if model.open then
                "dropdown-content show"
            else
                "dropdown-content"
    in
        div [ class "dropdown" ]
            [ button
                [ class "dropbtn"
                , onClick Toggle
                ]
                [ Tuple.first model.selected |> text ]
            , div
                [ id "myDropdown"
                , class cls
                ]
                (List.map menuItem model.items)
            ]


{--}
