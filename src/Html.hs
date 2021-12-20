module Html where

myhtml :: String
myhtml = html' (body' "Application hbg")

makeHtml :: String -> String -> String
makeHtml title content = html' (head' (title' title) <> body' content)

newtype Html = Html String

newtype Structure = Structure String

el :: String -> String -> String
el tag content =
    "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

html' :: String -> String
html' = el "html"

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

render :: Html -> String
render html =
    case html of
        Html str -> str
