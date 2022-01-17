module Blog where

import           Convert   (convert)
import qualified Html
import qualified Markup
import           System.IO

convertSingle :: Html.Title -> Handle -> Handle -> IO ()
convertSingle title input output = do
    content <- hGetContents input
    hPutStrLn output (process title content)

convertDirectory :: FilePath -> FilePath -> IO ()
convertDirectory = error "Not Yet"

process :: Html.Title -> String -> String
process title = Html.render . convert title . Markup.parse
