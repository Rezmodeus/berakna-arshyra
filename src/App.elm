module App exposing (..)

import Html exposing (Html, text, div, button, p, h2)
import Menu exposing (..)
import Input exposing (..)
import Constants exposing (..)


{-
   Årshyra ska beräknas
   Lägenhetsyta - input
   Lägenhetspoäng - meny
   Konstant 121
   (Årshyra * konstant)/(Lägenhetspoäng*Lägenhetsyta) = Normhyra
   Normhyra per kvm boarea och år - region - meny
   1450 - stockholm
   1350 - gbg malmö
   1300 - resten

   formel
   Årshyra = (Normhyra*Lägenhetspoäng*Lägenhetsyta)/konstant
-}


calculate : Model -> Model
calculate model =
    let
        yta =
            model.yta.value

        lagenhet =
            Tuple.second model.lagenhet.selected

        region =
            Tuple.second model.region.selected

        test =
            yta > 0

        arsHyra =
            if test then
                "Årshyran är:" ++ toString (round ((region * lagenhet * yta) / 121))
            else
                defaultText
    in
        { model | arsHyraText = arsHyra }


defaultText : String
defaultText =
    "Fyll i alla värden"


type alias Model =
    { message : String
    , lagenhet : Menu.Model
    , region : Menu.Model
    , yta : Input.Model
    , arsHyraText : String
    }


init : ( Model, Cmd Msg )
init =
    ( { message = "Your Elm App is working!"
      , lagenhet = Menu.init Constants.lagenhetstyper
      , region = Menu.init Constants.region
      , yta = Input.init "ange yta i kvm"
      , arsHyraText = defaultText
      }
    , Cmd.none
    )


type Msg
    = Lagenheter Menu.Msg
    | Region Menu.Msg
    | Yta Input.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        newModel =
            calculate <|
                case msg of
                    Lagenheter msg ->
                        { model | lagenhet = Menu.update msg model.lagenhet }

                    Region msg ->
                        { model | region = Menu.update msg model.region }

                    Yta msg ->
                        { model | yta = Input.update msg model.yta }
    in
        ( newModel, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.arsHyraText ]
        , Html.map Yta (Input.input model.yta)
        , Html.map Lagenheter (Menu.menu model.lagenhet)
        , Html.map Region (Menu.menu model.region)
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
