# CÁLCULO DE PI CON EL MÉTODO DE GAUSS-LEGENDRE

<div id="table-of-contents">
<h2>Índice</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org0a690dc">1. INTRODUCCIÓN</a></li>
<li><a href="#org5122df9">2. UN POCO DE HISTORIA</a></li>
<li><a href="#orga34dea8">3. DEFINICIÓN DEL ALGORITMO</a></li>
<li><a href="#orgc97fad7">4. PROPIEDADES DEL ALGORITMO</a></li>
<li><a href="#orgdf2654b">5. IMPLEMENTACIÓN EN <i>HASKELL</i></a>
<ul>
<li><a href="#org424eedb">5.1. Definiciones</a></li>
<li><a href="#orgf8873d8">5.2. Análisis del procedimiento</a></li>
</ul>
</li>
<li><a href="#orgd13cd3e">6. CONCLUSIONES</a></li>
<li><a href="#orgf19e42d">7. BIBLIOGRAFÍA</a></li>
</ul>
</div>
</div>


<a id="org0a690dc"></a>

# INTRODUCCIÓN

Ya comentábamos la forma de calcular \(\pi\) de forma experimental usando un
péndulo matemático o simple. En esta ocasión, expondremos un método (esta vez
puramente matemático) de calcular esta célebre constante, conocido por el nombre de sus
desarrolladores: el *método de Brent-Salamin*. También definiremos aquellas
funciones que pueden sernos útiles para calcularla con *Haskell*.


<a id="org5122df9"></a>

# UN POCO DE HISTORIA

Carl F. Gauss desarrolló, hacia 1790, un proceso iterativo basado en
las medias aritmética y geométrica. Primero se definían los términos iniciales

\begin{equation*}
a_1 = \frac{x+y}{2} \text{\hspace{0.7cm} y \hspace{0.7cm}}  g_1 = \sqrt {x \cdot y}
\end{equation*}

donde \(a_1\) representa la media aritmética y \(g_1\) la media geométrica de *x* e *y*.

Tras ello estableció las sucesiones por recurrencia:

\begin{equation*}
a_{n+1} = \frac{a_n + g_n}{2} \text{ y }  g_{n+1} = sqrt (a_n \cdot g_n).
\end{equation*}

Estas dos progresiones convergen y hacia el mismo límite. Gauss lo denominó la
media aritmético-geométrica de *x* e *y*<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>. Dedicó algún tiempo a estudiar
las propiedades que tenía, pero no las consideró demasiado relevantes.

Casi doscientos años después, los matemáticos Eugene Salamin y Richard P. Brent
retomaron las investigaciones de Gauss sobre la media
aritmético-geométrica. Por separado, concibieron un algoritmo que permitía
calcular \(\pi\) basándose en el concepto gaussiano y en ideas de Arquímedes. En
1976 Brent y Salamin consiguieron el récord al ser capaces de calcularlo con
tres millones de cifras decimales, cuando hasta el momento sólo se había
hallado un millón.

En 2009, un equipo de investigadores dirigido por el profesor Daisuke Takahashi
(Universidad de Tsukuba, Japón) consiguió el récord mundial sobre el cálculo de los
dígitos de pi. Consiguieron obtener 2 576 980 377 524 decimales en tres días,
usando 640 ordenadores y el método que describimos. Se necesitaron 13.5
terabytes para calcularlos. 


<a id="orga34dea8"></a>

# DEFINICIÓN DEL ALGORITMO

Definiremos cuatro sucesiones por recurrencia, que llamaremos \(a_n, b_n, t_n y p_n\).

\begin{equation*}
\begin{array}{ll}
a_0 = 1 & \hspace{0.3cm}
a_{n+1} = mA (a_n, b_n) \\[0.3cm]

b_0 = \frac{1}{\sqrt{2}} & \hspace{0.3cm}
b_{n+1} = mG (a_n, b_n) \\[0.3cm]

t_0 = 1/4 & \hspace{0.3cm}
t_{n+1} = t_n - (p_n \cdot a_n - a_{n+1}^2) \\[0.3cm]

p_0 = 1 & \hspace{0.3cm}
p_{n+1} = 2 \cdot p_n
\end{array}
\end{equation*}

Donde *mA* y *mG* representan las medias aritmética y geométrica del par de
valores representado.

El número \(\pi\) aparece en el siguiente resultado:

\begin{displaymath}
\pi = lim_{n \to \infty} \frac{(a_{n+1} + b_{n+1})^2}{4 t_{n+1}}
\end{displaymath}


<a id="orgc97fad7"></a>

# PROPIEDADES DEL ALGORITMO

-   **Convergencia del método:** Puede comprobarse que el algoritmo de
    Brent-Salamin converge hacia \(\pi\), y con orden 2. Es decir, al pasar de *n*
    a *n+1* obtenemos el doble de decimales correctos<sup><a id="fnr.2" class="footref" href="#fn.2">2</a></sup> de pi.
-   **Velocidad de convergencia:** Converge con una velocidad muy grande. Con
    sólo veinticinco iteraciones produce cuarenta y cinco millones de
    cifras correctas de \(\pi\).<sup><a id="fnr.3" class="footref" href="#fn.3">3</a></sup>
-   **Memoria requerida:** Es el punto débil del algoritmo. Este método requiere
    una gran cantidad de memoria conforme *n* va aumentando. Es por ello
    que a veces se prefieren otros métodos que, aunque no convergen tan
    rápido, requieren un menor número de cálculos (como, por ejemplo, las
    fórmulas de Machin).<sup><a id="fnr.4" class="footref" href="#fn.4">4</a></sup>

Todo lo expuesto anteriormente puede verse en el gráfico:

![Jekyll](maths/pi_gauss_legendre/brent-salamin_convergence.png)

A pesar de este último inconveniente, podremos definir el algoritmo de
Brent-Salamin en un ordenador doméstico usando *Haskell*, y con 3 ó 4 iteraciones
habremos calculado \(\pi\) con quince decimales exactos (el máximo número de dígitos
que se nos muestra para un decimal de tipo \texttt{Double}). Un resultado más que
aceptable.


<a id="orgdf2654b"></a>

# IMPLEMENTACIÓN EN *HASKELL*


<a id="org424eedb"></a>

## Definiciones

Las funciones que utilizaremos en *Haskell* son las siguientes:

    mAritm2, mGeom2 :: Double -> Double -> Double
    mAritm2 x y = (x+y) / 2
    mGeom2  x y = sqrt (x*y)
    
    
    a, b, t, p :: Int -> Double
    
    a 0 = 1
    a n = mAritm2 (a (n-1)) (b (n-1))
    
    b 0 = 1/sqrt(2)
    b n = mGeom2 (a (n-1)) (b (n-1))
    
    t 0   = 1/4
    t n = t (n-1) - (p (n-1) * (a (n-1) - a n)^2)
    
    p 0 = 1
    p n = 2 * (p (n-1))
    
    
    piGauss :: Int -> Double
    piGauss n = ((a (n+1)) + (b (n+1)))^2 / (4*(t (n+1)))


<a id="orgf8873d8"></a>

## Análisis del procedimiento

Hemos realizado un total de 14 ejecuciones de la función \texttt{piGauss} y hemos
anotado el tiempo empleado para cada una de ellas. Antes de cada una hemos
cargado de nuevo el archivo para borrar de la memoria los resultados
anteriores.

Organizando las mediciones en una tabla, obtenemos:

<table id="org85af8e8" border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
<caption class="t-above"><span class="table-number">Table 1:</span> Mediciones del tiempo en calcular \texttt{piGauss}</caption>

<colgroup>
<col  class="org-right" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-right">n</th>
<th scope="col" class="org-right">t(s)</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-right">8</td>
<td class="org-right">0.02</td>
</tr>


<tr>
<td class="org-right">9</td>
<td class="org-right">0.03</td>
</tr>


<tr>
<td class="org-right">10</td>
<td class="org-right">0.03</td>
</tr>


<tr>
<td class="org-right">11</td>
<td class="org-right">0.05</td>
</tr>


<tr>
<td class="org-right">12</td>
<td class="org-right">0.09</td>
</tr>


<tr>
<td class="org-right">13</td>
<td class="org-right">0.16</td>
</tr>


<tr>
<td class="org-right">14</td>
<td class="org-right">0.33</td>
</tr>


<tr>
<td class="org-right">15</td>
<td class="org-right">0.64</td>
</tr>


<tr>
<td class="org-right">16</td>
<td class="org-right">1.22</td>
</tr>


<tr>
<td class="org-right">17</td>
<td class="org-right">2.53</td>
</tr>


<tr>
<td class="org-right">18</td>
<td class="org-right">5.01</td>
</tr>


<tr>
<td class="org-right">19</td>
<td class="org-right">10.12</td>
</tr>


<tr>
<td class="org-right">20</td>
<td class="org-right">20.30</td>
</tr>


<tr>
<td class="org-right">21</td>
<td class="org-right">42.00</td>
</tr>
</tbody>
</table>

Hemos de tener en cuenta que la precisión del cronómetro integrado en Emacs es
muy baja (0.01 s), por lo que para estudiar la tendencia del
tiempo, los valores más representativos son aquellos a partir de \(n = 11\).

Representemos estas medidas en una gráfica con ayuda de *gnuplot*:

[[![img](C:/I1M/Pi/gauss_legendre/tiempo_usado.png)]]

Podemos concluir que el tiempo empleado para calcular cada término \texttt{piGauss}
aumenta de forma exponencial con una razón aproximada de 2. Esto es
consecuencia directa del orden del estudiado método iterativo.


<a id="orgd13cd3e"></a>

# CONCLUSIONES

El método de Brent-Salamin es un algoritmo potente y que converge rápidamente,
pero no es el más recomendado si queremos calcular pi con varias cifras
decimales. A día de hoy, el récord se encuentra en los 22 459 157 718 361
decimales, calculados en 105 días (a una velocidad de 2.5 millones de dígitos
por segundo, en comparación de los 2.5 dígitos por segundo en la experiencia
del profesor Takahashi). Estas velocidades son mucho mayores que, por ejemplo,
la alcanzada por el ENIAC en 1949 (calculó 2 037 dígitos en 70 horas; es decir,
a una velocidad de \(3.36 \cdot 10^{-4}\) dígitos por segundo).

Se pone de manifiesto, por lo tanto, dos cuestiones:

1.  El avance de la tecnología, que permite alcanzar mayores velocidades en el
    cálculo de operaciones cada vez más complejas.
2.  El desarrollo de nuevos métodos matemáticos, que ahorran cálculos
    innecesarios y proporcionan algoritmos cada vez más veloces.

Es el balance equilibrado entre esos dos aspectos lo que propicia el progreso
de la ciencia y la tecnología.


<a id="orgf19e42d"></a>

--------------------------

# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> Para profundizar en los conceptos de media aritmético-geométrica,
visitar <http://en.wikipedia.org/wiki/Arithmetic-geometric_mean>.

<sup><a id="fn.2" href="#fnr.2">2</a></sup> Cuando hablamos de *decimales correctos*, nos referimos a que son iguales a aquella
secuencia de dígitos de \(\pi\) considerada como la de mayor exactitud. Ningún método puede
hallar \(\pi\) con todos sus infinitos decimales exactos.

<sup><a id="fn.3" href="#fnr.3">3</a></sup> En la web
<http://demonstrations.wolfram.com/GaussLegendreApproximationOfPi/>
se puede ver de forma interactiva cómo aumentando los valores de *n*
el número de decimales correctos es mayor.

<sup><a id="fn.4" href="#fnr.4">4</a></sup> Para más información sobre las fórmulas de Machin, visitar
<http://en.wikipedia.org/wiki/Machin-like_formula>.
