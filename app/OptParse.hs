module OptParse
    (
        Options(..)
        , SingleInput(..)
        , SingleOutput(..)
        , parse
    )
    where

import           Control.Applicative (optional, (<**>))
import           Data.Maybe          (fromMaybe)
import           Options.Applicative (Parser, ParserInfo, command, execParser,
                                      fullDesc, header, help, helper, info,
                                      long, metavar, optional, progDesc, short,
                                      strOption, subparser, (<**>))

-----------------------------------------------------------------------------
-- * CLI options model

-- | Model
data Options
    = ConvertSingle SingleInput SingleOutput
    | ConvertDir FilePath FilePath
    deriving Show

-- | Single input source
data SingleInput
    = Stdin
    | InputFile FilePath
    deriving Show

-- | Single output location
data SingleOutput
    = Stdout
    | OutputFile FilePath
    deriving Show

-----------------------------------------------------------------------------
-- * Parer

-- | Parse command-line options

parse :: IO Options
parse = execParser opts

opts :: ParserInfo Options
opts =
    info (pOptions <**> helper)
        (
            fullDesc
            <> header "hbg - a static blog generator"
            <> progDesc "Convert markup file or directories to HTML"
        )

pOptions :: Parser Options
pOptions =
    subparser
        (
            command "convert" (info (helper <*> pConvertSingle) (progDesc "Convert a single markup source to HTML"))
            <> command "convert-dir" (info (helper <*> pConvertDir) (progDesc "Convert a directory of markeup files to HTML"))
        )

-----------------------------------------------------------------------------
-- * Single source and output parsers

-- | Parser for single source to location
pConvertSingle :: Parser Options
pConvertSingle = ConvertSingle <$> pSingleInput <*> pSingleOutput

pSingleInput :: Parser SingleInput
pSingleInput =
    fromMaybe Stdin <$> optional pInputFile

pSingleOutput :: Parser SingleOutput
pSingleOutput =
    fromMaybe Stdout <$> optional pOutputFile

-- | Input file parser
pInputFile :: Parser SingleInput
pInputFile = fmap InputFile parser
    where
        parser =
            strOption
                (
                    long "input"
                    <> short 'i'
                    <> metavar "FILE"
                    <> help "Input file"
                )

-- | Output file parser
pOutputFile :: Parser SingleOutput
pOutputFile = fmap OutputFile parser
    where
        parser =
            strOption
                (
                    long "output"
                    <> short 'o'
                    <> metavar "File"
                    <> help "Output file"
                )

-----------------------------------------------------------------------------
-- * Directory conversion parser

pConvertDir :: Parser Options
pConvertDir = ConvertDir <$> pInputDir <*> pOutputDir

-- | Parser for input directory
pInputDir :: Parser FilePath
pInputDir =
    strOption
        (
            long "input"
            <> short 'i'
            <> metavar "DIRECTORY"
            <> help "Input directory"
        )

-- | Parser for output directory
pOutputDir :: Parser FilePath
pOutputDir =
    strOption
        (
            long "output"
            <> short 'o'
            <> metavar "DIRECTORY"
            <> help "Output directory"
        )
