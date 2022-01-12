module OptParse where

import           Control.Applicative
import           Data.Maybe          (fromMaybe)
import           Options.Applicative

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
-- * Single source and output parsers

-- | Parser for single source to location
pConvertSingle :: Parser Options
pConvertSingle = ConvertSingle <$> pInputFile <*> pOutputFile

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
