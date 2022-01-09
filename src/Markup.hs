module Markup where

import           Data.Maybe
import           Numeric.Natural

type Document = [Structure]

data Structure
    = Header Natural String
    | Paragraph String
    | UnorderedList [String]
    | OrderedList [String]
    | CodeBlock [String]
    deriving Show

parse :: String -> Document
parse = parseLines Nothing . lines

parseLines :: Maybe Structure -> [String] -> Document
parseLines context txts =
    case txts of
        [] -> maybeToList context

        ('*' : ' ' : line) : rest ->
            maybe id (:) context (Header 1 (trim line) : parseLines Nothing rest)

        ('-' : ' ' : line) : rest ->
            case context of
                Just (UnorderedList list) ->
                    parseLines (Just (UnorderedList (list <> [trim line]))) rest

                _ -> maybe id (:) context (parseLines (Just (UnorderedList [trim, line])) rest)

        (currentLine : rest) ->
            let
                line = trim currentLine
            in
                if line == ""
                    then
                        maybe id (:) context (parseLines Nothing rest)
                    else
                        case context of
                            Just (Paragraph paragraph) ->
                                parseLines (Just (Paragraph (unwords [paragraph, line]))) rest

                            _ -> maybe id (:) context (parseLines (Just (Paragraph line)) rest)

trim :: String -> String
trim = unwords . words
