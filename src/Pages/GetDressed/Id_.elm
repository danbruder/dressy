module Pages.GetDressed.Id_ exposing (Model, Msg, page)

import Gen.Params.GetDressed.Id_ exposing (Params)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr exposing (..)
import Layout
import Page
import Request
import Shared
import Tailwind.Utilities as Tw exposing (..)
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Get Dressed!"
    , body =
        [ Html.toUnstyled <|
            Layout.build (viewBody model)
        ]
    }


viewBody model =
    div
        [ css [ flex, justify_center, items_center, h_screen, w_full ] ]
        [ div [ css [ flex, justify_center, items_center, h_screen, w_full, bg_purple_200 ] ]
            [ viewLeft model ]
        , div
            [ css [ flex, justify_center, items_center, h_screen, w_full, bg_indigo_100 ]
            ]
            [ viewRight model ]
        ]


viewLeft model =
    div []
        [ img [ src "/person.png" ] []
        ]


viewRight model =
    div [] [ text "Right" ]
