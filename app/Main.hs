module Main where

import           Html (Html, append', h1', html', p', render)


myhtml :: Html
myhtml =
    html'
        "The Title"
        ( append'
            (h1' "Header")
            ( append'
                (p' "Paragraph #1")
                (p' "Paragraph # 2")
            )
        )

main :: IO ()
main = print (render myhtml)
