module Main where

import           Html (Html, Structure, h1', html', p', render)


myhtml :: Html
myhtml =
    html' "The Title" (h1' "Header" <> p' "Paragraph #1" <> p' "Paragraph #2")



main :: IO ()
main = print (render myhtml)
