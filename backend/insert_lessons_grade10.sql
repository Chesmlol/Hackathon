-- Xoá bản ghi trùng tên (nếu đã import trước đó bằng batch2), rồi chèn lại với difficulty='10'
DELETE FROM lessons WHERE title = 'Propositions and Sets';
DELETE FROM lessons WHERE title = 'Approximate Numbers and Errors';
DELETE FROM lessons WHERE title = 'Characteristic Numbers Measuring Central Tendency';
DELETE FROM lessons WHERE title = 'Counting Rules';
DELETE FROM lessons WHERE title = 'Permutations, Arrangements, and Combinations';
DELETE FROM lessons WHERE title = 'Newton''s Binomial Theorem';
DELETE FROM lessons WHERE title = 'Characteristic Numbers Measuring Dispersion';
DELETE FROM lessons WHERE title = 'Events and the Classical Definition of Probability';

INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Propositions and Sets', 'Mệnh đề, các phép toán logic và tập hợp — Lớp 10.', '', 'article', '10', '<h1 class="unnumbered" id="propositions-and-sets-grade-10">Propositions
and Sets – Grade 10</h1>
<h2 class="unnumbered" id="propositions">1. Propositions</h2>
<p>A <strong>proposition</strong> is a declarative sentence that is
either true (T) or false (F), but not both.</p>
<h3 class="unnumbered" id="logical-connectives">Logical Connectives</h3>
<ul>
<li><p>Negation: <span class="math inline">\(\neg p\)</span> (not <span
class="math inline">\(p\)</span>). Truth table: <span
class="math inline">\(p\)</span> T<span
class="math inline">\(\rightarrow\)</span>F, F<span
class="math inline">\(\rightarrow\)</span>T.</p></li>
<li><p>Conjunction: <span class="math inline">\(p\land q\)</span> (p and
q). True only when both <span class="math inline">\(p\)</span> and <span
class="math inline">\(q\)</span> are true.</p></li>
<li><p>Disjunction: <span class="math inline">\(p\lor q\)</span> (p or
q). False only when both <span class="math inline">\(p\)</span> and
<span class="math inline">\(q\)</span> are false.</p></li>
<li><p>Implication: <span class="math inline">\(p\rightarrow q\)</span>
(if <span class="math inline">\(p\)</span> then <span
class="math inline">\(q\)</span>). False only when <span
class="math inline">\(p\)</span> is true and <span
class="math inline">\(q\)</span> is false.</p></li>
<li><p>Biconditional: <span class="math inline">\(p\leftrightarrow
q\)</span> (p iff q). True when <span class="math inline">\(p\)</span>
and <span class="math inline">\(q\)</span> have the same truth
value.</p></li>
</ul>
<p><strong>Example:</strong> Let <span class="math inline">\(p\)</span>:
“It is raining.” <span class="math inline">\(q\)</span>: “The ground is
wet.” <span class="math display">\[p\rightarrow q \text{ reads “If it is
raining, then the ground is wet.”}\]</span></p>
<h3 class="unnumbered" id="logical-equivalences">Logical
Equivalences</h3>
<p><span class="math display">\[\begin{aligned}
    p\land q &amp;\equiv q\land p &amp;&amp;\text{(Commutative)}\\
    p\lor q &amp;\equiv q\lor p &amp;&amp;\text{(Commutative)}\\
    (p\land q)\land r &amp;\equiv p\land (q\land r)
&amp;&amp;\text{(Associative)}\\
    (p\lor q)\lor r &amp;\equiv p\lor (q\lor r)
&amp;&amp;\text{(Associative)}\\
    p\land (q\lor r) &amp;\equiv (p\land q)\lor (p\land r)
&amp;&amp;\text{(Distributive)}\\
    p\lor (q\land r) &amp;\equiv (p\lor q)\land (p\lor r)
&amp;&amp;\text{(Distributive)}\\
    \neg(\neg p) &amp;\equiv p &amp;&amp;\text{(Double Negation)}\\
    \neg(p\land q) &amp;\equiv \neg p\lor \neg q &amp;&amp;\text{(De
Morgan)}\\
    \neg(p\lor q) &amp;\equiv \neg p\land \neg q &amp;&amp;\text{(De
Morgan)}\\
    p\rightarrow q &amp;\equiv \neg p\lor q
&amp;&amp;\text{(Implication)}\\
    p\leftrightarrow q &amp;\equiv (p\rightarrow q)\land(q\rightarrow p)
&amp;&amp;\text{(Biconditional)}\\
\end{aligned}\]</span></p>
<h2 class="unnumbered" id="sets">2. Sets</h2>
<p>A <strong>set</strong> is a collection of distinct objects, called
<em>elements</em> or <em>members</em>.</p>
<h3 class="unnumbered" id="notation">Notation</h3>
<ul>
<li><p><span class="math inline">\(x\in A\)</span>: <span
class="math inline">\(x\)</span> is an element of <span
class="math inline">\(A\)</span>.</p></li>
<li><p><span class="math inline">\(x\notin A\)</span>: <span
class="math inline">\(x\)</span> is not an element of <span
class="math inline">\(A\)</span>.</p></li>
<li><p><span class="math inline">\(A\subseteq B\)</span>: every element
of <span class="math inline">\(A\)</span> is also in <span
class="math inline">\(B\)</span> (subset).</p></li>
<li><p><span class="math inline">\(A=B\)</span>: <span
class="math inline">\(A\subseteq B\)</span> and <span
class="math inline">\(B\subseteq A\)</span>.</p></li>
<li><p><span class="math inline">\(\emptyset\)</span>: the empty set (no
elements).</p></li>
<li><p><span class="math inline">\(U\)</span>: the universal set (all
objects under consideration).</p></li>
</ul>
<h3 class="unnumbered" id="operations">Operations</h3>
<p><span class="math display">\[\begin{aligned}
    A\cup B &amp;= \{x\mid x\in A \text{ or } x\in B\}
&amp;&amp;\text{(Union)}\\
    A\cap B &amp;= \{x\mid x\in A \text{ and } x\in B\}
&amp;&amp;\text{(Intersection)}\\
    A\setminus B &amp;= \{x\mid x\in A \text{ and } x\notin B\}
&amp;&amp;\text{(Difference)}\\
    \overline{A} &amp;= U\setminus A = \{x\in U\mid x\notin A\}
&amp;&amp;\text{(Complement)}
\end{aligned}\]</span></p>
<p><strong>Example:</strong> Let <span
class="math inline">\(U=\{1,2,3,4,5,6\}\)</span>, <span
class="math inline">\(A=\{1,2,3\}\)</span>, <span
class="math inline">\(B=\{3,4,5\}\)</span>. <span
class="math display">\[A\cup B=\{1,2,3,4,5\},\quad
A\cap B=\{3\},\quad
A\setminus B=\{1,2\},\quad
\overline{A}=\{4,5,6\}\]</span></p>
<h3 class="unnumbered" id="laws-of-set-algebra">Laws of Set Algebra</h3>
<p><span class="math display">\[\begin{aligned}
    A\cup B &amp;= B\cup A &amp;&amp;\text{(Commutative)}\\
    A\cap B &amp;= B\cap A &amp;&amp;\text{(Commutative)}\\
    (A\cup B)\cup C &amp;= A\cup (B\cup C)
&amp;&amp;\text{(Associative)}\\
    (A\cap B)\cap C &amp;= A\cap (B\cap C)
&amp;&amp;\text{(Associative)}\\
    A\cup (B\cap C) &amp;= (A\cup B)\cap (A\cup C)
&amp;&amp;\text{(Distributive)}\\
    A\cap (B\cup C) &amp;= (A\cap B)\cup (A\cap C)
&amp;&amp;\text{(Distributive)}\\
    A\cup \emptyset &amp;= A &amp;&amp;\text{(Identity)}\\
    A\cap U &amp;= A &amp;&amp;\text{(Identity)}\\
    A\cup \overline{A} &amp;= U &amp;&amp;\text{(Complement)}\\
    A\cap \overline{A} &amp;= \emptyset &amp;&amp;\text{(Complement)}\\
    \overline{\overline{A}} &amp;= A &amp;&amp;\text{(Double
Complement)}\\
    \overline{A\cup B} &amp;= \overline{A}\cap\overline{B}
&amp;&amp;\text{(De Morgan)}\\
    \overline{A\cap B} &amp;= \overline{A}\cup\overline{B}
&amp;&amp;\text{(De Morgan)}\\
\end{aligned}\]</span></p>
<h3 class="unnumbered"
id="inclusionexclusion-principle-two-sets">Inclusion–Exclusion Principle
(Two Sets)</h3>
<p><span class="math display">\[|A\cup B| = |A| + |B| - |A\cap
B|\]</span> where <span class="math inline">\(|\cdot|\)</span> denotes
the cardinality (number of elements).</p>
<p><strong>Example from context:</strong> <span
class="math inline">\(|A|=43\)</span>, <span
class="math inline">\(|B|=20\)</span>, <span
class="math inline">\(|A\cap B|=7\)</span>. <span
class="math display">\[|A\cup B| = 43+20-7 = 56\]</span></p>
<h2 class="unnumbered" id="connection-to-probability-brief">3.
Connection to Probability (Brief)</h2>
<p>When outcomes are equally likely, <span
class="math display">\[P(E)=\frac{|E|}{|U|}\]</span> and the
inclusion–exclusion rule for probabilities is <span
class="math display">\[P(A\cup B)=P(A)+P(B)-P(A\cap B).\]</span></p>
<p><strong>Example from context:</strong> 10 people randomly choose one
of 5 train cars. Let <span class="math inline">\(A\)</span> = “first car
empty”, <span class="math inline">\(B\)</span> = “second car empty”.
<span
class="math display">\[P(A)=P(B)=\left(\frac{4}{5}\right)^{10},\quad
P(A\cap B)=\left(\frac{3}{5}\right)^{10},\quad
P(A\cup
B)=2\left(\frac{4}{5}\right)^{10}-\left(\frac{3}{5}\right)^{10}.\]</span></p>
<h2 class="unnumbered" id="practice-problems">4. Practice Problems</h2>
<ol>
<li><p><strong>Propositional Logic</strong> Determine the truth value of
the compound proposition <span class="math display">\[\big[(p\rightarrow
q)\land(\neg r)\big]\rightarrow\big[(p\lor q)\leftrightarrow
r\big]\]</span> when <span class="math inline">\(p\)</span> is true,
<span class="math inline">\(q\)</span> is false, and <span
class="math inline">\(r\)</span> is true.</p></li>
<li><p><strong>Set Operations</strong> Let <span
class="math inline">\(U=\{a,b,c,d,e,f,g,h\}\)</span>, <span
class="math inline">\(X=\{a,b,c,d\}\)</span>, <span
class="math inline">\(Y=\{c,d,e,f\}\)</span>, <span
class="math inline">\(Z=\{f,g,h\}\)</span>. Compute:</p>
<ol>
<li><p><span class="math inline">\(X\cup Y\)</span></p></li>
<li><p><span class="math inline">\(Y\cap Z\)</span></p></li>
<li><p><span class="math inline">\(X\setminus Z\)</span></p></li>
<li><p><span class="math inline">\(\overline{Y}\)</span></p></li>
</ol></li>
<li><p><strong>Inclusion–Exclusion</strong> In a class of 30 students,
18 like mathematics, 12 like physics, and 5 like both subjects. How many
students like at least one of the two subjects?</p></li>
<li><p><strong>Probability with Sets</strong> A bag contains 6 red, 4
blue, and 5 green marbles. Two marbles are drawn without replacement.
Let <span class="math inline">\(A\)</span> = “first marble is red”,
<span class="math inline">\(B\)</span> = “second marble is blue”. Find
<span class="math inline">\(P(A\cup B)\)</span>.</p></li>
<li><p><strong>Logical Equivalence</strong> Show, using a truth table,
that <span class="math inline">\(\neg(p\land q)\)</span> is logically
equivalent to <span class="math inline">\(\neg p\lor \neg
q\)</span>.</p></li>
</ol>
<h2 class="unnumbered" id="solutions">5. Solutions</h2>
<ol>
<li><p><span class="math display">\[\begin{aligned}
            p\rightarrow q &amp;\equiv \neg p\lor q =
\text{F}\lor\text{F}= \text{F}\\
            \neg r &amp;\equiv \text{F}\\
            (p\rightarrow q)\land(\neg r) &amp;\equiv
\text{F}\land\text{F}= \text{F}\\
            p\lor q &amp;\equiv \text{T}\lor\text{F}= \text{T}\\
            (p\lor q)\leftrightarrow r &amp;\equiv
\text{T}\leftrightarrow\text{T}= \text{T}\\
            \text{Implication antecedent false} &amp;\Rightarrow
\text{whole statement is True.}
        
\end{aligned}\]</span> Hence the compound proposition is
<strong>True</strong>.</p></li>
<li><ol>
<li><p><span class="math inline">\(X\cup Y =
\{a,b,c,d,e,f\}\)</span></p></li>
<li><p><span class="math inline">\(Y\cap Z = \{f\}\)</span></p></li>
<li><p><span class="math inline">\(X\setminus Z = \{a,b,c,d\}\)</span>
(since none of <span class="math inline">\(a,b,c,d\)</span> are in <span
class="math inline">\(Z\)</span>)</p></li>
<li><p><span class="math inline">\(\overline{Y}=U\setminus Y =
\{a,b,g,h\}\)</span></p></li>
</ol></li>
<li><p>Using inclusion–exclusion: <span
class="math display">\[|\text{Math}\cup\text{Phys}| = 18+12-5 =
25.\]</span> So 25 students like at least one subject.</p></li>
<li><p>Total marbles <span class="math inline">\(=6+4+5=15\)</span>.
<span class="math display">\[P(A)=\frac{6}{15}=\frac{2}{5}.\]</span>
After drawing a red first, 14 marbles remain, with 4 blue still. <span
class="math display">\[P(B\mid A)=\frac{4}{14}=\frac{2}{7}.\]</span>
Hence <span class="math display">\[P(A\cap B)=P(A)\,P(B\mid
A)=\frac{2}{5}\cdot\frac{2}{7}=\frac{4}{35}.\]</span> For <span
class="math inline">\(P(B)\)</span> we consider both cases (first red or
not red): <span
class="math display">\[P(B)=\frac{6}{15}\cdot\frac{4}{14}+\frac{9}{15}\cdot\frac{4}{14}
        =\frac{24}{210}+\frac{36}{210}=\frac{60}{210}=\frac{2}{7}.\]</span>
Finally, <span class="math display">\[P(A\cup B)=P(A)+P(B)-P(A\cap
B)=\frac{2}{5}+\frac{2}{7}-\frac{4}{35}
        =\frac{14}{35}+\frac{10}{35}-\frac{4}{35}
        =\frac{20}{35}=\frac{4}{7}.\]</span></p></li>
<li><p>Truth table: <span
class="math display">\[\begin{array}{c|c|c|c|c}
        p&amp;q&amp;p\land q&amp;\neg(p\land q)&amp;\neg p\lor\neg
q\\\hline
        \text{T}&amp;\text{T}&amp;\text{T}&amp;\text{F}&amp;\text{F}\\
        \text{T}&amp;\text{F}&amp;\text{F}&amp;\text{T}&amp;\text{T}\\
        \text{F}&amp;\text{T}&amp;\text{F}&amp;\text{T}&amp;\text{T}\\
        \text{F}&amp;\text{F}&amp;\text{F}&amp;\text{T}&amp;\text{T}
        \end{array}\]</span> The columns for <span
class="math inline">\(\neg(p\land q)\)</span> and <span
class="math inline">\(\neg p\lor\neg q\)</span> are identical,
establishing the equivalence.</p></li>
</ol>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Approximate Numbers and Errors', 'Số gần đúng, sai số tuyệt đối và sai số tương đối.', '', 'article', '10', '<h1 class="unnumbered"
id="approximating-numbers-and-understanding-errors">Approximating
Numbers and Understanding Errors</h1>
<h2 class="unnumbered" id="why-approximate">Why Approximate?</h2>
<p>In real life we often deal with measurements that are not exact, or
with numbers that have infinitely many decimal places (like <span
class="math inline">\(\pi\)</span> or <span
class="math inline">\(\sqrt{2}\)</span>). Approximating lets us work
with numbers that are close enough for a given purpose while keeping
calculations manageable.</p>
<h2 class="unnumbered" id="ways-to-approximate">Ways to Approximate</h2>
<ol>
<li><p><strong>Rounding to a given place value</strong><br />
Example: Round <span class="math inline">\(3.14159\)</span> to the
nearest hundredth: <span class="math inline">\(3.14\)</span>.</p></li>
<li><p><strong>Rounding to a given number of significant
figures</strong><br />
Significant figures count all non‑zero digits and any zeros between them
or after the decimal point if they follow a non‑zero digit.<br />
Example: <span class="math inline">\(0.004560\)</span> has four
significant figures. Rounded to two significant figures gives <span
class="math inline">\(0.0046\)</span>.</p></li>
<li><p><strong>Using truncation (cutting off)</strong><br />
Simply discard digits beyond the desired place without rounding.<br />
Example: Truncate <span class="math inline">\(2.71828\)</span> after
three decimal places: <span
class="math inline">\(2.718\)</span>.</p></li>
</ol>
<h2 class="unnumbered" id="error-concepts">Error Concepts</h2>
<p>When we replace an exact number <span
class="math inline">\(x\)</span> by an approximation <span
class="math inline">\(\tilde{x}\)</span> we introduce an error.</p>
<ul>
<li><p><strong>Absolute error</strong>: <span
class="math inline">\(E_{a}=|x-\tilde{x}|\)</span>.</p></li>
<li><p><strong>Relative error</strong>: <span
class="math inline">\(E_{r}= \dfrac{|x-\tilde{x}|}{|x|}\)</span>
(provided <span class="math inline">\(x\neq0\)</span>).</p></li>
<li><p><strong>Percent error</strong>: <span
class="math inline">\(E_{\%}=E_{r}\times 100\%\)</span>.</p></li>
</ul>
<p>These tell us how far off our approximation is, relative to the size
of the true value.</p>
<h2 class="unnumbered"
id="propagation-of-errors-in-simple-calculations">Propagation of Errors
in Simple Calculations</h2>
<p>If we approximate each input before computing, the total error can be
bounded by adding the absolute errors (for sums) or using relative
errors (for products). For a grade‑10 treatment we use the simple rules:
<span class="math display">\[\begin{aligned}
\text{For }z = x+y &amp;: \quad |E_{z}|\le |E_{x}|+|E_{y}|.\\[4pt]
\text{For }z = x\cdot y &amp;: \quad \frac{|E_{z}|}{|z|}\approx
\frac{|E_{x}|}{|x|}+\frac{|E_{y}|}{|y|}.
\end{aligned}\]</span> These are first‑order approximations; they work
well when the individual errors are small.</p>
<h2 class="unnumbered" id="examples">Examples</h2>
<ol>
<li><p><strong>Rounding and error</strong><br />
The true length of a rod is <span class="math inline">\(12.378\)</span>
cm. We measure it with a ruler marked in millimetres and record <span
class="math inline">\(12.4\)</span> cm. <span
class="math display">\[\begin{aligned}
   \tilde{x}&amp;=12.4\text{ cm}\\
   E_{a}&amp;=|12.378-12.4|=0.022\text{ cm}\\
   E_{r}&amp;=\frac{0.022}{12.378}\approx0.00178\\
   E_{\%}&amp;\approx0.178\%
   \end{aligned}\]</span></p></li>
<li><p><strong>Significant figures in a product</strong><br />
Compute the area of a rectangle with sides <span
class="math inline">\(5.2\)</span> m (2 s.f.) and <span
class="math inline">\(3.14\)</span> m (3 s.f.). The raw product is <span
class="math inline">\(5.2\times3.14=16.328\)</span> m<span
class="math inline">\(^2\)</span>. The least precise factor has 2 s.f.,
so we round the result to 2 s.f.: <span
class="math inline">\(1.6\times10^{1}\)</span> m<span
class="math inline">\(^2\)</span> (i.e., <span
class="math inline">\(16\)</span> m<span
class="math inline">\(^2\)</span>). The absolute error due to rounding
is at most half of the last retained place: <span
class="math inline">\(0.5\)</span> m<span
class="math inline">\(^2\)</span>. Relative error <span
class="math inline">\(\approx0.5/16\approx0.031\)</span> or <span
class="math inline">\(3.1\%\)</span>.</p></li>
</ol>
<h2 class="unnumbered" id="practice-problems">Practice Problems</h2>
<ol>
<li><p>A student measures the mass of a sample as <span
class="math inline">\(23.45\)</span> g using a balance that reads to the
nearest <span class="math inline">\(0.01\)</span> g. The true mass is
<span class="math inline">\(23.48\)</span> g. Find the absolute,
relative, and percent errors.</p></li>
<li><p>The circumference of a circle is measured as <span
class="math inline">\(31.4\)</span> cm (rounded to the nearest tenth).
Using <span class="math inline">\(\pi\approx3.14\)</span>, estimate the
radius and give the answer with an appropriate number of significant
figures. Compute the absolute error in the radius if the true radius is
<span class="math inline">\(5.00\)</span> cm.</p></li>
<li><p>Approximate <span class="math inline">\(\sqrt{2}\)</span> to
three decimal places. Using this approximation, compute the diagonal of
a square with side length <span class="math inline">\(7.0\)</span> cm.
State the diagonal with the correct number of significant figures and
give the percent error compared with the exact diagonal <span
class="math inline">\(7\sqrt{2}\)</span> cm.</p></li>
</ol>
<h2 class="unnumbered" id="solutions">Solutions</h2>
<ol>
<li><p>True value <span class="math inline">\(x=23.48\)</span> g,
approximation <span class="math inline">\(\tilde{x}=23.45\)</span> g.
<span class="math display">\[E_{a}=|23.48-23.45|=0.03\text{ g},\qquad
   E_{r}=\frac{0.03}{23.48}\approx0.00128,\qquad
   E_{\%}\approx0.128\%.\]</span></p></li>
<li><p>Measured circumference <span
class="math inline">\(C=31.4\)</span> cm (implies <span
class="math inline">\(C\)</span> is known to <span
class="math inline">\(\pm0.05\)</span> cm). Radius formula: <span
class="math inline">\(r=\dfrac{C}{2\pi}\)</span>. Using <span
class="math inline">\(\pi\approx3.14\)</span>: <span
class="math display">\[r\approx\frac{31.4}{2\times3.14}=
\frac{31.4}{6.28}=5.00\text{ cm}.\]</span> The division involves three
significant figures (31.4 has three, 6.28 has three), so we keep three
s.f.: <span class="math inline">\(5.00\)</span> cm. True radius <span
class="math inline">\(r_{\text{true}}=5.00\)</span> cm (given). Absolute
error in radius: <span class="math inline">\(|5.00-5.00|=0.00\)</span>
cm (the approximation happens to be exact to the displayed precision).
If we instead used the exact <span class="math inline">\(\pi\)</span>:
<span
class="math inline">\(r_{\text{exact}}=31.4/(2\pi)\approx5.00\)</span>
cm as well, so the error remains negligible (&lt;0.01%).</p></li>
<li><p><span class="math inline">\(\sqrt{2}\approx1.414\)</span> (three
decimal places). Diagonal <span class="math inline">\(d =
s\sqrt{2}\)</span> with <span class="math inline">\(s=7.0\)</span> cm
(two s.f.). Using the approximation: <span
class="math display">\[d_{\text{approx}} = 7.0\times1.414 = 9.898\text{
cm}.\]</span> The factor with the fewest s.f. is <span
class="math inline">\(7.0\)</span> (two s.f.), so we round the product
to two s.f.: <span class="math inline">\(9.9\)</span> cm. Exact
diagonal: <span class="math inline">\(d_{\text{exact}} =
7\sqrt{2}\approx 9.8995\)</span> cm. Absolute error: <span
class="math inline">\(|9.8995-9.898|=0.0015\)</span> cm. Percent error:
<span
class="math inline">\(\dfrac{0.0015}{9.8995}\times100\%\approx0.015\%\)</span>.</p></li>
</ol>
<h2 class="unnumbered" id="summary">Summary</h2>
<ul>
<li><p>Approximation simplifies numbers but introduces error.</p></li>
<li><p>Absolute, relative, and percent errors quantify the
difference.</p></li>
<li><p>When rounding, keep track of significant figures to avoid
overstating precision.</p></li>
<li><p>For sums, add absolute errors; for products, add relative errors
(first‑order estimate).</p></li>
</ul>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Characteristic Numbers Measuring Central Tendency', 'Số trung bình, trung vị, mốt và các số đặc trưng đo xu hướng trung tâm.', '', 'article', '10', '<h1 class="unnumbered"
id="characteristic-numbers-that-measure-central-tendency">Characteristic
Numbers that Measure Central Tendency</h1>
<h2 class="unnumbered" id="introduction">Introduction</h2>
<p>In statistics, a <strong>characteristic number</strong> (or
<strong>measure of central tendency</strong>) is a single value that
attempts to describe the centre of a data set. For high‑school students
the most common measures are the <strong>arithmetic mean</strong>, the
<strong>median</strong>, and the <strong>mode</strong>. Additional
useful numbers include the <strong>weighted mean</strong>,
<strong>geometric mean</strong>, and <strong>harmonic mean</strong>.
Each has its own strengths, weaknesses, and appropriate situations.</p>
<h2 class="unnumbered" id="definitions">Definitions</h2>
<ul>
<li><p><strong>Arithmetic Mean (<span
class="math inline">\(\bar{x}\)</span>)</strong>: <span
class="math display">\[\displaystyle
\bar{x}=\frac{1}{n}\sum_{i=1}^{n}x_i\]</span> where <span
class="math inline">\(x_1,\dots,x_n\)</span> are the observations and
<span class="math inline">\(n\)</span> is the sample size.</p></li>
<li><p><strong>Median (<span class="math inline">\(M\)</span>)</strong>:
The middle value after ordering the data from smallest to largest. If
<span class="math inline">\(n\)</span> is odd, <span
class="math inline">\(M=x_{(\frac{n+1}{2})}\)</span>; if <span
class="math inline">\(n\)</span> is even, <span
class="math display">\[M=\frac{x_{(\frac{n}{2})}+x_{(\frac{n}{2}+1)}}{2}.\]</span></p></li>
<li><p><strong>Mode</strong>: The value that occurs most frequently. A
data set may have no mode, one mode (unimodal), or several modes
(multimodal).</p></li>
<li><p><strong>Weighted Mean (<span
class="math inline">\(\bar{x}_w\)</span>)</strong>: When observations
<span class="math inline">\(x_i\)</span> carry weights <span
class="math inline">\(w_i&gt;0\)</span>, <span
class="math display">\[\displaystyle \bar{x}_w=\frac{\sum_{i=1}^{n}w_i
x_i}{\sum_{i=1}^{n}w_i}.\]</span></p></li>
<li><p><strong>Geometric Mean (<span
class="math inline">\(G\)</span>)</strong>: For positive data, <span
class="math display">\[\displaystyle
G=\Bigl(\prod_{i=1}^{n}x_i\Bigr)^{1/n}
        =\exp\!\Bigl(\frac{1}{n}\sum_{i=1}^{n}\ln
x_i\Bigr).\]</span></p></li>
<li><p><strong>Harmonic Mean (<span
class="math inline">\(H\)</span>)</strong>: For positive data, <span
class="math display">\[\displaystyle
H=\frac{n}{\sum_{i=1}^{n}\frac{1}{x_i}}.\]</span></p></li>
</ul>
<h2 class="unnumbered" id="properties-and-interpretation">Properties and
Interpretation</h2>
<ol>
<li><p>The arithmetic mean is <strong>sensitive to outliers</strong>; a
single extreme value can shift it considerably.</p></li>
<li><p>The median is <strong>robust</strong> to outliers; it depends
only on the order of the data.</p></li>
<li><p>The mode is useful for <strong>categorical or discrete
data</strong> where we want the most common category.</p></li>
<li><p>For positively skewed data (long right tail), typically <span
class="math display">\[\text{Mode}&lt;\text{Median}&lt;\bar{x}.\]</span>
For negatively skewed data the inequality reverses.</p></li>
<li><p>The weighted mean reduces to the ordinary mean when all <span
class="math inline">\(w_i=1\)</span>.</p></li>
<li><p>The geometric mean is appropriate for data that grow
multiplicatively (e.g., growth rates, indices).</p></li>
<li><p>The harmonic mean is useful when averaging rates (e.g., speeds,
densities).</p></li>
</ol>
<h2 class="unnumbered" id="choosing-a-measure">Choosing a Measure</h2>
<ul>
<li><p>Use the <strong>mean</strong> when the data are roughly symmetric
and free of extreme outliers.</p></li>
<li><p>Use the <strong>median</strong> when the data are skewed or
contain outliers.</p></li>
<li><p>Use the <strong>mode</strong> for nominal data or to identify the
most frequent category the identify the most common value.</p></li>
<li><p>Use the <strong>weighted mean</strong> when observations have
different importance or reliability.</p></li>
<li><p>Use the <strong>geometric mean</strong> for percentages, growth
factors, or ratios.</p></li>
<li><p>Use the <strong>harmonic mean</strong> for averaging speeds,
rates, or densities.</p></li>
</ul>
<h2 class="unnumbered" id="worked-examples">Worked Examples</h2>
<h3 class="unnumbered" id="example-1-mean-median-mode">Example 1: Mean,
Median, Mode</h3>
<p>A teacher recorded the scores (out of 20) of 9 students on a quiz:
<span
class="math display">\[12,\;15,\;14,\;13,\;15,\;16,\;12,\;15,\;18.\]</span></p>
<ul>
<li><p><strong>Mean</strong>: <span
class="math display">\[\bar{x}=\frac{12+15+14+13+15+16+12+15+18}{9}
        =\frac{130}{9}\approx14.44.\]</span></p></li>
<li><p><strong>Median</strong>: Order the data: <span
class="math inline">\(12,12,13,14,15,15,15,16,18\)</span>. The 5th value
(middle) is <span class="math inline">\(15\)</span>, so <span
class="math inline">\(M=15\)</span>.</p></li>
<li><p><strong>Mode</strong>: The value <span
class="math inline">\(15\)</span> appears three times, more than any
other; thus mode <span class="math inline">\(=15\)</span>.</p></li>
</ul>
<p>Notice that the mean is slightly lower than the median because of the
two low scores (12).</p>
<h3 class="unnumbered" id="example-2-weighted-mean">Example 2: Weighted
Mean</h3>
<p>Suppose a final grade is composed of homework (weight <span
class="math inline">\(0.3\)</span>), midterm (weight <span
class="math inline">\(0.2\)</span>), and final exam (weight <span
class="math inline">\(0.5\)</span>). A student obtains: <span
class="math display">\[\begin{aligned}
  \text{Homework}&amp;=85,\\
  \text{Midterm}&amp;=78,\\
  \text{Final exam}&amp;=92.
\end{aligned}\]</span> The weighted mean is <span
class="math display">\[\displaystyle \bar{x}_w=
\frac{0.3\cdot85+0.2\cdot78+0.5\cdot92}{0.3+0.2+0.5}
= \frac{25.5+15.6+46}{1}=87.1.\]</span></p>
<h3 class="unnumbered" id="example-3-geometric-mean">Example 3:
Geometric Mean</h3>
<p>An investment grows by <span class="math inline">\(5\%\)</span>,
<span class="math inline">\(-2\%\)</span>, and <span
class="math inline">\(10\%\)</span> over three successive years. The
growth factors are <span class="math inline">\(1.05\)</span>, <span
class="math inline">\(0.98\)</span>, and <span
class="math inline">\(1.10\)</span>. The geometric mean of the factors
is <span class="math display">\[\displaystyle
G=(1.05\times0.98\times1.10)^{1/3}
   \approx (1.1319)^{1/3}\approx1.042.\]</span> Thus the average annual
growth rate is about <span class="math inline">\(4.2\%\)</span>.</p>
<h3 class="unnumbered" id="example-4-harmonic-mean">Example 4: Harmonic
Mean</h3>
<p>A car travels <span class="math inline">\(60\)</span> km at <span
class="math inline">\(40\)</span> km/h, then another <span
class="math inline">\(60\)</span> km at <span
class="math inline">\(60\)</span> km/h. The average speed for the whole
trip is the harmonic mean of the two speeds (because the distances are
equal): <span class="math display">\[\displaystyle
H=\frac{2}{\frac{1}{40}+\frac{1}{60}}
   =\frac{2}{\frac{3+2}{120}}=\frac{2}{\frac{5}{120}}
   =\frac{2\cdot120}{5}=48\text{ km/h}.\]</span></p>
<h2 class="unnumbered" id="practice-problems">Practice Problems</h2>
<ol>
<li><p>Find the mean, median, and mode for the data set: <span
class="math display">\[5,\;8,\;8,\;10,\;12,\;12,\;12,\;15,\;20.\]</span></p></li>
<li><p>A student’s scores on four tests are <span
class="math inline">\(78\)</span>, <span
class="math inline">\(85\)</span>, <span
class="math inline">\(90\)</span>, and <span
class="math inline">\(92\)</span>. If the first two tests each count for
<span class="math inline">\(25\%\)</span> of the final grade and the
last two each count for <span class="math inline">\(25\%\)</span> as
well (i.e., equal weights), what is the weighted mean? What would it be
if the first test counted <span class="math inline">\(20\%\)</span>, the
second <span class="math inline">\(30\%\)</span>, the third <span
class="math inline">\(20\%\)</span>, and the fourth <span
class="math inline">\(30\%\)</span>?</p></li>
<li><p>The price of a stock changed by <span
class="math inline">\(+12\%\)</span>, <span
class="math inline">\(-8\%\)</span>, <span
class="math inline">\(+15\%\)</span>, and <span
class="math inline">\(-5\%\)</span> over four months. Compute the
geometric mean of the monthly growth factors and interpret the result as
an average monthly percent change.</p></li>
<li><p>A cyclist rides <span class="math inline">\(30\)</span> km at
<span class="math inline">\(20\)</span> km/h, then <span
class="math inline">\(30\)</span> km at <span
class="math inline">\(30\)</span> km/h, and finally <span
class="math inline">\(30\)</span> km at <span
class="math inline">\(10\)</span> km/h. What is the harmonic mean of the
three speeds? What is the actual average speed for the <span
class="math inline">\(90\)</span> km trip? (Hint: use total distance
divided by total time.)</p></li>
</ol>
<h2 class="unnumbered" id="solutions">Solutions</h2>
<ol>
<li><ul>
<li><p>Mean: <span class="math inline">\(\displaystyle
\bar{x}=\frac{5+8+8+10+12+12+12+15+20}{9}
                 =\frac{102}{9}\approx11.33.\)</span></p></li>
<li><p>Median: Ordered data are <span
class="math inline">\(5,8,8,10,12,12,12,15,20\)</span>; the 5th value is
<span class="math inline">\(12\)</span>, so <span
class="math inline">\(M=12\)</span>.</p></li>
<li><p>Mode: The value <span class="math inline">\(12\)</span> appears
three times, more than any other; mode <span
class="math inline">\(=12\)</span>.</p></li>
</ul></li>
<li><ul>
<li><p>Equal weights (<span class="math inline">\(0.25\)</span> each):
<span class="math display">\[\displaystyle \bar{x}_w=
                0.25\cdot78+0.25\cdot85+0.25\cdot90+0.25\cdot92
                =19.5+21.25+22.5+23=86.25.\]</span></p></li>
<li><p>Unequal weights (<span
class="math inline">\(0.20,0.30,0.20,0.30\)</span>): <span
class="math display">\[\displaystyle \bar{x}_w=
                0.20\cdot78+0.30\cdot85+0.20\cdot90+0.30\cdot92
                =15.6+25.5+18+27.6=86.7.\]</span></p></li>
</ul></li>
<li><p>Growth factors: <span
class="math inline">\(1.12,\;0.92,\;1.15,\;0.95\)</span>. <span
class="math display">\[\displaystyle
G=(1.12\times0.92\times1.15\times0.95)^{1/4}
          \approx(1.124)^{1/4}\approx1.0298.\]</span> The average
monthly growth factor is about <span
class="math inline">\(1.0298\)</span>, i.e., an average monthly increase
of approximately <span class="math inline">\(2.98\%\)</span>.</p></li>
<li><p>Harmonic mean of <span class="math inline">\(20\)</span>, <span
class="math inline">\(30\)</span>, <span
class="math inline">\(10\)</span> km/h: <span
class="math display">\[\displaystyle
H=\frac{3}{\frac{1}{20}+\frac{1}{30}+\frac{1}{10}}
          =\frac{3}{\frac{3+2+6}{60}}
          =\frac{3}{\frac{11}{60}}
          =\frac{180}{11}\approx16.36\text{ km/h}.\]</span> Actual
average speed: total distance <span class="math inline">\(=90\)</span>
km. Times: <span class="math inline">\(t_1=\frac{30}{20}=1.5\)</span> h,
<span class="math inline">\(t_2=\frac{30}{30}=1\)</span> h, <span
class="math inline">\(t_3=\frac{30}{10}=3\)</span> h. Total time <span
class="math inline">\(=1.5+1+3=5.5\)</span> h. Average speed <span
class="math inline">\(=\frac{90}{5.5}\approx16.36\)</span> km/h, which
matches the harmonic mean because the distances for each segment are
equal.</p></li>
</ol>
<h2 class="unnumbered" id="summary">Summary</h2>
<p>Measures of central tendency provide a concise description of where
the “middle’’ of a data set lies. The arithmetic mean is the most
familiar but can be distorted by extreme values; the median resists such
distortion; the mode highlights the most frequent observation. Weighted,
geometric, and harmonic means extend the idea to situations where
observations have differing importance, grow multiplicatively, or
represent rates. Selecting the appropriate measure depends on the data’s
distribution, the presence of outliers, and the context of the
problem.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Counting Rules', 'Quy tắc đếm cơ bản (quy tắc cộng, quy tắc nhân) — Lớp 10.', '', 'article', '10', '<h1 class="unnumbered" id="counting-rules-grade-10">Counting Rules –
Grade 10</h1>
<h2 class="unnumbered" id="fundamental-counting-principle">Fundamental
Counting Principle</h2>
<p>If one task can be performed in <span
class="math inline">\(m\)</span> ways and, for each way of performing
the first task, a second task can be performed in <span
class="math inline">\(n\)</span> ways, then the two tasks together can
be performed in <span class="math inline">\(m\cdot n\)</span> ways. This
principle extends to any finite number of tasks: <span
class="math display">\[\text{Number of ways}=n_1\times
n_2\times\cdots\times n_k.\]</span></p>
<p><strong>Example 1 (from context).</strong> In a chicken coop problem
there are two independent choices: choosing a chicken from coop I and
choosing a chicken from coop II. Coop I has <span
class="math inline">\(5\)</span> roosters and <span
class="math inline">\(10\)</span> hens <span
class="math inline">\(\rightarrow\)</span> <span
class="math inline">\(15\)</span> possibilities. Coop II has <span
class="math inline">\(3\)</span> hens and <span
class="math inline">\(7\)</span> roosters <span
class="math inline">\(\rightarrow\)</span> <span
class="math inline">\(10\)</span> possibilities. Hence the total number
of ordered pairs (chicken from I, chicken from II) is <span
class="math inline">\(15\times10=150\)</span>.</p>
<h2 class="unnumbered" id="permutations">Permutations</h2>
<p>A permutation is an arrangement of objects in a specific order. The
number of permutations of <span class="math inline">\(n\)</span>
distinct objects taken <span class="math inline">\(r\)</span> at a time
is <span class="math display">\[P(n,r)=\frac{n!}{(n-r)!}=n\,(n-1)\cdots
(n-r+1).\]</span></p>
<p><strong>Example 2.</strong> From the context: “<span
class="math inline">\(\Omega = 10!\)</span> … Favourable arrangements
(females at seats 1,4,7,10) = <span
class="math inline">\(6!\cdot4!\)</span>”. Here we first choose which
<span class="math inline">\(4\)</span> of the <span
class="math inline">\(10\)</span> seats are occupied by females (fixed
seats 1,4,7,10) and then arrange the <span
class="math inline">\(4\)</span> females in those seats (<span
class="math inline">\(4!\)</span> ways) and the <span
class="math inline">\(6\)</span> males in the remaining seats (<span
class="math inline">\(6!\)</span> ways). Thus the number of favourable
arrangements is <span class="math inline">\(6!\times4!\)</span>.</p>
<h2 class="unnumbered" id="combinations">Combinations</h2>
<p>A combination is a selection of objects where order does not matter.
The number of ways to choose <span class="math inline">\(r\)</span>
objects from <span class="math inline">\(n\)</span> distinct objects is
<span class="math display">\[\binom{n}{r}=
\frac{n!}{r!\,(n-r)!}.\]</span></p>
<p><strong>Example 3 (drawing balls).</strong> From the context:
“Drawing 4 balls from 7 black +5 white: <span
class="math inline">\(|\Omega| = C(12,4)=495\)</span>”. Here the total
number of unordered selections of <span class="math inline">\(4\)</span>
balls from <span class="math inline">\(12\)</span> is <span
class="math inline">\(\binom{12}{4}=495\)</span>.</p>
<h2 class="unnumbered" id="addition-principle">Addition Principle</h2>
<p>If two events <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are mutually exclusive (cannot happen
together), then <span class="math display">\[|A\cup B| =
|A|+|B|.\]</span> If they are not mutually exclusive we use the
Inclusion–Exclusion Principle.</p>
<h2 class="unnumbered"
id="inclusionexclusion-principle">Inclusion–Exclusion Principle</h2>
<p>For two events: <span class="math display">\[|A\cup B| =
|A|+|B|-|A\cap B|.\]</span> For three events: <span
class="math display">\[|A\cup B\cup C| = |A|+|B|+|C|
               -|A\cap B|-|A\cap C|-|B\cap C|
               +|A\cap B\cap C|.\]</span></p>
<p><strong>Example 4 (from context).</strong> “Class of 40 students (4
groups, each 4 boys,6 girls): P(boy or from group 4) = (16+10-4)/40 =
22/40 = 11/20.” Let <span class="math inline">\(B\)</span> = “student is
a boy”, <span class="math inline">\(G_4\)</span> = “student belongs to
group 4”. <span class="math inline">\(|B|=16\)</span> (4 groups <span
class="math inline">\(\times\)</span> 4 boys), <span
class="math inline">\(|G_4|=10\)</span> (6 girls+4 boys in group 4),
<span class="math inline">\(|B\cap G_4|=4\)</span> (the boys in group
4). Hence <span class="math inline">\(|B\cup G_4|=16+10-4=22\)</span>,
giving probability <span class="math inline">\(22/40=11/20\)</span>.</p>
<h2 class="unnumbered" id="complement-rule">Complement Rule</h2>
<p>For any event <span class="math inline">\(A\)</span>, <span
class="math display">\[P(A&#39;)=1-P(A).\]</span> This is used
frequently when it is easier to count the opposite outcome.</p>
<p><strong>Example 5.</strong> From the context: “P(A’) = 1 - P(A).” If
<span class="math inline">\(P(A)=1/3\)</span> then <span
class="math inline">\(P(A&#39;)=2/3\)</span>.</p>
<h2 class="unnumbered" id="practice-problems">Practice Problems</h2>
<ol>
<li><p><strong>Permutation with restriction.</strong> Ten students are
to be seated in a row. Two particular students, Huyền and Quang, must
sit next to each other. How many seating arrangements satisfy this
condition?<br />
<strong>Solution.</strong> Treat Huyền and Quang as a block. The block
can be arranged in <span class="math inline">\(2!\)</span> ways
(Huyền‑Quang or Quang‑Huyền). Now we have <span
class="math inline">\(9\)</span> objects to arrange (the block + the
other <span class="math inline">\(8\)</span> students): <span
class="math inline">\(9!\)</span> ways. Total <span
class="math inline">\(=2!\times9! = 2\times362880 =
725760\)</span>.</p></li>
<li><p><strong>Combination – selecting chickens.</strong> From coop I (5
roosters, 10 hens) choose 2 chickens; from coop II (3 hens, 7 roosters)
choose 1 chicken. How many possible selections (order within each coop
does not matter)?<br />
<strong>Solution.</strong> Coop I: <span
class="math inline">\(\binom{15}{2}=105\)</span> ways. Coop II: <span
class="math inline">\(\binom{10}{1}=10\)</span> ways. By the
multiplication principle, total <span class="math inline">\(=105\times10
= 1050\)</span> selections.</p></li>
<li><p><strong>Inclusion–Exclusion – drawing cards.</strong> Three cards
are drawn without replacement from a standard 52‑card deck. Find the
probability that none of the three cards is a heart.<br />
<strong>Solution.</strong> There are <span
class="math inline">\(13\)</span> hearts, so <span
class="math inline">\(39\)</span> non‑hearts. Number of ways to choose
<span class="math inline">\(3\)</span> non‑hearts: <span
class="math inline">\(\binom{39}{3}=9139\)</span>. Total ways to choose
any <span class="math inline">\(3\)</span> cards: <span
class="math inline">\(\binom{52}{3}=22100\)</span>. Hence <span
class="math inline">\(P(\text{no heart}) =
\dfrac{9139}{22100}\approx0.4135\)</span>.</p></li>
<li><p><strong>Complement – dice product.</strong> Two fair dice are
rolled. What is the probability that the product of the two numbers is
odd?<br />
<strong>Solution.</strong> The product is odd only when both dice show
odd numbers. Each die has <span class="math inline">\(3\)</span> odd
faces, so <span class="math inline">\(P(\text{odd on one
die})=3/6=1/2\)</span>. By independence, <span
class="math inline">\(P(\text{both odd}) =
(1/2)\times(1/2)=1/4\)</span>. Thus <span
class="math inline">\(P(\text{product odd}) = 1/4\)</span>. (Using
complement: <span class="math inline">\(P(\text{product
even})=1-1/4=3/4\)</span>.)</p></li>
<li><p><strong>Counting with groups – from context.</strong> A class has
<span class="math inline">\(40\)</span> students divided into <span
class="math inline">\(4\)</span> groups of <span
class="math inline">\(10\)</span> each, each group containing <span
class="math inline">\(4\)</span> boys and <span
class="math inline">\(6\)</span> girls. Find the probability that a
randomly chosen student is either a boy or belongs to group 4.<br />
<strong>Solution.</strong> Number of boys: <span
class="math inline">\(4\times4=16\)</span>. Number in group 4: <span
class="math inline">\(10\)</span>. Intersection (boys in group 4): <span
class="math inline">\(4\)</span>. Thus <span
class="math inline">\(|B\cup G_4| = 16+10-4 = 22\)</span>. Probability
<span class="math inline">\(=22/40 = 11/20\)</span>.</p></li>
</ol>
<h2 class="unnumbered" id="summary-of-key-formulas">Summary of Key
Formulas</h2>
<ul>
<li><p>Multiplication Principle: <span class="math inline">\(n_1 n_2
\dots n_k\)</span>.</p></li>
<li><p>Permutation: <span
class="math inline">\(P(n,r)=\dfrac{n!}{(n-r)!}\)</span>.</p></li>
<li><p>Combination: <span
class="math inline">\(\displaystyle\binom{n}{r}=
\frac{n!}{r!(n-r)!}\)</span>.</p></li>
<li><p>Addition (mutually exclusive): <span class="math inline">\(|A\cup
B|=|A|+|B|\)</span>.</p></li>
<li><p>Inclusion–Exclusion (two events): <span
class="math inline">\(|A\cup B|=|A|+|B|-|A\cap B|\)</span>.</p></li>
<li><p>Complement: <span
class="math inline">\(P(A&#39;)=1-P(A)\)</span>.</p></li>
</ul>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Permutations, Arrangements, and Combinations', 'Hoán vị, chỉnh hợp và tổ hợp — Lớp 10.', '', 'article', '10', '<h1 id="introduction">Introduction</h1>
<p>Counting the number of ways objects can be ordered or selected is a
fundamental skill in mathematics. Three closely related ideas appear
repeatedly:</p>
<ul>
<li><p><strong>Permutations</strong>: order matters, all objects are
distinct.</p></li>
<li><p><strong>Combinations</strong>: order does <em>not</em> matter, we
only care about which objects are chosen.</p></li>
<li><p><strong>Arrangements with repetitions</strong>: we have repeated
identical objects; we divide by the factorial of each
multiplicity.</p></li>
</ul>
<p>The sections below develop these concepts from the basic counting
principles, give many worked examples, and provide practice problems
with full solutions.</p>
<h1 id="fundamental-counting-principles">Fundamental Counting
Principles</h1>
<p>Before tackling permutations and combinations we recall two rules
that underlie all counting arguments.</p>
<dl>
<dt>Sum Rule</dt>
<dd>
<p>If a task can be completed in either of two mutually exclusive ways,
with <span class="math inline">\(N\)</span> ways for the first and <span
class="math inline">\(M\)</span> ways for the second, then there are
<span class="math inline">\(N+M\)</span> ways in total.</p>
</dd>
<dt>Product Rule</dt>
<dd>
<p>If a task consists of <span class="math inline">\(m\)</span>
sequential stages, and the <span class="math inline">\(i\)</span>‑th
stage can be carried out in <span class="math inline">\(N_i\)</span>
independent ways, then the total number of ways is <span
class="math inline">\(N_1\times N_2\times\cdots\times N_m\)</span>.</p>
</dd>
</dl>
<p>These rules justify the formulas that follow.</p>
<h1 id="permutations-of-distinct-objects">Permutations of Distinct
Objects</h1>
<p>A <strong>permutation</strong> of <span
class="math inline">\(n\)</span> distinct objects is an ordering of all
<span class="math inline">\(n\)</span> objects. By the Product Rule we
may choose the first object in <span class="math inline">\(n\)</span>
ways, the second in <span class="math inline">\(n-1\)</span> ways, and
so on, giving <span class="math display">\[P_n = n\cdot
(n-1)\cdot\ldots\cdot 2\cdot 1 = n!.\]</span></p>
<div class="example">
<p><strong>Example 1</strong>. <em>For <span class="math inline">\(3! =
3\cdot2\cdot1 = 6\)</span> orderings of three distinct
students.</em></p>
</div>
<div class="example">
<p><strong>Example 2</strong>. <em>For <span
class="math inline">\(10\)</span> distinct students, <span
class="math display">\[10! =
10\cdot9\cdot8\cdot7\cdot6\cdot5\cdot4\cdot3\cdot2\cdot1 =
3\,628\,800\]</span> different orderings.</em></p>
</div>
<h2 id="partial-permutations-k-permutations">Partial Permutations (<span
class="math inline">\(k\)</span>-Permutations)</h2>
<p>Sometimes we only wish to arrange <span
class="math inline">\(k\)</span> out of <span
class="math inline">\(n\)</span> distinct objects (<span
class="math inline">\(0\le k\le n\)</span>). The number of such
arrangements is denoted <span class="math inline">\(P(n,k)\)</span> or
<span class="math inline">\({}_nP_k\)</span> and equals <span
class="math display">\[P(n,k)=\frac{n!}{(n-k)!}=n\cdot (n-1)\cdots
(n-k+1).\]</span></p>
<div class="example">
<p><strong>Example 3</strong>. <em>How many 4‑letter words can be formed
using distinct letters from the English alphabet? Here <span
class="math inline">\(n=26\)</span>, <span
class="math inline">\(k=4\)</span>: <span
class="math display">\[P(26,4)=\frac{26!}{22!}=26\cdot25\cdot24\cdot23 =
358\,800.\]</span></em></p>
</div>
<h1 id="combinations">Combinations</h1>
<p>When the order of the selected objects does not matter we use
<strong>combinations</strong>. The number of ways to choose <span
class="math inline">\(k\)</span> objects from <span
class="math inline">\(n\)</span> distinct ones is the binomial
coefficient <span
class="math display">\[\binom{n}{k}=C(n,k)=\frac{n!}{k!\,(n-k)!}.\]</span></p>
<div class="example">
<p><strong>Example 4</strong>. <em>Choosing a committee of <span
class="math inline">\(3\)</span> students from a class of <span
class="math inline">\(10\)</span>: <span
class="math display">\[\binom{10}{3}= \frac{10!}{3!\,7!}=
\frac{10\cdot9\cdot8}{3\cdot2\cdot1}=120.\]</span></em></p>
</div>
<div class="example">
<p><strong>Example 5</strong>. <em>The number of monotonic lattice paths
from <span class="math inline">\((0,0)\)</span> to <span
class="math inline">\((3,4)\)</span> using only steps North (N) and East
(E) is <span class="math inline">\(\binom{7}{3}=
\binom{7}{4}=35\)</span>, because we must choose which <span
class="math inline">\(3\)</span> of the <span
class="math inline">\(7\)</span> steps are North.</em></p>
</div>
<h2 id="symmetry-and-pascals-rule">Symmetry and Pascal’s Rule</h2>
<p>Two useful identities are <span class="math display">\[\binom{n}{k}=
\binom{n}{n-k}\qquad\text{(symmetry)},\]</span> and <span
class="math display">\[\binom{n}{k}= \binom{n-1}{k-1}+
\binom{n-1}{k}\qquad\text{(Pascal’s rule)}.\]</span></p>
<h1
id="arrangements-with-repeated-objects-multinomial-coefficients">Arrangements
with Repeated Objects (Multinomial Coefficients)</h1>
<p>If we have <span class="math inline">\(n\)</span> objects where there
are <span class="math inline">\(n_1\)</span> copies of type 1, <span
class="math inline">\(n_2\)</span> copies of type 2, …, <span
class="math inline">\(n_k\)</span> copies of type k (with <span
class="math inline">\(n_1+n_2+\cdots+n_k=n\)</span>), then the number of
distinct linear arrangements is the multinomial coefficient <span
class="math display">\[\frac{n!}{n_1!\,n_2!\cdots n_k!}.\]</span></p>
<div class="example">
<p><strong>Example 6</strong>. <em>Arrange the letters of the word
<code>POOPOO</code> (2 P’s, 4 O’s): <span
class="math display">\[\frac{6!}{2!\,4!}=
\frac{720}{2\cdot24}=15.\]</span></em></p>
</div>
<div class="example">
<p><strong>Example 7</strong>. <em>How many distinct arrangements
consist of 3 heads (H) and 7 tails (T) in a sequence of 10 coin flips?
<span class="math display">\[\frac{10!}{3!\,7!}=
\binom{10}{3}=120.\]</span></em></p>
</div>
<div class="example">
<p><strong>Example 8</strong>. <em>Rearrange the letters of
<code>BABYYYBAY</code> (3 B’s, 2 A’s, 4 Y’s): <span
class="math display">\[\frac{9!}{3!\,2!\,4!}=
\frac{362\,880}{6\cdot2\cdot24}=1260.\]</span></em></p>
</div>
<h1 id="applications-and-practice-problems">Applications and Practice
Problems</h1>
<p>Below are several exercises that combine the ideas discussed. Attempt
each problem before reading the solution.</p>
<div class="exercise">
<p><strong>Exercise 1</strong>. <em>How many ways can you seat 5
different books on a shelf if two particular books must be next to each
other?</em></p>
</div>
<div class="solution">
<p><strong>Solution 1</strong>. <em>Treat the two books that must be
adjacent as a single “block”. Then we have <span
class="math inline">\(4\)</span> objects to arrange (the block plus the
other three books), which can be done in <span
class="math inline">\(4!\)</span> ways. Inside the block the two books
can be ordered in <span class="math inline">\(2!\)</span> ways. By the
Product Rule the total is <span class="math display">\[4!\times 2! =
24\times 2 = 48.\]</span></em></p>
</div>
<div class="exercise">
<p><strong>Exercise 2</strong>. <em>A password consists of exactly 6
characters chosen from the 26 uppercase letters, with repetitions
allowed. How many different passwords are possible?</em></p>
</div>
<div class="solution">
<p><strong>Solution 2</strong>. <em>Each of the 6 positions can be
filled independently with any of the 26 letters. By the Product Rule,
<span class="math display">\[26^6 = 308\,915\,776.\]</span></em></p>
</div>
<div class="exercise">
<p><strong>Exercise 3</strong>. <em>From a deck of 52 playing cards, how
many 5‑card hands contain exactly 2 aces?</em></p>
</div>
<div class="solution">
<p><strong>Solution 3</strong>. <em>Choose the 2 aces from the 4
available: <span class="math inline">\(\binom{4}{2}=6\)</span> ways.
Choose the remaining 3 cards from the 48 non‑aces: <span
class="math inline">\(\binom{48}{3}=17\,296\)</span> ways. Multiply:
<span class="math display">\[6 \times 17\,296 =
103\,776.\]</span></em></p>
</div>
<div class="exercise">
<p><strong>Exercise 4</strong>. <em>In how many ways can the letters of
the word <code>MISSISSIPPI</code> be arranged?</em></p>
</div>
<div class="solution">
<p><strong>Solution 4</strong>. <em>The word has 11 letters with
multiplicities: M = 1, I = 4, S = 4, P = 2. Hence <span
class="math display">\[\frac{11!}{1!\,4!\,4!\,2!}=
\frac{39\,916\,800}{1\cdot24\cdot24\cdot2}=34\,650.\]</span></em></p>
</div>
<div class="exercise">
<p><strong>Exercise 5</strong>. <em>A team of 8 students is to be split
into two groups of 3 and one group of 2 (the remaining student works
alone). How many different splittings are possible if the groups are
unlabeled (i.e., only the sizes matter)?</em></p>
</div>
<div class="solution">
<p><strong>Solution 5</strong>. <em>First choose the 3‑person group:
<span class="math inline">\(\binom{8}{3}=56\)</span>. From the remaining
5 choose another 3‑person group: <span
class="math inline">\(\binom{5}{3}=10\)</span>. The last 2 form the pair
automatically. Since the two groups of size 3 are indistinguishable we
have overcounted by a factor of <span class="math inline">\(2!\)</span>.
Thus <span
class="math display">\[\frac{56\times10}{2}=280.\]</span></em></p>
</div>
<h1 id="summary">Summary</h1>
<ul>
<li><p>Permutations of <span class="math inline">\(n\)</span> distinct
objects: <span class="math inline">\(n!\)</span>.</p></li>
<li><p><span class="math inline">\(k\)</span>-Permutations: <span
class="math inline">\(P(n,k)=\dfrac{n!}{(n-k)!}\)</span>.</p></li>
<li><p>Combinations: <span
class="math inline">\(\displaystyle\binom{n}{k}=
\frac{n!}{k!\,(n-k)!}\)</span>.</p></li>
<li><p>Arrangements with repetitions: <span
class="math inline">\(\displaystyle\frac{n!}{n_1!\,n_2!\cdots
n_k!}\)</span>.</p></li>
<li><p>The Sum and Product Rules justify all these formulas.</p></li>
</ul>
<p>Mastery of these formulas, together with practice in identifying when
order matters and whether objects are distinct, enables one to solve a
wide variety of counting problems encountered in algebra, probability,
and discrete mathematics.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Newton''s Binomial Theorem', 'Nhị thức Newton và khai triển lũy thừa của tổng — Lớp 10.', '', 'article', '10', '<h1 class="unnumbered" id="introduction">Introduction</h1>
<p>The binomial theorem gives a formula for expanding powers of a sum of
two terms. For any non-negative integer <span
class="math inline">\(n\)</span>, <span class="math display">\[(a+b)^n =
\sum_{k=0}^{n}\binom{n}{k}a^{\,n-k}b^{\,k},\]</span> where <span
class="math inline">\(\displaystyle\binom{n}{k}=\frac{n!}{k!(n-k)!}\)</span>
is a binomial coefficient. The theorem is named after Isaac Newton, who
also extended it to arbitrary (real or complex) exponents; here we treat
the integer case, which is the version studied in grade 10.</p>
<h1 class="unnumbered" id="statement-of-the-theorem">Statement of the
Theorem</h1>
<p>For every integer <span class="math inline">\(n\ge 0\)</span> and any
numbers <span class="math inline">\(a,b\)</span>, <span
class="math display">\[(a+b)^n = \binom{n}{0}a^n b^0 +
\binom{n}{1}a^{n-1}b^1 + \cdots + \binom{n}{n-1}a^1 b^{n-1} +
\binom{n}{n}a^0 b^n.\]</span> In compact notation: <span
class="math display">\[(a+b)^n =
\sum_{k=0}^{n}\binom{n}{k}a^{\,n-k}b^{\,k}.\]</span></p>
<h1 class="unnumbered" id="proof-by-mathematical-induction">Proof by
Mathematical Induction</h1>
<p>We prove the formula for all <span class="math inline">\(n\ge
0\)</span>.</p>
<p><strong>Base case (<span
class="math inline">\(n=0\)</span>):</strong> <span
class="math display">\[(a+b)^0 = 1 = \binom{0}{0}a^0b^0.\]</span> The
formula holds.</p>
<p><strong>Inductive step:</strong> Assume the formula true for some
<span class="math inline">\(n=m\ge 0\)</span>: <span
class="math display">\[(a+b)^m =
\sum_{k=0}^{m}\binom{m}{k}a^{\,m-k}b^{\,k}.\]</span> We show it holds
for <span class="math inline">\(n=m+1\)</span>: <span
class="math display">\[\begin{aligned}
(a+b)^{m+1} &amp;= (a+b)(a+b)^m \\
&amp;= (a+b)\sum_{k=0}^{m}\binom{m}{k}a^{\,m-k}b^{\,k} \\
&amp;= \sum_{k=0}^{m}\binom{m}{k}a^{\,m+1-k}b^{\,k}
   + \sum_{k=0}^{m}\binom{m}{k}a^{\,m-k}b^{\,k+1}.
\end{aligned}\]</span> In the second sum set <span
class="math inline">\(j=k+1\)</span> (<span
class="math inline">\(k=j-1\)</span>); then <span
class="math inline">\(j\)</span> runs from <span
class="math inline">\(1\)</span> to <span
class="math inline">\(m+1\)</span>: <span
class="math display">\[\sum_{k=0}^{m}\binom{m}{k}a^{\,m-k}b^{\,k+1}
= \sum_{j=1}^{m+1}\binom{m}{j-1}a^{\,m+1-j}b^{\,j}.\]</span> Now combine
the two sums, noting that the terms for <span
class="math inline">\(k=0\)</span> in the first sum and <span
class="math inline">\(j=m+1\)</span> in the second sum appear only once:
<span class="math display">\[\begin{aligned}
(a+b)^{m+1}
&amp;= \binom{m}{0}a^{m+1}b^0
   +
\sum_{k=1}^{m}\left[\binom{m}{k}+\binom{m}{k-1}\right]a^{\,m+1-k}b^{\,k}
   + \binom{m}{m}a^0b^{m+1}.
\end{aligned}\]</span> Using Pascal’s identity <span
class="math inline">\(\displaystyle\binom{m}{k}+\binom{m}{k-1}=\binom{m+1}{k}\)</span>
we obtain <span class="math display">\[(a+b)^{m+1}=
\sum_{k=0}^{m+1}\binom{m+1}{k}a^{\,m+1-k}b^{\,k},\]</span> which is
exactly the formula for <span class="math inline">\(n=m+1\)</span>. By
induction the theorem holds for all <span class="math inline">\(n\ge
0\)</span>.</p>
<h1 class="unnumbered" id="pascals-triangle">Pascal’s Triangle</h1>
<p>The coefficients <span class="math inline">\(\binom{n}{k}\)</span>
form Pascal’s triangle: <span
class="math display">\[\begin{array}{ccccccc}
&amp; &amp; &amp; 1 &amp; &amp; &amp; \\
&amp; &amp; 1 &amp; &amp; 1 &amp; &amp; \\
&amp; 1 &amp; &amp; 2 &amp; &amp; 1 &amp; \\
1 &amp; &amp; 3 &amp; &amp; 3 &amp; &amp; 1 \\
\end{array}\]</span> Each entry is the sum of the two entries above it,
reflecting Pascal’s identity used in the proof.</p>
<h1 class="unnumbered" id="examples">Examples</h1>
<ol>
<li><p>Expand <span class="math inline">\((x+y)^3\)</span>. <span
class="math display">\[(x+y)^3 =
\binom{3}{0}x^3y^0+\binom{3}{1}x^2y^1+\binom{3}{2}x^1y^2+\binom{3}{3}x^0y^3
        = x^3+3x^2y+3xy^2+y^3.\]</span></p></li>
<li><p>Expand <span class="math inline">\((2x-3)^4\)</span>. First write
<span class="math inline">\((2x+(-3))^4\)</span> and apply the theorem:
<span class="math display">\[(2x-3)^4 =
\sum_{k=0}^{4}\binom{4}{k}(2x)^{4-k}(-3)^k.\]</span> Compute each term:
<span class="math display">\[\begin{aligned}
k=0:&amp;\ \binom{4}{0}(2x)^4(-3)^0 = 1\cdot 16x^4\cdot1 = 16x^4,\\
k=1:&amp;\ \binom{4}{1}(2x)^3(-3)^1 = 4\cdot 8x^3\cdot(-3) = -96x^3,\\
k=2:&amp;\ \binom{4}{2}(2x)^2(-3)^2 = 6\cdot 4x^2\cdot 9 = 216x^2,\\
k=3:&amp;\ \binom{4}{3}(2x)^1(-3)^3 = 4\cdot 2x\cdot(-27) = -216x,\\
k=4:&amp;\ \binom{4}{4}(2x)^0(-3)^4 = 1\cdot1\cdot81 = 81.
\end{aligned}\]</span> Hence <span class="math display">\[(2x-3)^4 =
16x^4-96x^3+216x^2-216x+81.\]</span></p></li>
<li><p>Find the coefficient of <span
class="math inline">\(x^5y^2\)</span> in <span
class="math inline">\((x+y)^7\)</span>. The term with <span
class="math inline">\(x^{5}y^{2}\)</span> corresponds to <span
class="math inline">\(k=2\)</span> (power of <span
class="math inline">\(y\)</span>). Its coefficient is <span
class="math inline">\(\binom{7}{2}=21\)</span>.</p></li>
</ol>
<h1 class="unnumbered" id="practice-problems">Practice Problems</h1>
<ol>
<li><p>Expand <span class="math inline">\((a+2b)^5\)</span> and write
the result in descending powers of <span
class="math inline">\(a\)</span>.</p></li>
<li><p>Determine the coefficient of <span
class="math inline">\(x^3\)</span> in the expansion of <span
class="math inline">\((1-2x)^6\)</span>.</p></li>
<li><p>Using the binomial theorem, compute <span
class="math inline">\((1.01)^{10}\)</span> to four decimal places (you
may keep terms up to <span class="math inline">\(k=3\)</span>).</p></li>
</ol>
<h1 class="unnumbered" id="solutions">Solutions</h1>
<ol>
<li><p>Apply <span
class="math inline">\((a+2b)^5=\sum_{k=0}^{5}\binom{5}{k}a^{5-k}(2b)^k\)</span>:
<span class="math display">\[\begin{aligned}
k=0:&amp;\ \binom{5}{0}a^5(2b)^0 = a^5,\\
k=1:&amp;\ \binom{5}{1}a^4(2b)^1 = 5\cdot a^4\cdot2b = 10a^4b,\\
k=2:&amp;\ \binom{5}{2}a^3(2b)^2 = 10\cdot a^3\cdot4b^2 = 40a^3b^2,\\
k=3:&amp;\ \binom{5}{3}a^2(2b)^3 = 10\cdot a^2\cdot8b^3 = 80a^2b^3,\\
k=4:&amp;\ \binom{5}{4}a^1(2b)^4 = 5\cdot a\cdot16b^4 = 80ab^4,\\
k=5:&amp;\ \binom{5}{5}a^0(2b)^5 = 1\cdot1\cdot32b^5 = 32b^5.
\end{aligned}\]</span> Thus <span class="math display">\[(a+2b)^5 =
a^5+10a^4b+40a^3b^2+80a^2b^3+80ab^4+32b^5.\]</span></p></li>
<li><p>In <span
class="math inline">\((1-2x)^6=\sum_{k=0}^{6}\binom{6}{k}1^{6-k}(-2x)^k\)</span>,
the term containing <span class="math inline">\(x^3\)</span> has <span
class="math inline">\(k=3\)</span>: <span
class="math display">\[\text{Coefficient}= \binom{6}{3}(-2)^3 =
20\cdot(-8) = -160.\]</span> Hence the coefficient of <span
class="math inline">\(x^3\)</span> is <span
class="math inline">\(-160\)</span>.</p></li>
<li><p>Using <span
class="math inline">\((1+u)^{10}=\sum_{k=0}^{10}\binom{10}{k}u^k\)</span>
with <span class="math inline">\(u=0.01\)</span>: <span
class="math display">\[\begin{aligned}
(1.01)^{10} &amp;\approx \binom{10}{0}(0.01)^0
            +\binom{10}{1}(0.01)^1
            +\binom{10}{2}(0.01)^2
            +\binom{10}{3}(0.01)^3 \\
            &amp;= 1 + 10\cdot0.01 + 45\cdot0.0001 + 120\cdot0.000001 \\
            &amp;= 1 + 0.10 + 0.0045 + 0.00012 \\
            &amp;= 1.10462.
\end{aligned}\]</span> Rounded to four decimal places: <span
class="math inline">\(1.1046\)</span>.</p></li>
</ol>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Characteristic Numbers Measuring Dispersion', 'Khoảng biến thiên, phương sai, độ lệch chuẩn — các số đo độ phân tán.', '', 'article', '10', '<h1 class="unnumbered"
id="characteristic-numbers-that-measure-dispersion-grade-10">Characteristic
Numbers that Measure Dispersion (Grade 10)</h1>
<p>In statistics, once we have described the centre of a data set (mean,
median, mode), we often need to know how spread out the observations
are. The numbers that quantify this spread are called <strong>measures
of dispersion</strong>. Below we discuss the most common ones suitable
for a Grade‑10 curriculum, give their definitions, formulas, worked
examples, and provide practice problems with detailed solutions.</p>
<h2 class="unnumbered" id="range">1. Range</h2>
<p>The simplest measure of dispersion is the difference between the
largest and smallest observation.</p>
<p><span
class="math display">\[\text{Range}=x_{\max}-x_{\min}\]</span></p>
<h4 id="example-1">Example 1</h4>
<p>Consider the test scores of ten Grade‑10 students: <span
class="math display">\[\{58, 62, 67, 70, 73, 75, 78, 82, 85,
90\}.\]</span> Here <span class="math inline">\(x_{\min}=58\)</span> and
<span class="math inline">\(x_{\max}=90\)</span>; thus <span
class="math display">\[\text{Range}=90-58=32.\]</span></p>
<h4 id="remark">Remark</h4>
<p>The range is easy to compute but uses only two observations; it can
be heavily influenced by outliers.</p>
<h2 class="unnumbered" id="interquartile-range-iqr">2. Interquartile
Range (IQR)</h2>
<p>The IQR measures the spread of the middle 50% of the data. First find
the first quartile <span class="math inline">\(Q_1\)</span> (the median
of the lower half) and the third quartile <span
class="math inline">\(Q_3\)</span> (the median of the upper half).
Then</p>
<p><span class="math display">\[\text{IQR}=Q_3-Q_1.\]</span></p>
<p>[Image of a box plot showing IQR and quartiles]</p>
<h4 id="example-2">Example 2</h4>
<p>Using the same data set as above (already ordered): <span
class="math display">\[\begin{aligned}
\text{Median}&amp;=\frac{73+75}{2}=74,\\
\text{Lower half}&amp;=\{58,62,67,70,73\},\\
Q_1&amp;=\text{median of lower half}=67,\\
\text{Upper half}&amp;=\{75,78,82,85,90\},\\
Q_3&amp;=\text{median of upper half}=82.
\end{aligned}\]</span> Hence <span
class="math display">\[\text{IQR}=82-67=15.\]</span></p>
<h4 id="remark-1">Remark</h4>
<p>The IQR is resistant to outliers because it discards the lowest 25%
and highest 25% of observations.</p>
<h2 class="unnumbered" id="mean-absolute-deviation-mad">3. Mean Absolute
Deviation (MAD)</h2>
<p>The MAD averages the absolute distances of each observation from the
mean <span class="math inline">\(\bar{x}\)</span>.</p>
<p><span class="math display">\[\text{MAD}=
\frac{1}{n}\sum_{i=1}^{n}\bigl|x_i-\bar{x}\bigr|.\]</span></p>
<h4 id="example-3">Example 3</h4>
<p>For the data set <span
class="math inline">\(\{58,62,67,70,73,75,78,82,85,90\}\)</span>: <span
class="math display">\[\bar{x}=
\frac{58+62+67+70+73+75+78+82+85+90}{10}=74.\]</span> Compute the
absolute deviations: <span class="math display">\[\begin{array}{c|c}
x_i &amp; |x_i-\bar{x}|\\\hline
58 &amp; 16\\
62 &amp; 12\\
67 &amp; 7\\
70 &amp; 4\\
73 &amp; 1\\
75 &amp; 1\\
78 &amp; 4\\
82 &amp; 8\\
85 &amp; 11\\
90 &amp; 16
\end{array}\]</span> Sum <span class="math inline">\(=80\)</span>;
therefore <span class="math display">\[\text{MAD}=
\frac{80}{10}=8.\]</span></p>
<h4 id="remark-2">Remark</h4>
<p>MAD is intuitive (average distance from the mean) but less
mathematically tractable than the variance because of the absolute
value.</p>
<h2 class="unnumbered" id="variance-and-standard-deviation">4. Variance
and Standard Deviation</h2>
<p>The variance measures the average squared deviation from the mean.
For a sample we use</p>
<p><span class="math display">\[s^{2}=
\frac{1}{n-1}\sum_{i=1}^{n}\bigl(x_i-\bar{x}\bigr)^{2},\]</span> and the
(sample) standard deviation is <span
class="math inline">\(s=\sqrt{s^{2}}\)</span>. For a population we
replace <span class="math inline">\(n-1\)</span> by <span
class="math inline">\(N\)</span>.</p>
<h4 id="example-4">Example 4</h4>
<p>Using the same data: <span
class="math display">\[\begin{array}{c|c|c}
x_i &amp; x_i-\bar{x} &amp; (x_i-\bar{x})^{2}\\\hline
58 &amp; -16 &amp; 256\\
62 &amp; -12 &amp; 144\\
67 &amp; -7 &amp; 49\\
70 &amp; -4 &amp; 16\\
73 &amp; -1 &amp; 1\\
75 &amp; 1 &amp; 1\\
78 &amp; 4 &amp; 16\\
82 &amp; 8 &amp; 64\\
85 &amp; 11 &amp; 121\\
90 &amp; 16 &amp; 256
\end{array}\]</span> Sum of squares <span
class="math inline">\(=924\)</span>. With <span
class="math inline">\(n=10\)</span>, <span class="math display">\[s^{2}=
\frac{924}{10-1}= \frac{924}{9}=102.\overline{6}\approx 102.67,
\qquad
s=\sqrt{102.67}\approx 10.13.\]</span></p>
<h4 id="remark-3">Remark</h4>
<p>The variance is in squared units; taking the square root returns the
spread to the original units. The standard deviation is the most widely
used measure of dispersion.</p>
<h2 class="unnumbered" id="coefficient-of-variation-cv">5. Coefficient
of Variation (CV)</h2>
<p>When comparing variability across data sets with different means (or
different units), we standardise the standard deviation by the mean:</p>
<p><span class="math display">\[\text{CV}= \frac{s}{\bar{x}}\times
100\%.\]</span></p>
<h4 id="example-5">Example 5</h4>
<p>Two classes have the following summary statistics for a mathematics
test: <span class="math display">\[\begin{aligned}
\text{Class A:}&amp;\ \bar{x}=78,\ s=5.2\\
\text{Class B:}&amp;\ \bar{x}=65,\ s=4.8
\end{aligned}\]</span> <span
class="math display">\[\text{CV}_A=\frac{5.2}{78}\times100\%\approx
6.67\%,\qquad
\text{CV}_B=\frac{4.8}{65}\times100\%\approx 7.38\%.\]</span> Although
Class A has a larger absolute standard deviation, its variability
relative to its mean is smaller.</p>
<h2 class="unnumbered" id="practice-problems">Practice Problems</h2>
<ol>
<li><p>Compute the range, IQR, MAD, variance, standard deviation, and CV
for the data set <span
class="math display">\[\{12,15,14,10,18,20,22,19,17,16\}.\]</span></p></li>
<li><p>A scientist measures the heights (in cm) of ten Grade‑10
students: <span
class="math display">\[\{158,162,165,160,159,163,167,161,166,164\}.\]</span>
Find the sample variance and standard deviation.</p></li>
<li><p>Two batches of produced widgets have the following summary
statistics: <span class="math display">\[\begin{aligned}
\text{Batch 1:}&amp;\ \bar{x}=50\text{ mm},\ s=2.0\text{ mm}\\
\text{Batch 2:}&amp;\ \bar{x}=75\text{ mm},\ s=3.0\text{ mm}
\end{aligned}\]</span> Which batch exhibits greater relative
variability? Justify your answer using the coefficient of
variation.</p></li>
<li><p>The following frequency table shows the number of books read by
Grade‑10 students in a month: <span
class="math display">\[\begin{array}{c|c}
\text{Books} &amp; \text{Frequency}\\\hline
0 &amp; 5\\
1 &amp; 8\\
2 &amp; 12\\
3 &amp; 7\\
4 &amp; 3\\
\end{array}\]</span> Calculate the mean, variance, and standard
deviation for this grouped data.</p></li>
</ol>
<h2 class="unnumbered" id="solutions">Solutions</h2>
<h4 id="solution-to-problem-1">Solution to Problem 1</h4>
<p>Ordered: <span
class="math inline">\(\{10,12,14,15,16,17,18,19,20,22\}\)</span>.</p>
<ul>
<li><p>Range: <span class="math inline">\(22-10=12.\)</span></p></li>
<li><p>Median: <span class="math inline">\(16.5.\)</span> <span
class="math inline">\(Q_1=14, Q_3=19.\)</span> IQR <span
class="math inline">\(=5.\)</span></p></li>
<li><p>Mean <span class="math inline">\(\bar{x}=16.3.\)</span> MAD <span
class="math inline">\(=2.8.\)</span></p></li>
<li><p>Sample variance <span class="math inline">\(s^{2}\approx
13.57.\)</span></p></li>
<li><p>Standard deviation <span
class="math inline">\(s\approx3.68.\)</span></p></li>
<li><p>CV <span class="math inline">\(\approx22.6\%.\)</span></p></li>
</ul>
<h4 id="solution-to-problem-2">Solution to Problem 2</h4>
<p>Mean: <span class="math inline">\(162.5.\)</span> Sample variance
<span class="math inline">\(s^{2} \approx 9.17.\)</span> Standard
deviation <span class="math inline">\(s \approx 3.03\)</span> cm.</p>
<h4 id="solution-to-problem-3">Solution to Problem 3</h4>
<p><span class="math inline">\(\text{CV}_1 = \text{CV}_2 = 4\%\)</span>.
Both batches have equivalent relative variability.</p>
<h4 id="solution-to-problem-4">Solution to Problem 4</h4>
<p>Mean <span class="math inline">\(\bar{x} \approx 1.86\)</span>.
Variance <span class="math inline">\(s^{2} \approx 1.36\)</span>.
Standard deviation <span class="math inline">\(s \approx
1.17\)</span>.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Events and the Classical Definition of Probability', 'Không gian mẫu, biến cố và định nghĩa cổ điển của xác suất — Lớp 10.', '', 'article', '10', '<h1 class="unnumbered"
id="events-and-the-classical-definition-of-probability">Events and the
Classical Definition of Probability</h1>
<p><strong>Target audience: Grade 10</strong></p>
<h2 class="unnumbered" id="sample-space-and-events">1. Sample Space and
Events</h2>
<ul>
<li><p>The <strong>sample space</strong> <span
class="math inline">\(\Omega\)</span> is the set of all possible
outcomes of a random experiment.</p></li>
<li><p>An <strong>event</strong> is any subset <span
class="math inline">\(A\subseteq\Omega\)</span>.</p></li>
<li><p>Example (from the context): <span
class="math display">\[\Omega=\{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\}.\]</span></p></li>
<li><p>Define <span class="math display">\[E=\{\text{odd
numbers}\}=\{1,3,5,7,9,11,13,15\},\]</span> <span
class="math display">\[F=\{\text{prime
numbers}\}=\{2,3,5,7,11,13\},\]</span> <span
class="math display">\[G=E\cup
F=\{1,2,3,5,7,9,11,13,15\}.\]</span></p></li>
</ul>
<h2 class="unnumbered" id="classical-definition-of-probability">2.
Classical Definition of Probability</h2>
<p>If all outcomes in <span class="math inline">\(\Omega\)</span> are
equally likely, then for any event <span
class="math inline">\(A\subseteq\Omega\)</span> <span
class="math display">\[P(A)=\frac{|A|}{|\Omega|},\]</span> where <span
class="math inline">\(|A|\)</span> denotes the number of outcomes in
<span class="math inline">\(A\)</span>.</p>
<h3 class="unnumbered" id="example-1">Example 1</h3>
<p>From the context, the probability of drawing an odd number from <span
class="math inline">\(\Omega\)</span> is <span
class="math display">\[P(E)=\frac{|E|}{|\Omega|}=\frac{8}{15}.\]</span></p>
<h3 class="unnumbered" id="example-2">Example 2</h3>
<p>Probability of drawing a prime number being both odd <em>and</em>
prime (i.e., <span class="math inline">\(E\cap F\)</span>): <span
class="math display">\[E\cap F=\{3,5,7,11,13\},\qquad |E\cap
F|=5,\]</span> <span class="math display">\[P(E\cap
F)=\frac{5}{15}=\frac13.\]</span></p>
<h2 class="unnumbered" id="basic-set-operations-on-events">3. Basic Set
Operations on Events</h2>
<ul>
<li><p>Union: <span class="math inline">\(A\cup B\)</span> = outcomes in
<span class="math inline">\(A\)</span> or <span
class="math inline">\(B\)</span> (or both).</p></li>
<li><p>Intersection: <span class="math inline">\(A\cap B\)</span> =
outcomes in both <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span>.</p></li>
<li><p>Complement: <span class="math inline">\(A^{c}=\Omega\setminus
A\)</span> = outcomes not in <span
class="math inline">\(A\)</span>.</p></li>
</ul>
<p>Properties: <span class="math display">\[P(A\cup B)=P(A)+P(B)-P(A\cap
B),\qquad
P(A^{c})=1-P(A).\]</span></p>
<h3 class="unnumbered" id="example-3-using-e-and-f">Example 3 (using
<span class="math inline">\(E\)</span> and <span
class="math inline">\(F\)</span>)</h3>
<p><span class="math display">\[P(E\cup F)=P(E)+P(F)-P(E\cap
F)=\frac{8}{15}+\frac{6}{15}-\frac{5}{15}
=\frac{9}{15}=\frac35.\]</span></p>
<h2 class="unnumbered" id="mutually-exclusive-events">4. Mutually
Exclusive Events</h2>
<p>Two events <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are <strong>mutually exclusive</strong>
(disjoint) if <span class="math inline">\(A\cap B=\varnothing\)</span>.
Then <span class="math display">\[P(A\cup B)=P(A)+P(B).\]</span></p>
<h3 class="unnumbered" id="practice-problem-4">Practice Problem 4</h3>
<p>A box contains 20 cards numbered <span
class="math inline">\(1\)</span> to <span
class="math inline">\(20\)</span>. Let <span
class="math inline">\(A\)</span> be “draw an even number <span
class="math inline">\(&gt;9\)</span>”. Let <span
class="math inline">\(B\)</span> be “draw a number between <span
class="math inline">\(8\)</span> and <span
class="math inline">\(15\)</span> inclusive”. Find <span
class="math inline">\(|A\cup B|\)</span>.</p>
<p><strong>Solution:</strong> <span
class="math display">\[A=\{10,12,14,16,18,20\},\;|A|=6.\]</span> <span
class="math display">\[B=\{8,9,10,11,12,13,14,15\},\;|B|=8.\]</span>
<span class="math display">\[A\cap B=\{10,12,14\},\;|A\cap
B|=3.\]</span> <span class="math display">\[|A\cup B|=|A|+|B|-|A\cap
B|=6+8-3=11.\]</span> Hence the correct choice is <strong>A.
11</strong>.</p>
<h2 class="unnumbered" id="independent-events">5. Independent
Events</h2>
<p>Two events <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are <strong>independent</strong> if
<span class="math display">\[P(A\cap B)=P(A)\,P(B).\]</span></p>
<h3 class="unnumbered" id="practice-problem-5">Practice Problem 5</h3>
<p>Given <span class="math inline">\(P(A)=0.3\)</span>, <span
class="math inline">\(P(B)=0.4\)</span>, <span
class="math inline">\(P(A\cap B)=0.2\)</span>. Determine whether <span
class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are mutually exclusive and/or
independent.</p>
<p><strong>Solution:</strong></p>
<ul>
<li><p>Mutually exclusive? <span class="math inline">\(P(A\cap
B)=0.2\neq0\)</span> → <strong>Not mutually exclusive</strong>.</p></li>
<li><p>Independent? <span
class="math inline">\(P(A)P(B)=0.3\times0.4=0.12\neq0.2\)</span> →
<strong>Not independent</strong>.</p></li>
</ul>
<p>Thus <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are neither mutually exclusive nor
independent.</p>
<h2 class="unnumbered" id="conditional-probability-brief">6. Conditional
Probability (brief)</h2>
<p><span class="math display">\[P(A\mid B)=\frac{P(A\cap
B)}{P(B)},\qquad P(B)&gt;0.\]</span></p>
<h2 class="unnumbered" id="applications-from-the-context">7.
Applications from the Context</h2>
<h3 class="unnumbered" id="seating-arrangement">Seating arrangement</h3>
<p>Ten people are to be seated in a row. Quang and Huyền must sit
together. Number of seatings with them adjacent: <span
class="math inline">\(6\cdot3!\cdot5!=6\cdot6\cdot120=4320\)</span>.
Total seatings of 10 people: <span
class="math inline">\(10!=3\,628\,800\)</span>. Hence <span
class="math display">\[P(\text{Quang and Huyền
adjacent})=\frac{4320}{3\,628\,800}=\frac{1}{280}.\]</span></p>
<h3 class="unnumbered" id="drawing-balls-without-replacement">Drawing
balls without replacement</h3>
<p>An urn contains <span class="math inline">\(7\)</span> blue and <span
class="math inline">\(8\)</span> red balls (<span
class="math inline">\(15\)</span> total). Draw <span
class="math inline">\(3\)</span> balls without replacement. Probability
of at least one red: <span class="math display">\[P(\text{at least one
red})=1-P(\text{all blue})=1-\frac{\binom{7}{3}}{\binom{15}{3}}
=1-\frac{35}{455}=1-\frac{1}{13}=\frac{12}{13}.\]</span></p>
<h2 class="unnumbered" id="additional-practice-problems">8. Additional
Practice Problems</h2>
<ol>
<li><p>A fair six‑sided die is rolled. Let <span
class="math inline">\(A\)</span> be “the outcome is even”. Find <span
class="math inline">\(P(A)\)</span>. <strong>Solution:</strong> <span
class="math inline">\(A=\{2,4,6\}\)</span>, <span
class="math inline">\(|A|=3\)</span>, <span
class="math inline">\(|\Omega|=6\)</span>, so <span
class="math inline">\(P(A)=\frac{3}{6}=\frac12\)</span>.</p></li>
<li><p>Two coins are tossed. Define <span
class="math inline">\(B\)</span> as “exactly one head appears”. Compute
<span class="math inline">\(P(B)\)</span>. <strong>Solution:</strong>
Sample space <span class="math inline">\(\{HH,HT,TH,TT\}\)</span>;
favorable <span class="math inline">\(\{HT,TH\}\)</span>; <span
class="math inline">\(|B|=2\)</span>, <span
class="math inline">\(|\Omega|=4\)</span>, <span
class="math inline">\(P(B)=\frac24=\frac12\)</span>.</p></li>
<li><p>From a standard <span class="math inline">\(52\)</span>‑card
deck, three cards are drawn without replacement. Find the probability
that none of the three cards is a heart. <strong>Solution:</strong>
<span
class="math display">\[P=\frac{39}{52}\cdot\frac{38}{51}\cdot\frac{37}{50}
        =\frac{39\cdot38\cdot37}{52\cdot51\cdot50}
        =\frac{54834}{132600}
        =\frac{9139}{22100}\approx0.413.\]</span></p></li>
<li><p>A student must choose one elective among art, geology,
psychology. She is equally likely to choose art or psychology and twice
as likely to choose geology. Find the probabilities for each choice.
<strong>Solution:</strong> Let <span class="math inline">\(p\)</span> be
<span class="math inline">\(P(\text{art})=P(\text{psychology})\)</span>.
Then <span class="math inline">\(P(\text{geology})=2p\)</span>. Since
total probability <span class="math inline">\(=1\)</span>: <span
class="math display">\[p+2p+p=4p=1\;\Longrightarrow\;p=\frac14.\]</span>
Hence <span
class="math display">\[P(\text{art})=P(\text{psychology})=\frac14,\qquad
        P(\text{geology})=\frac12.\]</span></p></li>
</ol>
<h2 class="unnumbered" id="summary">9. Summary</h2>
<ul>
<li><p>The classical definition applies when outcomes are equally
likely.</p></li>
<li><p>Probability of an event <span class="math inline">\(A\)</span> is
the ratio of favorable outcomes to total outcomes.</p></li>
<li><p>Use set operations (union, intersection, complement) to combine
events.</p></li>
<li><p>Mutually exclusive events simplify the addition rule.</p></li>
<li><p>Independent events satisfy <span class="math inline">\(P(A\cap
B)=P(A)P(B)\)</span>.</p></li>
<li><p>Conditional probability handles dependence between
events.</p></li>
</ul>
');