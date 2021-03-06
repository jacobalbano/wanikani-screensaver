module Utils exposing (applyFuncs, arraySwap, pairMap, pairRange, randomListElement)

import Array exposing (Array)
import Random


applyFuncs : List (a -> b) -> a -> List b
applyFuncs functions arg =
    List.map (\f -> f arg) functions


arraySwap : Int -> Int -> Array elem -> Array elem
arraySwap i1 i2 array =
    Maybe.map2
        (\e1 e2 -> array |> Array.set i1 e2 |> Array.set i2 e1)
        (Array.get i1 array)
        (Array.get i2 array)
        |> Maybe.withDefault array


pairRange : ( Int, Int ) -> ( Int, Int ) -> List ( Int, Int )
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


randomListElement : List a -> Random.Seed -> ( Maybe a, Random.Seed )
randomListElement list seed =
    case list of
        [] ->
            ( Nothing, seed )

        _ ->
            let
                gen =
                    Random.int 0 (List.length list - 1)

                ( index, newSeed ) =
                    Random.step gen seed

                element =
                    list |> List.drop index |> List.head
            in
            ( element, newSeed )
