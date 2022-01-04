module Html
     ( Html
    , Title
    , Structure
    , html'
    , p'
    , append'
    , render
    )
    where

myhtml :: String
myhtml = html' (body' "Application hbg")

makeHtml :: String -> String -> String
makeHtml title content = html' (head' (title' title) <> body' content)

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

body' :: String -> String
body' = el "body"

head' :: String -> String
head' = el "head"

title' :: String -> String
title' = el "title"

p' :: String -> Structure
p' = Structure . el "p"

h1 :: String -> String
h1 = el "h1"

append' :: Structure -> Structure -> Structure
append' (Structure a) (Structure b) = Structure (a <> b)

getStructureString :: Structure -> String
getStructureString content =
    case content of
        Structure str -> str

render :: Html -> String
render html =
    case html of
        Html str -> str
