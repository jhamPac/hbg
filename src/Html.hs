module Html
     ( Html
    , Title
    , Structure
    , html'
    , p'
    , h1'
    , append'
    , render
    )
    where

newtype Html = Html String

newtype Structure = Structure String

type Title = String

html' :: Title -> Structure -> Html
html' title content =
    Html
        ( el "html"
            (el "head" (el "title" $ escape title))
            <> el "body" (getStructureString content)
        )

el :: String -> String -> String
el tag content =
    "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

p' :: String -> Structure
p' = Structure . el "p" . escape

h1' :: String -> Structure
h1' = Structure . el "h1" . escape

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

append' :: Structure -> Structure -> Structure
append' x y = Structure (getStructureString x <> getStructureString y)

getStructureString :: Structure -> String
getStructureString content =
    case content of
        Structure str -> str

render :: Html -> String
render html =
    case html of
        Html str -> str
