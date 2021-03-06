module Utils exposing (..)

import Array exposing (Array)
import Color exposing (Color)
import Random


applyFuncs : List (a -> b) -> a -> List b
applyFuncs =
    (|>) >> List.map |> flip


cssColor : Color -> String
cssColor color =
    let
        tmp =
            color
                |> Color.toRgb
                |> applyFuncs [ .red, .green, .blue ]
                |> List.map toString
                |> String.join ","
    in
    "rgb(" ++ tmp ++ ")"


pairRange ( s1, s2 ) ( e1, e2 ) =
    List.range s1 e1
        |> List.concatMap
            (\x ->
                List.range s2 e2
                    |> List.map (\y -> ( x, y ))
            )


pairMap : (a1 -> b1) -> (a2 -> b2) -> ( a1, a2 ) -> ( b1, b2 )
pairMap f1 f2 ( e1, e2 ) =
    ( f1 e1, f2 e2 )
