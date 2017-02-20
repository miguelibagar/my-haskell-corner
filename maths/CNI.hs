-- Media de un par de valores
media :: (Double,Double) -> Double
media (x,y) = (x+y)/2

-- Cálculo de los ceros de una función en un intervalo dado
biseccion :: (Double -> Double) -> (Double,Double) -> Double -> Double
biseccion f (a,b) e = do let x0 = media (a,b) 
                         decide f x0 (a,b) e
                       
decide :: (Double -> Double) -> Double -> (Double,Double) -> Double -> Double                      
decide f x (a,b) e | aproxima (f x)     =  x
                   | ((f a)*(f x)) < 0  =  biseccion f (a,x) e
                   | otherwise          =  biseccion f (x,b) e
  where aproxima n = abs n <= e
        
-- Cálculo del máximo común divisor de un par de números con el algoritmo de Euclides
mcd :: (Integer,Integer) -> Integer
mcd (x,y) | x == y     =  x
          | x >  y     =  euclides (x,y)
          | otherwise  =  euclides (y,x)
                          
euclides :: (Integer,Integer) -> Integer
euclides (x,y) | r == 0     =  y
               | otherwise  =  euclides (y,r)
  where r = rem x y