-- Notes: use that 2017-1-1 was Monday.


dSem :: [(String,Int)]
dSem  =  [("Monday",0),("Tuesday",1),("Wednesday",2),("Thursday",3),("Friday",4),("Saturday",5),("Sunday",6)]

dMes :: [(Int,Int)]
dMes  =  [(1,31),(2,28),(3,31),(4,30),(5,31),(6,30),(7,31),(8,31),(9,30),(10,31),(11,30),(12,31)]

----------------------------------------------------------------

busca :: a -> [(a1,a2)] -> (a -> a1 -> Bool) -> [(a1,a2)]
busca x xs p  =  [(x',y) | (x',y) <- xs, p x x']

----------------------------------------------------------------

diaAno :: (Int,Int,Int) -> Int
diaAno (d,m,a)  =  d + sum [y | (x,y) <- busca m dMes (>)]

dia :: (Int,Int,Int) -> String
dia (d,m,a)  =  head [x | (x,y') <- dSem, n == y']
  where  n   =  mod ((diaAno (d,m,a) + (a - 2007)*365) + x) 7
         x   |  d <= 29 && m <= 2  =  div (a - 2007) 4 - 1
             |  otherwise          =  div (a - 2007) 4
