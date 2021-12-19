module Html where

myhtml :: String
myhtml = html' (body' "Application hbg")

makeHtml :: String -> String -> String
makeHtml title content = html' (head' (title' title) <> body' content)


html' :: String -> String
html' = el "html"

body' :: String -> String
body' = el "body"

head' :: String -> String
head' = el "head"

title' :: String -> String
title' = el "title"

el :: String -> String -> String
el tag content =
    "<" <> tag <> ">" <> content <> "</" <> tag <> ">"


