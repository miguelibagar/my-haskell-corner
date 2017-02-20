                      CÁLCULO DE PI CON UN PÉNDULO SIMPLE

* INTRODUCCIÓN
El número pi está presente en multitud de procesos físicos, y aparece como un
sorprendente resultado de ciertos cálculos matemáticos. En este artículo
mostraremos una forma aproximada de calcular este célebre número por medio de
un péndulo simple con la inestimable ayuda de Haskell.

* EL PÉNDULO SIMPLE
Un péndulo es aquel dispositivo formado por un objeto macizo (en nuestro caso,
una esfera) al que se le adjunta una cuerda, que supondremos inextensible y de
masa despreciable. Si la amplitud de las oscilaciones es menor a 5º
sexagesimales (lo equivalente a $\frac{\pi}{36}$ radianes), podemos aproximar
el seno de dicho ángulo al espacio recorrido por el cuerpo macizo. En estas
condiciones, el péndulo recibe el apodo de "simple" o "matemático", y se
considera que oscila según los estándares del movimiento armónico simple (en
adelante MAS).

** Fundamentos matemáticos
Siguiendo la definición del MAS, podemos deducir fácilmente una expresión que
relaciona directamente el periodo de las oscilaciones con la longitud de la
cuerda.

    $T = 2\pi \sqrt{\frac{L}{g}}$,

donde \textit{g} es la aceleración de la
gravedad. Nosotros la consideraremos una constante:

\begin{code}
import Data.List

g :: Double
g = 979937.25/(100000)
\end{code}

Si elevamos al cuadrado los dos miembros de la ecuación obtenemos:

    $T^2 = \frac{4\pi^2}{g} L$

de donde podemos despejar el número que buscamos:

    $\pi = \sqrt{\frac{g}{4L}} T$.

* MEDICIONES EXPERIMENTALES
Realizaremos un total de ocho mediciones, tanto de la longitud de la cuerda
como del periodo de las oscilaciones asociada a cada una.

| L (cm) | L (m) | T (s) |
|--------+-------+-------|
|   24.7 | 0.247 | 1.003 |
|   32.9 | 0.329 | 1.159 |
|   42.9 | 0.429 | 1.311 |
|   56.9 | 0.569 | 1.511 |
|   66.4 | 0.664 | 1.632 |
|   72.1 | 0.721 | 1.703 |
|   78.7 | 0.787 | 1.779 |
|   86.2 | 0.862 | 1.863 |

* PROGRAMACIÓN EN HASKELL
Ahora implementaremos dicho procedimiento en Haskell. Daremos como dato del
tipo [(Double,Double)] la tabla de datos anterior.

\begin{code}
tablaDatos :: [(Double,Double)]
tablaDatos = [(0.247, 1.003),
              (0.329, 1.159),
              (0.429, 1.311),
              (0.569, 1.511),
              (0.664, 1.632),
              (0.721, 1.703),
              (0.787, 1.779),
              (0.862, 1.863)]
\end{code}

1. Definiremos la función piPar, tal que piPar (L,T) calcula una aproximación
   del número pi para cada par de argumentos.
2. Meteremos todos esos datos en una lista, y calcularemos la media aritmética
   de todos ellos. 
3. Calcularemos el porcentaje de desviación relativa entre el valor almacenado
   en memoria y el valor calculado experimentalmente, para decidir si es un
   método eficiente y exacto para el cálculo de dicha constante.

** Funciones utilizadas
\begin{code}
piPar :: (Double,Double) -> Double
piPar (l,t) = (t/2)*sqrt(g/l)

piExp :: Double
piExp = media [piPar p | p <- tablaDatos]
  where media xs = sum xs / genericLength xs

desv_rel_porc :: Double -> Double -> Double
desv_rel_porc apr ex = 100*(abs(apr - ex)/ex)

desv_rel_pi :: Double
desv_rel_pi = 4.102910395947251e-2
\end{code}

* CONCLUSIONES
Podemos concluir que con los datos obtenidos experimentalmente, así como con el
valor de g tomado, la desviación relativa, en tanto por ciento, es de
$4.10 \cdot 10^{-2}$, lo que indica la exactitud de nuestro método.
