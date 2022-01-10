module Main where

import           Convert            (convert)
import qualified Html
import qualified Markup
import           System.Directory
import           System.Environment
import           System.IO          ()

main :: IO ()
main =
    getArgs >>= \args ->
        case args of

            -- No program arguments: read from stdin
            [] ->
                getContents >>= \content ->
                    putStrLn (process "Empty title" content)

            -- With input and output args
            [input, output] ->
                readFile input >>= \content ->
                    doesFileExist output >>= \exits ->
                        let
                            writeResult = writeFile output (process input content)
                        in
                            if exits
                                then whenIO confirm writeResult
                                else writeResult

            _ ->
                putStrLn "Unsage: -- <input-file> <output-file>"

process :: Html.Title -> String -> String
process title = Html.render . convert title . Markup.parse

whenIO :: IO Bool -> IO () -> IO ()
whenIO cond action =
    cond >>= \result ->
        if result
            then action
            else pure ()

confirm =
    putStrLn "Are you sure? (y/n)" *>
        getLine >>= \answer ->
            case answer of
                "y" -> pure True
                "n" -> pure False
                _ -> putStrLn "Invalid response. use y or n" *>
                    confirm
