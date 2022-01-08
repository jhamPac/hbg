module Html.Internal where

-- * Types

newtype Html = Html String

newtype Structure = Structure String

instance Semigroup Structure where
    (<>) c1 c2 =
        Structure (getStructureString c1 <> getStructureString c2)

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

h1' :: String -> Structure
h1' = Structure . el "h1" . escape

code' :: String -> Structure
code' = Structure . el "pre"

ul' :: [Structure] -> Structure
ul' =
    Structure . el "ul" . concatMap (el "li" . getStructureString)

ol' :: [Structure] -> Structure
ol' =
    Structure . el "ol" . concatMap (el "li" . getStructureString)

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
