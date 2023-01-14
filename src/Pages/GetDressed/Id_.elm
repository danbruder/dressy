module Pages.GetDressed.Id_ exposing (Model, Msg, page)

import Browser
import Browser.Events exposing (onAnimationFrameDelta)
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Canvas.Settings.Text exposing (..)
import Canvas.Texture as Texture exposing (Texture)
import Color exposing (Color)
import Gen.Params.GetDressed.Id_ exposing (Params)
import Html.Styled as Html exposing (div, img)
import Html.Styled.Attributes as Attr exposing (css, src)
import Layout
import Page
import Request
import Shared
import Tailwind.Utilities as Tw
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
    { frame : Float
    , sprites : List Texture
    }


init : ( Model, Cmd Msg )
init =
    ( { frame = 0, sprites = [] }, Cmd.none )



-- UPDATE


type Msg
    = TextureLoaded (Maybe Texture)
    | AnimationFrame Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AnimationFrame delta ->
            ( { model | frame = model.frame + delta / 10 }
            , Cmd.none
            )

        TextureLoaded Nothing ->
            ( model
            , Cmd.none
            )

        TextureLoaded (Just texture) ->
            ( { model | sprites = texture :: model.sprites }
            , Cmd.none
            )


spriteSheetCellSize =
    64


spriteSheetCellSpace =
    10


type Load a
    = Loading
    | Success a
    | Failure



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
        [ css
            [ Tw.flex
            , Tw.justify_center
            , Tw.items_center
            , Tw.h_screen
            , Tw.w_full
            ]
        ]
        [ div
            [ css
                [ Tw.flex
                , Tw.justify_center
                , Tw.items_center
                , Tw.h_screen
                , Tw.w_full
                , Tw.bg_purple_200
                ]
            ]
            [ viewLeft model ]
        , div
            [ css
                [ Tw.flex
                , Tw.justify_center
                , Tw.h_screen
                , Tw.bg_indigo_100
                , Tw.overflow_y_scroll
                , Tw.px_12
                ]
            ]
            [ viewRight model ]
        ]


viewLeft model =
    Html.fromUnstyled <|
        Canvas.toHtmlWith
            { width = w
            , height = h
            , textures = textures
            }
            []
            (shapes [ fill (Color.rgb 0.85 0.92 1) ]
                [ rect ( 0, 0 ) w h ]
                :: (case model.sprites of
                        [] ->
                            [ renderText "Loading sprite sheet" ]

                        ss ->
                            renderSprites model.frame ss
                   )
            )


renderText : String -> Renderable
renderText txt =
    text
        [ font { size = 48, family = "sans-serif" }
        , align Center
        , maxWidth w
        ]
        ( w / 2, h / 2 - 24 )
        txt


w =
    400


h =
    800


viewRight model =
    clothes
        |> List.map (\item -> img [ src ("/" ++ item ++ ".png") ] [])
        |> List.map (\item -> div [ css [] ] [ item ])
        |> div [ css [ Tw.w_40 ] ]


clothes =
    [ "girl-skirt"
    , "girl-hair-pony"
    , "girl-dress-green"
    , "boy-hair"
    , "boy-hair-beard"
    , "boy-jeans"
    , "girl-hair"
    ]


textures : List (Texture.Source Msg)
textures =
    clothes |> List.map (\i -> Texture.loadFromImageUrl ("/" ++ i ++ ".png") TextureLoaded)


numOfPlayers =
    5


renderSprites : Float -> List Texture -> List Renderable
renderSprites frame sprites =
    let
        renderPlayer sprite =
            let
                dimensions =
                    Texture.dimensions sprite

                x =
                    0

                y =
                    0
            in
            texture
                [ transform [ Scale 0.2 0.2 ]
                ]
                ( x, y )
                sprite

        players =
            sprites
                |> List.map renderPlayer
    in
    players
