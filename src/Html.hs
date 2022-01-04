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

el :: String -> String -> String
el tag content =
    "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

html' :: Title -> Structure -> Html
html' title content =
    Html
        ( el "html"
            (el "head" (el "title" title))
            <> el "body" (getStructureString content)
        )

body' :: String -> Structure
body' = Structure . el "body"

head' :: String -> Structure
head' = Structure . el "head"

title' :: String -> Structure
title' = Structure . el "title"

p' :: String -> Structure
p' = Structure . el "p"

h1' :: String -> Structure
h1' = Structure . el "h1"

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
