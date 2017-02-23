<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org0a690dc">1. INTRODUCCI�N</a></li>
<li><a href="#org5122df9">2. UN POCO DE HISTORIA</a></li>
<li><a href="#orga34dea8">3. DEFINICI�N DEL ALGORITMO</a></li>
<li><a href="#orgc97fad7">4. PROPIEDADES DEL ALGORITMO</a></li>
<li><a href="#orgdf2654b">5. IMPLEMENTACI�N EN <i>HASKELL</i></a>
<ul>
<li><a href="#org424eedb">5.1. Definiciones</a></li>
<li><a href="#orgf8873d8">5.2. An�lisis del procedimiento</a></li>
</ul>
</li>
<li><a href="#orgd13cd3e">6. CONCLUSIONES</a></li>
<li><a href="#orgf19e42d">7. BIBLIOGRAF�A</a></li>
</ul>
</div>
</div>


<a id="org0a690dc"></a>

# INTRODUCCI�N

Ya coment�bamos la forma de calcular \(\pi\) de forma experimental usando un
p�ndulo matem�tico o simple. En esta ocasi�n, expondremos un m�todo (esta vez
puramente matem�tico) de calcular esta c�lebre constante, conocido por el nombre de sus
desarrolladores: el *m�todo de Brent-Salamin*. Tambi�n definiremos aquellas
funciones que pueden sernos �tiles para calcularla con *Haskell*.


<a id="org5122df9"></a>

# UN POCO DE HISTORIA

Carl F. Gauss desarroll�, hacia 1790, un proceso iterativo basado en
las medias aritm�tica y geom�trica. Primero se defin�an los t�rminos iniciales

\begin{equation*}
a_1 = \frac{x+y}{2} \text{\hspace{0.7cm} y \hspace{0.7cm}}  g_1 = \sqrt {x \cdot y}
\end{equation*}

donde \(a_1\) representa la media aritm�tica y \(g_1\) la media geom�trica de *x* e *y*.

Tras ello estableci� las sucesiones por recurrencia:

\begin{equation*}
a_{n+1} = \frac{a_n + g_n}{2} \text{ y }  g_{n+1} = sqrt (a_n \cdot g_n).
\end{equation*}

Estas dos progresiones convergen y hacia el mismo l�mite. Gauss lo denomin� la
media aritm�tico-geom�trica de *x* e *y*<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>. Dedic� alg�n tiempo a estudiar
las propiedades que ten�a, pero no las consider� demasiado relevantes.

Casi doscientos a�os despu�s, los matem�ticos Eugene Salamin y Richard P. Brent
retomaron las investigaciones de Gauss sobre la media
aritm�tico-geom�trica. Por separado, concibieron un algoritmo que permit�a
calcular \(\pi\) bas�ndose en el concepto gaussiano y en ideas de Arqu�medes. En
1976 Brent y Salamin consiguieron el r�cord al ser capaces de calcularlo con
tres millones de cifras decimales, cuando hasta el momento s�lo se hab�a
hallado un mill�n.

En 2009, un equipo de investigadores dirigido por el profesor Daisuke Takahashi
(Universidad de Tsukuba, Jap�n) consigui� el r�cord mundial sobre el c�lculo de los
d�gitos de pi. Consiguieron obtener 2 576 980 377 524 decimales en tres d�as,
usando 640 ordenadores y el m�todo que describimos. Se necesitaron 13.5
terabytes para calcularlos. 


<a id="orga34dea8"></a>

# DEFINICI�N DEL ALGORITMO

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

Donde *mA* y *mG* representan las medias aritm�tica y geom�trica del par de
valores representado.

El n�mero \(\pi\) aparece en el siguiente resultado:

\begin{displaymath}
\pi = lim_{n \to \infty} \frac{(a_{n+1} + b_{n+1})^2}{4 t_{n+1}}
\end{displaymath}


<a id="orgc97fad7"></a>

# PROPIEDADES DEL ALGORITMO

-   **Convergencia del m�todo:** Puede comprobarse que el algoritmo de
    Brent-Salamin converge hacia \(\pi\), y con orden 2. Es decir, al pasar de *n*
    a *n+1* obtenemos el doble de decimales correctos<sup><a id="fnr.2" class="footref" href="#fn.2">2</a></sup> de pi.
-   **Velocidad de convergencia:** Converge con una velocidad muy grande. Con
    s�lo veinticinco iteraciones produce cuarenta y cinco millones de
    cifras correctas de \(\pi\).<sup><a id="fnr.3" class="footref" href="#fn.3">3</a></sup>
-   **Memoria requerida:** Es el punto d�bil del algoritmo. Este m�todo requiere
    una gran cantidad de memoria conforme *n* va aumentando. Es por ello
    que a veces se prefieren otros m�todos que, aunque no convergen tan
    r�pido, requieren un menor n�mero de c�lculos (como, por ejemplo, las
    f�rmulas de Machin).<sup><a id="fnr.4" class="footref" href="#fn.4">4</a></sup>

Todo lo expuesto anteriormente puede verse en el gr�fico:

[[![img](C:/I1M/Pi/gauss_legendre/brent-salamin_convergence.png)]]

A pesar de este �ltimo inconveniente, podremos definir el algoritmo de
Brent-Salamin en un ordenador dom�stico usando *Haskell*, y con 3 � 4 iteraciones
habremos calculado \(\pi\) con quince decimales exactos (el m�ximo n�mero de d�gitos
que se nos muestra para un decimal de tipo \texttt{Double}). Un resultado m�s que
aceptable.


<a id="orgdf2654b"></a>

# IMPLEMENTACI�N EN *HASKELL*


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

## An�lisis del procedimiento

Hemos realizado un total de 14 ejecuciones de la funci�n \texttt{piGauss} y hemos
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

Hemos de tener en cuenta que la precisi�n del cron�metro integrado en Emacs es
muy baja (0.01 s), por lo que para estudiar la tendencia del
tiempo, los valores m�s representativos son aquellos a partir de \(n = 11\).

Representemos estas medidas en una gr�fica con ayuda de *gnuplot*:

[[![img](C:/I1M/Pi/gauss_legendre/tiempo_usado.png)]]

Podemos concluir que el tiempo empleado para calcular cada t�rmino \texttt{piGauss}
aumenta de forma exponencial con una raz�n aproximada de 2. Esto es
consecuencia directa del orden del estudiado m�todo iterativo.


<a id="orgd13cd3e"></a>

# CONCLUSIONES

El m�todo de Brent-Salamin es un algoritmo potente y que converge r�pidamente,
pero no es el m�s recomendado si queremos calcular pi con varias cifras
decimales. A d�a de hoy, el r�cord se encuentra en los 22 459 157 718 361
decimales, calculados en 105 d�as (a una velocidad de 2.5 millones de d�gitos
por segundo, en comparaci�n de los 2.5 d�gitos por segundo en la experiencia
del profesor Takahashi). Estas velocidades son mucho mayores que, por ejemplo,
la alcanzada por el ENIAC en 1949 (calcul� 2 037 d�gitos en 70 horas; es decir,
a una velocidad de \(3.36 \cdot 10^{-4}\) d�gitos por segundo).

Se pone de manifiesto, por lo tanto, dos cuestiones:

1.  El avance de la tecnolog�a, que permite alcanzar mayores velocidades en el
    c�lculo de operaciones cada vez m�s complejas.
2.  El desarrollo de nuevos m�todos matem�ticos, que ahorran c�lculos
    innecesarios y proporcionan algoritmos cada vez m�s veloces.

Es el balance equilibrado entre esos dos aspectos lo que propicia el progreso
de la ciencia y la tecnolog�a.


<a id="orgf19e42d"></a>

# BIBLIOGRAF�A

<https://www.uam.es/personal_pdi/ciencias/cillerue/Curso/GacRSocMatEsp6.pdf>
(Historia, final prr 1)
<https://en.wikipedia.org/wiki/Gauss%E2%80%93Legendre_algorithm> (Algoritmo,
memoria requerida propiedades)
<https://en.wikipedia.org/wiki/Chronology_of_computation_of_%CF%80> (Historia,
final prr 3)
<http://www.mat.ucm.es/~rrdelrio/ponencias/algoritmos_pi_upm.pdf> (Historia,
final prr 2)
<https://www.fayerwayer.com/2009/08/nuevo-record-del-calculo-de-decimales-de-%CF%80/>
(Historia, prr 3 despues de los decimales que consiguieron)


# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> Para profundizar en los conceptos de media aritm�tico-geom�trica,
visitar <http://en.wikipedia.org/wiki/Arithmetic-geometric_mean>.

<sup><a id="fn.2" href="#fnr.2">2</a></sup> Cuando hablamos de *decimales correctos*, nos referimos a que son iguales a aquella
secuencia de d�gitos de \(\pi\) considerada como la de mayor exactitud. Ning�n m�todo puede
hallar \(\pi\) con todos sus infinitos decimales exactos.

<sup><a id="fn.3" href="#fnr.3">3</a></sup> En la web
<http://demonstrations.wolfram.com/GaussLegendreApproximationOfPi/>
se puede ver de forma interactiva c�mo aumentando los valores de *n*
el n�mero de decimales correctos es mayor.

<sup><a id="fn.4" href="#fnr.4">4</a></sup> Para m�s informaci�n sobre las f�rmulas de Machin, visitar
<http://en.wikipedia.org/wiki/Machin-like_formula>.
