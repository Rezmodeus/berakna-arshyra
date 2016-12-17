module Constants exposing (..)

import Menu exposing (..)


lagenhetstyper : List MenuItem
lagenhetstyper =
    [ ( "1 rks", 24 )
    , ( "1 rkv", 27 )
    , ( "1 rk", 34 )
    , ( "2 rkv", 34 )
    , ( "1,5 rk", 37 )
    , ( "2 rk", 40 )
    , ( "2,5 rk", 42 )
    , ( "3 rk", 44 )
    , ( "3,5 rk", 46.5 )
    , ( "4 rk", 49 )
    , ( "4,5 rk", 50.5 )
    , ( "5 rk", 52 )
    , ( "6 rk", 55 )
    , ( "7 rk", 57 )
    , ( "8 rk", 59 )
    ]


region : List MenuItem
region =
    [ ( "Stockholm", 1450 )
    , ( "Stockholmsnära, Göteborg, Malmö m.fl.", 1350 )
    , ( "Övriga", 1300 )
    ]
