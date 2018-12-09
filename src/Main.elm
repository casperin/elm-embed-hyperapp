port module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, hr)
import Html.Events exposing (onClick)
import Html.Attributes exposing (id)


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model = Int


type Msg
    = Increment
    | Decrement
    | AttachHyperapp
    | DetachHyperapp


init : () -> (Model, Cmd Msg)
init _ = (0, Cmd.none)


-- Port
port attachHyperapp : String -> Cmd msg
port detachHyperapp : String -> Cmd msg


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increment ->
            (model + 1, Cmd.none)

        Decrement ->
            (model - 1, Cmd.none)

        AttachHyperapp ->
            (model,  attachHyperapp "foo")

        DetachHyperapp ->
            (model,  detachHyperapp "foo")
    

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model) ]
    , button [ onClick Increment ] [ text "+" ]
    , hr [] []
    , button [ onClick AttachHyperapp ] [ text "attach" ]
    , button [ onClick DetachHyperapp ] [ text "detach" ]
    , hr [] []
    , div [ id "foo" ] []
    ]


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
