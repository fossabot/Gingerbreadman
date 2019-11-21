module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Url.Builder
import Json.Decode as D exposing (Decoder)

import SidePanel
import Controller
import Data exposing (..)


-- MAIN

main : Program () Model Msg
main =
    Browser.element 
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


-- MODEL

init : () -> (Model, Cmd Msg)
init _ =
    (
        -- Initialize model
        { controller =
            { fromTimeString = "1900-01-01T00:00"
            , toTimeString  = "2100-12-31T00:00"
            , places = Nothing
            }
        , allPlaces = Nothing
        , people = Nothing}
    
    -- Command to get all places
    , Http.get
        { url = (Url.Builder.absolute ["visualizer", "get_places_all"] [])
        , expect = Http.expectJson GotAllPlaces allPlaceDecoder
        }
    )




-- UDPATE

type Msg
    = SidePanelMsg SidePanel.Msg
    | GotAllPlaces (Result Http.Error (List Place))


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SidePanelMsg subMsg ->
            let 
                (model_, cmd) =
                    SidePanel.update subMsg model
            in
                (model_, Cmd.map SidePanelMsg cmd)
        GotAllPlaces result ->
            (setAllPlaces model result, Cmd.none)


-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "row" ]
            [ div [ class "col-7" ]
                [ h1 []
                    [ text "Map" ]
                ]
            , div [ class "col-5" ]
                [ Html.map SidePanelMsg (SidePanel.view model) ]
            ]
        ]
