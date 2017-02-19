<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. INTRODUCCI�N</a></li>
<li><a href="#sec-2">2. EL P�NDULO SIMPLE</a>
<ul>
<li><a href="#sec-2-1">2.1. Fundamentos matem�ticos</a></li>
</ul>
</li>
<li><a href="#sec-3">3. MEDICIONES EXPERIMENTALES</a></li>
<li><a href="#sec-4">4. PROGRAMACI�N EN HASKELL</a></li>
<li><a href="#sec-5">5. CONCLUSIONES</a></li>
</ul>
</div>
</div>


# INTRODUCCI�N<a id="sec-1" name="sec-1"></a>

El n�mero pi est� presente en multitud de procesos f�sicos, y aparece como un
sorprendente resultado de ciertos c�lculos matem�ticos. En este art�culo
mostraremos una forma aproximada de calcular este c�lebre n�mero por medio de
un p�ndulo simple con la inestimable ayuda de Haskell.

# EL P�NDULO SIMPLE<a id="sec-2" name="sec-2"></a>

Un p�ndulo es aquel dispositivo formado por un objeto macizo (en nuestro caso,
una esfera) al que se le adjunta una cuerda, que supondremos inextensible y de
masa despreciable. Si la amplitud de las oscilaciones es menor a 5�
sexagesimales (lo equivalente a \(\dfrac{\pi}{36}\) radianes), podemos aproximar
el seno de dicho �ngulo al espacio recorrido por el cuerpo macizo. En estas
condiciones, el p�ndulo recibe el apodo de "simple" o "matem�tico", y se
considera que oscila seg�n los est�ndares del movimiento arm�nico simple (en
adelante MAS).

## Fundamentos matem�ticos<a id="sec-2-1" name="sec-2-1"></a>

Siguiendo la definici�n del MAS, podemos deducir f�cilmente una expresi�n que
relaciona directamente el periodo de las oscilaciones con la longitud de la
cuerda.

\(T = 2\pi \sqrt{\frac{L}{g}}\),

donde \textit{g} es la aceleraci�n de la
gravedad. Nosotros la consideraremos una constante:

g :: Double
g = 979937.25/(100000)

Si elevamos al cuadrado los dos miembros de la ecuaci�n obtenemos:

\(T^2 = \frac{4\pi^2}{g} L\)

de donde podemos despejar el n�mero que buscamos:

\(\pi = \sqrt{\frac{g}{4L}} T\).

# MEDICIONES EXPERIMENTALES<a id="sec-3" name="sec-3"></a>

Realizaremos un total de ocho mediciones, tanto de la longitud de la cuerda
como del periodo de las oscilaciones asociada a cada una.

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="right" />

<col  class="right" />

<col  class="right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="right">L (cm)</th>
<th scope="col" class="right">L (m)</th>
<th scope="col" class="right">T (s)</th>
</tr>
</thead>

<tbody>
<tr>
<td class="right">24.7</td>
<td class="right">0.247</td>
<td class="right">1.003</td>
</tr>


<tr>
<td class="right">32.9</td>
<td class="right">0.329</td>
<td class="right">1.159</td>
</tr>


<tr>
<td class="right">42.9</td>
<td class="right">0.429</td>
<td class="right">1.311</td>
</tr>


<tr>
<td class="right">56.9</td>
<td class="right">0.569</td>
<td class="right">1.511</td>
</tr>


<tr>
<td class="right">66.4</td>
<td class="right">0.664</td>
<td class="right">1.632</td>
</tr>


<tr>
<td class="right">72.1</td>
<td class="right">0.721</td>
<td class="right">1.703</td>
</tr>


<tr>
<td class="right">78.7</td>
<td class="right">0.787</td>
<td class="right">1.779</td>
</tr>


<tr>
<td class="right">86.2</td>
<td class="right">0.862</td>
<td class="right">1.863</td>
</tr>
</tbody>
</table>

# PROGRAMACI�N EN HASKELL<a id="sec-4" name="sec-4"></a>

Ahora implementaremos dicho procedimiento en Haskell. Daremos como dato del
tipo [(Double,Double)] la tabla de datos anterior.

tablaDatos :: [(Double,Double)]
tablaDatos = [(0.247, 1.003),
              (0.329, 1.159),
              (0.429, 1.311),
              (0.569, 1.511),
              (0.664, 1.632),
              (0.721, 1.703),
              (0.787, 1.779),
              (0.862, 1.863)]

1.  Definiremos la funci�n piPar :: (Double,Double) -> Double , tal que piPar
    (L,T) calcula una aproximaci�n del n�mero &pi; para cada par de argumentos.
2.  Meteremos todos esos datos en una lista, y calcularemos la media aritm�tica
    de todos ellos.
3.  Calcularemos el porcentaje de desviaci�n relativa entre el valor almacenado
    en memoria y el valor calculado experimentalmente, para decidir si es un
    m�todo eficiente y exacto para el c�lculo de dicha constante.
    
    desv<sub>rel</sub><sub>porc</sub> :: Double -> Double -> Double
    desv<sub>rel</sub><sub>porc</sub> apr ex = 100\*((apr - ex)/ex)

# CONCLUSIONES<a id="sec-5" name="sec-5"></a>

Podemos concluir que con los datos obtenidos experimentalmente, as� como con el
valor de g tomado, la desviaci�n relativa, en tanto por ciento, es de \(4.10
\cdot 10^-2\), lo que indica la exactitud de nuestro m�todo.