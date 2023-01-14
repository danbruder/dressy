module Layout exposing (build)

import Css
import Css.Global
import Html.Styled as Html
import Html.Styled.Attributes as Attr
import Tailwind.Breakpoints as Breakpoints
import Tailwind.Utilities as Tw


build content =
    Html.div
        []
        [ Css.Global.global Tw.globalStyles
        , content
        ]
