module Main where

import           Html (Html, Structure, h', html', p', render)


myhtml :: Html
myhtml =
    html' "The Title" (h' 1 "Header" <> p' "Paragraph #1" <> p' "Paragraph #2")



main :: IO ()
main = print (render myhtml)
