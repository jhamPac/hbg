module Html.Internal where

import           Numeric.Natural

-- * Types

newtype Html = Html String

newtype Structure = Structure String

instance Semigroup Structure where
    (<>) c1 c2 =
        Structure (getStructureString c1 <> getStructureString c2)

instance Monoid Structure where
    mempty = Structure ""

type Title = String

-- * EDSL

html' :: Title -> Structure -> Html
html' title content =
    Html
        ( el "html"
            (el "head" (el "title" $ escape title))
            <> el "body" (getStructureString content)
        )

p' :: String -> Structure
p' = Structure . el "p" . escape

h' :: Natural -> String -> Structure
h' n = Structure . el ("h" <> show n) . escape

ul' :: [Structure] -> Structure
ul' =
    Structure . el "ul" . concatMap (el "li" . getStructureString)

ol' :: [Structure] -> Structure
ol' =
    Structure . el "ol" . concatMap (el "li" . getStructureString)

code' :: String -> Structure
code' = Structure . el "pre"

-- * Render

render :: Html -> String
render html =
    case html of
        Html str -> str

-- * Utils

el :: String -> String -> String
el tag content =
    "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

getStructureString :: Structure -> String
getStructureString content =
    case content of
        Structure str -> str

escape :: String -> String
escape =
    let
        escapeChar c =
            case c of
                '<'  -> "&lt;"
                '>'  -> "&gt;"
                '&'  -> "&amp;"
                '"'  -> "&quot;"
                '\'' -> "&#39;"
                _    -> [c]
    in
        concatMap escapeChar
