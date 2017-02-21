import Data.List
import Data.Ratio

posicion :: String -> IO (Maybe Int)
posicion xs = do a <- readFile "Digitos_de_pi.txt"
                 return (if (not.isInfixOf xs) a then Nothing else buscaP a xs 0)
 
 
buscaP :: String -> String -> Int -> Maybe Int
buscaP a xs n | (not.isPrefixOf xs) a = buscaP (tail a) xs (n+1)
              | otherwise = Just (n-1)
                            
--------------------------------------------------------------------------------------------------------------------------

digitosPi :: [Integer]
digitosPi = g(1,0,1,1,3,3)
   where g (q,r,t,k,n,l) = if 4*q+r-t < n*t
                           then n : g (10*q, 10*(r-n*t), t, k, div (10*(3*q+r)) t - 10*n, l)
                           else g (q*k, (2*q+r)*l, t*l, k+1, div (q*(7*k+2)+r*l) (t*l), l+2)
                                
frecuencias :: Ord a => [a] -> [(a,Int)]                                
frecuencias xs = zip as bs
  where as = map head ys
        bs = map length ys
        ys = (group.sort) xs
                                
cuantasVeces :: Eq a => a -> [a] -> Int
cuantasVeces n []     = 0
cuantasVeces n (x:xs) | n == x     =  1 + cuantasVeces n xs
                      | otherwise  =  cuantasVeces n xs
             
distribucionDigitosPi :: Int -> [Int]
distribucionDigitosPi n = [cuantasVeces x ys | x <- [0..9]]
  where ys = take n digitosPi
        
--------------------------------------------------------------------------------------------------------------------------

ejX, ejY :: [Double]
ejX = [5,7,10,12,16,20,23,27,19,14]
ejY = [9,11,15,16,20,24,27,29,22,20]

regresionLineal :: [Double] -> [Double] -> (Double,Double)
regresionLineal xs ys = (a,b)
  where n  = genericLength xs 
        sx = sum xs
        sy = sum ys
        s1 = n * (sum [x*y | x <- xs, y <- ys])
        s2 = sx*sy        
        s3 = n*(sum [x^2 | x <- xs])
        s4 = sx^2
        b  = (s1-s2)/(s3-s4)
        a  = (sy-(b*sx))/n

--------------------------------------------------------------

serie_armonica :: [Rational]
serie_armonica = [(m x) % x | x <- [1..]]
  where m x | x `mod` 4 == 1  =  -1
            | 
              
              