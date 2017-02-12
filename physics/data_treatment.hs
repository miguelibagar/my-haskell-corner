type Medida = (Float,Float)

media :: [Float] -> Float
media xs = sum xs / (fromIntegral $ length xs)

semidisp :: [Float] -> Float
semidisp xs = (maximum xs - minimum xs)/2

medida :: [Float] -> Medida
medida xs = (media xs, semidisp xs)
