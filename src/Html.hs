module Html where

myhtml :: String
myhtml = html' (body' "Application hbg")

makeHtml :: String -> String -> String
makeHtml title content = html' (head' (title' title) <> body' content)

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

p' :: String -> String
p' = el "p"

h1 :: String -> String
h1 = el "h1"
