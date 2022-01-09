module Convert where

import qualified Html
import qualified Markup

convertStructure :: Markup.Structure -> Html.Structure
convertStructure structure =
    case structure of
        Markup.Header n txt ->
            Html.h' n txt

        Markup.Paragraph p ->
            Html.p' p

        Markup.UnorderedList list ->
            Html.ul' $ map Html.p' list

        Markup.OrderedList list ->
            Html.ol' $ map Html.p' list

        Markup.CodeBlock list ->
            Html.code' (unlines list)
