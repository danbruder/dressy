module Pages.Home_ exposing (view)

import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr exposing (..)
import Layout
import Tailwind.Breakpoints as Breakpoints
import Tailwind.Utilities as Tw exposing (..)
import View exposing (View)


view : View msg
view =
    { title = "Homepage"
    , body =
        [ Html.toUnstyled <|
            Layout.build viewContent
        ]
    }


viewContent =
    div
        [ css
            [ flex
            , justify_center
            , items_center
            , h_screen
            , w_full
            ]
        ]
        [ a
            [ href "/get-dressed/adelynn"
            , css
                [ Tw.bg_purple_600
                , text_purple_100
                , py_3
                , px_4
                , rounded
                , shadow
                ]
            ]
            [ text "Let's dress Adelynn" ]
        ]
