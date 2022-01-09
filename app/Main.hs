module Main where

import           Convert
import qualified Html
import qualified Markup
import           System.Directory
import           System.Environment
import           System.IO          ()

process :: Html.Title -> String -> String
process title = Html.render . convert title . Markup.parse

main :: IO ()
main = print "start over"
