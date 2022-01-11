module OptParse where

data Options
    = ConvertSingle SingleInput SingleOutput
    | ConvertDir FilePath FilePath
    deriving Show

data SingleInput
    = Stdin
    | InputFile FilePath
    deriving Show

data SingleOutput
    = Stdout
    | OutputFile Filepath
    deriving Show
