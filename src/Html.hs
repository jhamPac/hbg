module Html where

myhtml = html' (body' "Application hbg")

makeHtml title content = html' (head' (title' title) <> body' content)

html' content = "<html>" <> content <> "</html>"

body' content = "<body>" <> content <> "</html>"

head' content = "<head>" <> content <> "</head>"

title' content = "<title>" <> content <> "</title>"


