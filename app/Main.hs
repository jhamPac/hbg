module Main where

import           Convert            (convert)
import qualified Html
import qualified Markup
import           System.Directory   (doesFileExist)
import           System.Environment (getArgs)
import           System.IO          ()

main :: IO ()
main = do
    args <- getArgs
    case args of
    -- No program arguments: read from stdin
        [] -> do
            content <- getContents
            putStrLn (process "Empty title" content)

    -- With input and output file paths as program args
        [input, output] -> do
            content <- readFile input
            exists <- doesFileExist output
            let
                writeResult = writeFile output (process input content)
            if exists
                then whenIO confirm writeResult
                else writeResult

        _ ->
            putStrLn "Usage: exe [-- <input-file> <output-file>]"




process :: Html.Title -> String -> String
process title = Html.render . convert title . Markup.parse

whenIO :: IO Bool -> IO () -> IO ()
whenIO cond action = do
    result <- cond
    if result
        then action
        else pure ()

confirm = do
    putStrLn "Are you sure? (y/n)"
    answer <- getLine
    case answer of
        "y" -> pure True
        "n" -> pure False
        _ -> putStrLn "Invalid response. use y or n" *>
            confirm
