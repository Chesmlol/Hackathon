-- Xoá bản ghi trùng tên (nếu đã import trước đó), rồi chèn lại với difficulty='12'
DELETE FROM lessons WHERE title = 'Range of Variation and Interquartile Range';
DELETE FROM lessons WHERE title = 'Variance and Standard Deviation';
DELETE FROM lessons WHERE title = 'Conditional Probability';
DELETE FROM lessons WHERE title = 'Total Probability Formula and Bayes'' Theorem';

INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Range of Variation and Interquartile Range', 'Khoảng biến thiên và khoảng tứ phân vị — Lớp 12.', '', 'article', '12', '<h1 class="unnumbered"
id="ranges-of-variation-and-interquartile-range">Ranges of Variation and
Interquartile Range</h1>
<p><strong>Target Audience: Grade 12 Students</strong></p>
<h2 class="unnumbered" id="introduction">1. Introduction</h2>
<p>In statistics we often need a single number that tells us how “spread
out” a data set is. Two of the most common measures of dispersion
are:</p>
<ul>
<li><p><strong>Range</strong> – the difference between the maximum and
minimum observations.</p></li>
<li><p><strong>Interquartile Range (IQR)</strong> – the difference
between the third quartile (<span class="math inline">\(Q_3\)</span>)
and the first quartile (<span class="math inline">\(Q_1\)</span>); it
measures the spread of the middle 50% of the data.</p></li>
</ul>
<p>Both are easy to compute, but they have different sensitivities to
extreme values (outliers). Understanding when to use each is essential
for correct data interpretation.</p>
<h2 class="unnumbered" id="definitions">2. Definitions</h2>
<dl>
<dt>Range</dt>
<dd>
<p><span class="math display">\[R = \max\{x_i\} -
\min\{x_i\}.\]</span></p>
</dd>
<dt>First Quartile (<span class="math inline">\(Q_1\)</span>)</dt>
<dd>
<p>The value below which 25% of the data lie. Equivalently, the median
of the lower half of the data (excluding the overall median if <span
class="math inline">\(n\)</span> is odd).</p>
</dd>
<dt>Third Quartile (<span class="math inline">\(Q_3\)</span>)</dt>
<dd>
<p>The value below which 75% of the data lie. Equivalently, the median
of the upper half of the data.</p>
</dd>
<dt>Interquartile Range (IQR)</dt>
<dd>
<p><span class="math display">\[\text{IQR}= Q_3 - Q_1.\]</span></p>
</dd>
</dl>
<h2 class="unnumbered" id="properties">3. Properties</h2>
<ol>
<li><p>The range uses only the two extreme observations; therefore it is
highly sensitive to outliers.</p></li>
<li><p>The IQR uses the middle 50% of the data; it is robust to a
moderate number of extreme values.</p></li>
<li><p>Both measures are non‑negative, and they are zero only when all
observations are identical.</p></li>
<li><p>For a symmetric distribution, the median lies halfway between
<span class="math inline">\(Q_1\)</span> and <span
class="math inline">\(Q_3\)</span>: <span
class="math inline">\(\text{Median}\approx
(Q_1+Q_3)/2\)</span>.</p></li>
</ol>
<h2 class="unnumbered" id="computing-quartiles-stepbystep">4. Computing
Quartiles – Step‑by‑Step</h2>
<p>Given an ordered data set <span class="math inline">\(x_{(1)}\le
x_{(2)}\le\cdots\le x_{(n)}\)</span>:</p>
<ol>
<li><p>Find the median (position <span
class="math inline">\((n+1)/2\)</span>). Split the data into a lower
half and an upper half.</p></li>
<li><p>If <span class="math inline">\(n\)</span> is odd, exclude the
median from both halves; if <span class="math inline">\(n\)</span> is
even, simply split at the middle.</p></li>
<li><p><span class="math inline">\(Q_1\)</span> = median of the lower
half.</p></li>
<li><p><span class="math inline">\(Q_3\)</span> = median of the upper
half.</p></li>
</ol>
<p><strong>Example (from the context):</strong> Height data (in cm) for
a sample: <span
class="math display">\[159,\;162,\;165,\;168,\;170,\;172.\]</span> Here
<span class="math inline">\(n=6\)</span> (even). Lower half = <span
class="math inline">\(\{159,162,165\}\)</span>, upper half = <span
class="math inline">\(\{168,170,172\}\)</span>. <span
class="math display">\[Q_1 = \text{median of lower half}=162,\qquad
Q_3 = \text{median of upper half}=170.\]</span> Thus <span
class="math display">\[\text{IQR}=Q_3-Q_1=170-162=8\text{ cm}.\]</span>
(The context gave <span class="math inline">\(Q_1=9.5\)</span>, <span
class="math inline">\(Q_3=19.5\)</span> for a different data set; the
procedure is identical.)</p>
<h2 class="unnumbered" id="outlier-detection-using-the-iqr">5. Outlier
Detection Using the IQR</h2>
<p>A common rule (Tukey’s fences) defines potential outliers as
observations lying outside <span
class="math display">\[\bigl[\,Q_1-1.5\;\text{IQR},\;
Q_3+1.5\;\text{IQR}\,\bigr].\]</span> <strong>Example (from the
context):</strong> For a data set with <span
class="math inline">\(Q_1=135\)</span> mg, <span
class="math inline">\(Q_3=205\)</span> mg, <span
class="math display">\[\text{IQR}=205-135=70\text{ mg},\]</span> <span
class="math display">\[\text{Lower bound}=135-1.5\times70=30\text{
mg},\qquad
\text{Upper bound}=205+1.5\times70=310\text{ mg}.\]</span> Observations
<span class="math inline">\(&lt;\)</span>30 mg or <span
class="math inline">\(&gt;\)</span>310 mg are flagged as outliers. In
the given data, 0 mg and 340 mg satisfy this condition.</p>
<h2 class="unnumbered" id="relationship-between-range-and-iqr">6.
Relationship Between Range and IQR</h2>
<p>While the range captures total spread, the IQR captures the spread of
the central bulk. Consequently:</p>
<ul>
<li><p>If the data contain extreme outliers, the range will be
substantially larger than the IQR.</p></li>
<li><p>For a data set without outliers, the two measures are often of
comparable magnitude (though the range is still <span
class="math inline">\(\ge\)</span> IQR).</p></li>
</ul>
<p><strong>Illustration from the context:</strong> <span
class="math display">\[\begin{aligned}
\text{Group 1:}&amp;\quad \text{Range}=2,\;\text{Range}=4\;\Rightarrow\;
\text{Group 1 more uniform (smaller spread).}\\
\text{Height data:}&amp;\quad \text{Range}=172-159=13\text{
cm},\;\text{IQR}=10\text{ (from another example).}
\end{aligned}\]</span> Here the range (13 cm) exceeds the IQR (10 cm)
because the extremes (159 cm and 172 cm) add extra spread beyond the
middle 50%.</p>
<h2 class="unnumbered" id="worked-examples">7. Worked Examples</h2>
<div class="example">
<p><strong>Example 1</strong>. <em>A sample of 9 exam scores (out of
100) is: <span
class="math display">\[55,\;60,\;62,\;68,\;70,\;73,\;78,\;85,\;92.\]</span>
Find the range, <span class="math inline">\(Q_1\)</span>, <span
class="math inline">\(Q_3\)</span>, and IQR.</em></p>
</div>
<div class="solution">
<p><strong>Solution 1</strong>. <em>The data are already ordered; <span
class="math inline">\(n=9\)</span>.</em></p>
<ul>
<li><p><em><strong>Range</strong>= <span class="math inline">\(\max -
\min = 92-55 = 37\)</span>.</em></p></li>
<li><p><em>Median (5th value) = 70.</em></p></li>
<li><p><em>Lower half = <span
class="math inline">\(\{55,60,62,68\}\)</span> <span
class="math inline">\(\rightarrow\)</span> <span
class="math inline">\(Q_1\)</span> = median of lower half = <span
class="math inline">\((60+62)/2 = 61\)</span>.</em></p></li>
<li><p><em>Upper half = <span
class="math inline">\(\{73,78,85,92\}\)</span> <span
class="math inline">\(\rightarrow\)</span> <span
class="math inline">\(Q_3\)</span> = median of upper half = <span
class="math inline">\((78+85)/2 = 81.5\)</span>.</em></p></li>
<li><p><em><strong>IQR</strong>= <span class="math inline">\(Q_3-Q_1 =
81.5-61 = 20.5\)</span>.</em></p></li>
</ul>
</div>
<div class="example">
<p><strong>Example 2</strong>. <em>Using the tobacco‑tax data from the
context: 12 out of 51 cities have a tax greater than 36 units. Suppose
the ordered tax values (in units) are such that <span
class="math inline">\(Q_1=36\)</span> and <span
class="math inline">\(Q_3=100\)</span>. Compute the range and IQR if the
minimum observed tax is 0 and the maximum is 120.</em></p>
</div>
<div class="solution">
<p><strong>Solution 2</strong>. </p>
<ul>
<li><p><em><strong>Range</strong>= <span class="math inline">\(120-0 =
120\)</span>.</em></p></li>
<li><p><em>Given <span class="math inline">\(Q_1=36\)</span>, <span
class="math inline">\(Q_3=100\)</span> <span
class="math inline">\(\rightarrow\)</span> <strong>IQR</strong>= <span
class="math inline">\(100-36 = 64\)</span>.</em></p></li>
</ul>
<p><em>Thus the middle 50% of cities have taxes between 36 and 100
units, while the full sample spans 0 to 120 units.</em></p>
</div>
<h2 class="unnumbered" id="practice-problems">8. Practice Problems</h2>
<ol>
<li><p>The following data represent the number of hours students spent
studying for a final exam (in hours): <span
class="math display">\[2,\;3,\;3,\;4,\;5,\;5,\;6,\;7,\;8,\;9,\;10,\;12.\]</span>
Compute the range, <span class="math inline">\(Q_1\)</span>, <span
class="math inline">\(Q_3\)</span>, and IQR. Identify any outliers using
the 1.5<span class="math inline">\(\times\)</span>IQR rule.</p></li>
<li><p>A biologist measured the lengths (in mm) of 15 fish: <span
class="math display">\[45,\;48,\;50,\;52,\;53,\;55,\;57,\;58,\;60,\;62,\;63,\;65,\;68,\;70,\;73.\]</span>
Find the range and IQR. Comment on which measure better represents the
typical spread of the data.</p></li>
<li><p>Consider the data set: <span
class="math display">\[0,\;0,\;1,\;1,\;2,\;2,\;3,\;3,\;4,\;4,\;5,\;5,\;6,\;6,\;7,\;7,\;8,\;8,\;9,\;9.\]</span>
Compute the range and IQR. Explain why the IQR is zero or non‑zero in
this case.</p></li>
</ol>
<h2 class="unnumbered" id="solutions-to-practice-problems">9. Solutions
to Practice Problems</h2>
<div class="solution">
<p><strong>Solution 3</strong> (Problem 1). <em>Ordered data (already).
<span class="math inline">\(n=12\)</span>.</em></p>
<ul>
<li><p><em><strong>Range</strong>= <span class="math inline">\(12-2 =
10\)</span>.</em></p></li>
<li><p><em>Median = average of 6th and 7th values = <span
class="math inline">\((5+6)/2 = 5.5\)</span>.</em></p></li>
<li><p><em>Lower half = <span
class="math inline">\(\{2,3,3,4,5,5\}\)</span> <span
class="math inline">\(\rightarrow\)</span> <span
class="math inline">\(Q_1 = (3+4)/2 = 3.5\)</span>.</em></p></li>
<li><p><em>Upper half = <span
class="math inline">\(\{6,7,8,9,10,12\}\)</span> <span
class="math inline">\(\rightarrow\)</span> <span
class="math inline">\(Q_3 = (8+9)/2 = 8.5\)</span>.</em></p></li>
<li><p><em><strong>IQR</strong>= <span class="math inline">\(8.5-3.5 =
5\)</span>.</em></p></li>
<li><p><em>Outlier bounds: <span class="math display">\[\text{Lower}=
Q_1-1.5\cdot\text{IQR}=3.5-7.5=-4,\qquad
    \text{Upper}= Q_3+1.5\cdot\text{IQR}=8.5+7.5=16.\]</span> All
observations lie in <span class="math inline">\([-4,16]\)</span>, so
<strong>no outliers</strong>.</em></p></li>
</ul>
</div>
<div class="solution">
<p><strong>Solution 4</strong> (Problem 2). <em><span
class="math inline">\(n=15\)</span>.</em></p>
<ul>
<li><p><em><strong>Range</strong>= <span class="math inline">\(73-45 =
28\)</span> mm.</em></p></li>
<li><p><em>Median (8th value) = 58 mm.</em></p></li>
<li><p><em>Lower half = first 7 values <span
class="math inline">\(\rightarrow\)</span> median of <span
class="math inline">\(\{45,48,50,52,53,55,57\}\)</span> = 52 mm <span
class="math inline">\(\rightarrow\)</span> <span
class="math inline">\(Q_1=52\)</span>.</em></p></li>
<li><p><em>Upper half = last 7 values <span
class="math inline">\(\rightarrow\)</span> median of <span
class="math inline">\(\{60,62,63,65,68,70,73\}\)</span> = 65 mm <span
class="math inline">\(\rightarrow\)</span> <span
class="math inline">\(Q_3=65\)</span>.</em></p></li>
<li><p><em><strong>IQR</strong>= <span class="math inline">\(65-52 =
13\)</span> mm.</em></p></li>
</ul>
<p><em>The range (28 mm) is inflated by the smallest (45 mm) and largest
(73 mm) fish. The IQR (13 mm) reflects the spread of the central 50% and
is less affected by those extremes, thus it better represents the
typical spread for the majority of the fish.</em></p>
</div>
<div class="solution">
<p><strong>Solution 5</strong> (Problem 3). <em>The data are symmetric
and each integer from 0 to 9 appears twice.</em></p>
<ul>
<li><p><em><strong>Range</strong>= <span class="math inline">\(9-0 =
9\)</span>.</em></p></li>
<li><p><em><span class="math inline">\(n=20\)</span> (even). Median =
average of 10th and 11th values = <span class="math inline">\((4+5)/2 =
4.5\)</span>.</em></p></li>
<li><p><em>Lower half = first 10 values <span
class="math inline">\(\{0,0,1,1,2,2,3,3,4,4\}\)</span> <span
class="math inline">\(\rightarrow\)</span> median = <span
class="math inline">\((2+3)/2 = 2.5\)</span> <span
class="math inline">\(\rightarrow\)</span> <span
class="math inline">\(Q_1=2.5\)</span>.</em></p></li>
<li><p><em>Upper half = last 10 values <span
class="math inline">\(\{5,5,6,6,7,7,8,8,9,9\}\)</span> <span
class="math inline">\(\rightarrow\)</span> median = <span
class="math inline">\((7+8)/2 = 7.5\)</span> <span
class="math inline">\(\rightarrow\)</span> <span
class="math inline">\(Q_3=7.5\)</span>.</em></p></li>
<li><p><em><strong>IQR</strong>= <span class="math inline">\(7.5-2.5 =
5\)</span>.</em></p></li>
</ul>
<p><em>The IQR is non‑zero because the middle 50% of the data (the 2nd
and 3rd quartiles) still exhibit variation; only if all data were
identical would both range and IQR be zero.</em></p>
</div>
<h2 class="unnumbered" id="summary">10. Summary</h2>
<ul>
<li><p><strong>Range</strong> = <span class="math inline">\(\max -
\min\)</span>. Simple, but highly sensitive to outliers.</p></li>
<li><p><strong>IQR</strong> = <span class="math inline">\(Q_3 -
Q_1\)</span>. Measures the spread of the central 50%; robust to
outliers.</p></li>
<li><p>Outlier detection: any observation outside <span
class="math inline">\([Q_1-1.5\text{IQR},\; Q_3+1.5\text{IQR}]\)</span>
is a potential outlier.</p></li>
<li><p>For symmetric, outlier‑free data, range and IQR are often of
comparable size; otherwise the range will exceed the IQR.</p></li>
</ul>
<p>Understanding both measures allows you to describe data variability
accurately and to choose the appropriate summary statistic depending on
the presence of extreme values.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Variance and Standard Deviation', 'Phương sai và độ lệch chuẩn — số đo độ phân tán của dữ liệu.', '', 'article', '12', '<h1 id="what-is-variance">What is Variance?</h1>
<p>Variance measures how spread out the values of a random variable (or
a data set) are around its mean. For a sample <span
class="math inline">\(\{X_1,\dots ,X_n\}\)</span> the <strong>unbiased
sample variance</strong> is</p>
<p><span class="math display">\[S^{2}=
\frac{1}{n-1}\sum_{i=1}^{n}(X_i-\bar X)^{2},
\qquad\text{where }\bar X=\frac{1}{n}\sum_{i=1}^{n}X_i .\]</span></p>
<p>The denominator <span class="math inline">\(n-1\)</span> (instead of
<span class="math inline">\(n\)</span>) makes <span
class="math inline">\(S^{2}\)</span> an unbiased estimator of the
population variance <span class="math inline">\(\sigma^{2}\)</span>.</p>
<h1 id="standard-deviation">Standard Deviation</h1>
<p>The <strong>sample standard deviation</strong> is the square‑root of
the variance:</p>
<p><span
class="math display">\[S=\sqrt{S^{2}}=\sqrt{\frac{1}{n-1}\sum_{i=1}^{n}(X_i-\bar
X)^{2}} .\]</span></p>
<p>It has the same units as the original data, which makes it easier to
interpret than the variance (which is in squared units).</p>
<h1 id="formulas-for-grouped-data">Formulas for Grouped Data</h1>
<p>When data are presented in a frequency table with distinct values
<span class="math inline">\(x_i\)</span> occurring <span
class="math inline">\(f_i\)</span> times (<span
class="math inline">\(N=\sum f_i\)</span>),</p>
<p><span class="math display">\[\bar x =\frac{\sum f_i x_i}{N},
\qquad
s^{2}= \frac{\sum f_i (x_i-\bar x)^{2}}{N-1}.\]</span></p>
<p>These formulas follow directly from the definition of variance by
treating each observation as repeated <span
class="math inline">\(f_i\)</span> times.</p>
<h1 id="properties">Properties</h1>
<ul>
<li><p><span
class="math inline">\(\operatorname{Var}(aX+b)=a^{2}\operatorname{Var}(X)\)</span>
for constants <span class="math inline">\(a,b\)</span>.</p></li>
<li><p>If <span class="math inline">\(X\)</span> and <span
class="math inline">\(Y\)</span> are independent, <span
class="math inline">\(\operatorname{Var}(X+Y)=\operatorname{Var}(X)+\operatorname{Var}(Y)\)</span>.</p></li>
<li><p><span class="math inline">\(\operatorname{Var}(X)=E[X^{2}]-
(E[X])^{2}\)</span>.</p></li>
</ul>
<h1 id="examples">Examples</h1>
<h2 id="example-1-bag-weights">Example 1: Bag Weights</h2>
<p>From a sample of 20 bags the sample mean weight is <span
class="math inline">\(\bar X=48\text{ kg}\)</span> and the unbiased
sample variance is</p>
<p><span class="math display">\[S^{2}=(0.5\text{ kg})^{2}=0.25\text{
kg}^{2}.\]</span></p>
<p>Hence the sample standard deviation is</p>
<p><span class="math display">\[S=\sqrt{0.25}=0.5\text{
kg}.\]</span></p>
<p>Interpretation: Typical bag weight deviates from the mean by about
half a kilogram.</p>
<h2 id="example-2-die-roll-discrete-uniform">Example 2: Die Roll
(Discrete Uniform)</h2>
<p>For a fair six‑sided die, <span
class="math inline">\(X\in\{1,2,3,4,5,6\}\)</span> with <span
class="math inline">\(P(X=k)=\frac16\)</span>.</p>
<p><span class="math display">\[E[X]=\frac{1+2+3+4+5+6}{6}=3.5,\]</span>
<span
class="math display">\[E[X^{2}]=\frac{1^{2}+2^{2}+3^{2}+4^{2}+5^{2}+6^{2}}{6}
      =\frac{91}{6}\approx15.1667,\]</span> <span
class="math display">\[\operatorname{Var}(X)=E[X^{2}]-(E[X])^{2}
   =\frac{91}{6}-\left(\frac{7}{2}\right)^{2}
   =\frac{35}{12}\approx2.9167.\]</span></p>
<p>Thus the standard deviation is</p>
<p><span
class="math display">\[\sigma=\sqrt{\frac{35}{12}}\approx1.708.\]</span></p>
<h2 id="example-3-variance-equality-test-ftest">Example 3: Variance
Equality Test (F‑test)</h2>
<p>Two independent samples:</p>
<ul>
<li><p>Boys: <span class="math inline">\(n=25\)</span>, <span
class="math inline">\(S_X^{2}=40266.67\)</span>.</p></li>
<li><p>Girls: <span class="math inline">\(m=28\)</span>, <span
class="math inline">\(S_Y^{2}=37407.41\)</span>.</p></li>
</ul>
<p>The test statistic for equality of variances is</p>
<p><span
class="math display">\[F=\frac{S_X^{2}}{S_Y^{2}}=1.076.\]</span></p>
<p>With <span class="math inline">\(\alpha=0.05\)</span>, <span
class="math inline">\(df_{1}=24\)</span>, <span
class="math inline">\(df_{2}=27\)</span>, the critical value is <span
class="math inline">\(F_{0.05}(24,27)=1.89\)</span>. Since <span
class="math inline">\(1.076&lt;1.89\)</span>, we fail to reject <span
class="math inline">\(H_{0}\)</span>; the variances are not
significantly different at the 5% level.</p>
<h2 id="example-4-indicator-method-empty-bins">Example 4: Indicator
Method – Empty Bins</h2>
<p>Throw <span class="math inline">\(12\)</span> balls independently and
uniformly into <span class="math inline">\(7\)</span> bins. Let <span
class="math inline">\(I_j\)</span> be the indicator that bin <span
class="math inline">\(j\)</span> is empty. Then</p>
<p><span
class="math display">\[P(I_j=1)=\left(1-\frac1{7}\right)^{12}=\left(\frac6{7}\right)^{12}.\]</span></p>
<p>Define <span class="math inline">\(X=\sum_{j=1}^{7}I_j\)</span>
(total empty bins). Because the <span class="math inline">\(I_j\)</span>
are identically distributed but not independent,</p>
<p><span class="math display">\[E[X]=7\left(\frac6{7}\right)^{12}\approx
7\cdot0.1122=0.7854.\]</span></p>
<p>For the variance we need covariances: <span
class="math display">\[\operatorname{Cov}(I_j,I_k)=P(\text{bins
}j,k\text{ both empty})-E[I_j]E[I_k].\]</span> Both bins empty occurs
when each ball avoids the two specific bins: <span
class="math display">\[P(\text{both
empty})=\left(1-\frac2{7}\right)^{12}=\left(\frac5{7}\right)^{12}.\]</span>
Thus</p>
<p><span
class="math display">\[\operatorname{Cov}(I_j,I_k)=\left(\frac5{7}\right)^{12}
                              -\left[\left(\frac6{7}\right)^{12}\right]^{2}.\]</span></p>
<p>Finally</p>
<p><span
class="math display">\[\operatorname{Var}(X)=\sum_{j}\operatorname{Var}(I_j)
                     +2\!\sum_{j&lt;k}\!\operatorname{Cov}(I_j,I_k)
                     =7p(1-p)+42\!\left[\left(\frac5{7}\right)^{12}-p^{2}\right],\]</span>
where <span
class="math inline">\(p=\left(\frac6{7}\right)^{12}\)</span>. Evaluating
numerically gives <span
class="math inline">\(\operatorname{Var}(X)\approx0.61\)</span> and
<span class="math inline">\(\sigma_X\approx0.78\)</span>.</p>
<h1 id="practice-problems">Practice Problems</h1>
<ol>
<li><p>A sample of <span class="math inline">\(15\)</span> students’
scores on a test has mean <span class="math inline">\(78\)</span> and
sum of squared deviations <span class="math inline">\(\sum (X_i-\bar
X)^{2}=945\)</span>. Compute the unbiased sample variance and standard
deviation.</p></li>
<li><p>For a discrete random variable <span
class="math inline">\(Y\)</span> with distribution <span
class="math display">\[P(Y=0)=0.2,\; P(Y=2)=0.5,\; P(Y=4)=0.3,\]</span>
find <span class="math inline">\(E[Y]\)</span>, <span
class="math inline">\(\operatorname{Var}(Y)\)</span>, and the standard
deviation.</p></li>
<li><p>Using the grouped data below, calculate the sample mean and
variance.</p>
<p><span class="math display">\[\begin{array}{c|c}
\text{Value }x_i &amp; \text{Frequency }f_i\\\hline
10 &amp; 3\\
12 &amp; 5\\
14 &amp; 2\\
16 &amp; 4
\end{array}\]</span></p></li>
<li><p>Suppose we throw <span class="math inline">\(20\)</span> balls
independently into <span class="math inline">\(10\)</span> bins. Using
indicator variables, find the expected number of empty bins and its
variance.</p></li>
</ol>
<h1 id="solutions">Solutions</h1>
<ol>
<li><p>Variance: <span class="math display">\[s^{2}=
\frac{1}{15-1}\cdot945=\frac{945}{14}=67.5.\]</span> Standard deviation:
<span class="math inline">\(s=\sqrt{67.5}\approx8.215\)</span>.</p></li>
<li><p>First compute the mean: <span
class="math display">\[E[Y]=0\cdot0.2+2\cdot0.5+4\cdot0.3=0+1+1.2=2.2.\]</span>
Second moment: <span
class="math display">\[E[Y^{2}]=0^{2}\cdot0.2+2^{2}\cdot0.5+4^{2}\cdot0.3
        =0+4\cdot0.5+16\cdot0.3=2+4.8=6.8.\]</span> Variance: <span
class="math display">\[\operatorname{Var}(Y)=E[Y^{2}]-(E[Y])^{2}=6.8-(2.2)^{2}=6.8-4.84=1.96.\]</span>
Standard deviation: <span
class="math inline">\(\sigma=\sqrt{1.96}=1.4\)</span>.</p></li>
<li><p>Total frequency <span
class="math inline">\(N=3+5+2+4=14\)</span>. Mean: <span
class="math display">\[\bar
x=\frac{3\cdot10+5\cdot12+2\cdot14+4\cdot16}{14}
      =\frac{30+60+28+64}{14}
      =\frac{182}{14}=13.\]</span> Sum of weighted squared deviations:
<span class="math display">\[\sum f_i (x_i-\bar x)^{2}
=3(10-13)^{2}+5(12-13)^{2}+2(14-13)^{2}+4(16-13)^{2}
=3\cdot9+5\cdot1+2\cdot1+4\cdot9=27+5+2+36=70.\]</span> Sample variance:
<span class="math display">\[s^{2}= \frac{70}{14-1}=
\frac{70}{9}\approx7.78.\]</span> Standard deviation: <span
class="math inline">\(s=\sqrt{70/9}\approx2.79\)</span>.</p></li>
<li><p>Let <span class="math inline">\(I_j\)</span> be indicator that
bin <span class="math inline">\(j\)</span> stays empty after <span
class="math inline">\(20\)</span> balls are thrown into <span
class="math inline">\(10\)</span> bins. Probability a specific bin
avoids all balls: <span
class="math display">\[p=\left(1-\frac1{10}\right)^{20}=\left(\frac9{10}\right)^{20}\approx0.1216.\]</span>
Expected number of empty bins: <span
class="math display">\[E[X]=10p\approx1.216.\]</span> For two distinct
bins <span class="math inline">\(j\neq k\)</span>, both empty occurs
when each ball avoids the two bins: <span
class="math display">\[p_{2}=\left(1-\frac2{10}\right)^{20}=\left(\frac8{10}\right)^{20}\approx0.0115.\]</span>
Covariance: <span
class="math display">\[\operatorname{Cov}(I_j,I_k)=p_{2}-p^{2}\approx0.0115-0.0148=-0.0033.\]</span>
Variance: <span
class="math display">\[\operatorname{Var}(X)=10p(1-p)+2\binom{10}{2}\operatorname{Cov}(I_j,I_k)
\approx10(0.1216)(0.8784)+90(-0.0033)
\approx1.067-0.297\approx0.77.\]</span> Standard deviation: <span
class="math inline">\(\sigma_X\approx\sqrt{0.77}\approx0.88\)</span>.</p></li>
</ol>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Conditional Probability', 'Xác suất có điều kiện P(A|B) — Lớp 12.', '', 'article', '12', '<h1 class="unnumbered"
id="conditional-probability-lecture-notes-for-grade-12">Conditional
Probability – Lecture Notes for Grade 12</h1>
<h2 class="unnumbered" id="definition">1. Definition</h2>
<p>Let <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> be two events in a sample space <span
class="math inline">\(S\)</span> with <span
class="math inline">\(P(B)&gt;0\)</span>. The <strong>conditional
probability</strong> of <span class="math inline">\(A\)</span> given
<span class="math inline">\(B\)</span> is denoted by <span
class="math inline">\(P(A\mid B)\)</span> and defined as <span
class="math display">\[P(A\mid B)=\frac{P(A\cap B)}{P(B)}.\]</span> If
<span class="math inline">\(P(B)=0\)</span> the conditional probability
is not defined.</p>
<h2 class="unnumbered" id="basic-properties">2. Basic Properties</h2>
<ul>
<li><p><span class="math inline">\(0\le P(A\mid B)\le
1\)</span>.</p></li>
<li><p><span class="math inline">\(P(B\mid B)=1\)</span>.</p></li>
<li><p>If <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are independent, then <span
class="math inline">\(P(A\mid B)=P(A)\)</span> and <span
class="math inline">\(P(B\mid A)=P(B)\)</span>.</p></li>
<li><p>Multiplication rule: <span class="math inline">\(P(A\cap
B)=P(A)\,P(B\mid A)=P(B)\,P(A\mid B)\)</span>.</p></li>
</ul>
<h2 class="unnumbered" id="illustrative-examples">3. Illustrative
Examples</h2>
<div class="example">
<p><strong>Example 1</strong>. <em>Given <span
class="math inline">\(P(A)=0.97\)</span> and <span
class="math inline">\(P(B\mid A)=0.95\)</span>, find <span
class="math inline">\(P(A\cap B)\)</span>. <span
class="math display">\[P(A\cap B)=P(A)\,P(B\mid A)=0.97\times
0.95=0.9215\approx0.92.\]</span></em></p>
</div>
<div class="example">
<p><strong>Example 2</strong>. <em>Suppose <span
class="math inline">\(P(A)=0.30\)</span> and <span
class="math inline">\(P(A\cap B)=0.24\)</span>. Compute <span
class="math inline">\(P(\neg B\mid A)\)</span>.<br />
First find <span class="math inline">\(P(B\mid A)=\dfrac{P(A\cap
B)}{P(A)}=\dfrac{0.24}{0.30}=0.8\)</span>. Then <span
class="math inline">\(P(\neg B\mid A)=1-P(B\mid
A)=1-0.8=0.2\)</span>.</em></p>
</div>
<div class="example">
<p><strong>Example 3</strong>. <em>In class 12A there are <span
class="math inline">\(30\)</span> students, <span
class="math inline">\(17\)</span> of whom are female. Three students are
named Hiền: one female and two males. Find the probability that a
randomly called student is named <strong>Hiền</strong>
<strong>and</strong> is female. <span
class="math display">\[P(\text{Hiền and female})=\frac{\text{number of
female Hiền}}{\text{total students}}=\frac{1}{30}.\]</span></em></p>
</div>
<div class="example">
<p><strong>Example 4</strong>. <em>Compute <span
class="math inline">\(P(A\mid B)\)</span> when <span
class="math inline">\(P(A)=\frac{13}{40}\)</span>, <span
class="math inline">\(P(B)=\frac{17}{40}\)</span>, and <span
class="math inline">\(P(A\cap B)=\frac{5}{40}\)</span>. <span
class="math display">\[P(A\mid B)=\frac{P(A\cap
B)}{P(B)}=\frac{5/40}{17/40}=\frac{5}{17}.\]</span></em></p>
</div>
<h2 class="unnumbered" id="practice-problems">4. Practice Problems</h2>
<div class="problem">
<p><strong>Problem 1</strong>. <em>A bag contains <span
class="math inline">\(6\)</span> red, <span
class="math inline">\(4\)</span> blue, and <span
class="math inline">\(5\)</span> green marbles. Two marbles are drawn
without replacement. Find the probability that the second marble is blue
given that the first marble drawn was red.</em></p>
</div>
<div class="problem">
<p><strong>Problem 2</strong>. <em>In a survey of <span
class="math inline">\(200\)</span> students, <span
class="math inline">\(120\)</span> like Mathematics, <span
class="math inline">\(80\)</span> like Physics, and <span
class="math inline">\(50\)</span> like both subjects. What is the
probability that a student likes Physics given that the student likes
Mathematics?</em></p>
</div>
<div class="problem">
<p><strong>Problem 3</strong>. <em>From the data: <span
class="math inline">\(P(A)=0.06\)</span>, <span
class="math inline">\(P(B)=0.07\)</span>, <span
class="math inline">\(P(A\cap B)=0.03\)</span>. Calculate <span
class="math inline">\(P(A\mid B)\)</span> and interpret the
result.</em></p>
</div>
<div class="problem">
<p><strong>Problem 4</strong>. <em>A class consists of <span
class="math inline">\(4\)</span> graduate and <span
class="math inline">\(12\)</span> undergraduate students. The <span
class="math inline">\(16\)</span> students are randomly divided into
<span class="math inline">\(4\)</span> groups of <span
class="math inline">\(4\)</span>. What is the probability that each
group contains at least one graduate student?</em></p>
</div>
<h2 class="unnumbered" id="solutions-to-practice-problems">5. Solutions
to Practice Problems</h2>
<div class="solution">
<p><strong>Solution 1</strong>. <em><strong>Problem 1.</strong> Let
<span class="math inline">\(R_1\)</span> be the event “first marble is
red” and <span class="math inline">\(B_2\)</span> the event “second
marble is blue”. We need <span class="math inline">\(P(B_2\mid
R_1)=\dfrac{P(R_1\cap B_2)}{P(R_1)}\)</span>.</em></p>
<ul>
<li><p><em><span
class="math inline">\(P(R_1)=\dfrac{6}{15}=\dfrac{2}{5}\)</span>.</em></p></li>
<li><p><em>After drawing a red marble, there are <span
class="math inline">\(5\)</span> red, <span
class="math inline">\(4\)</span> blue, <span
class="math inline">\(5\)</span> green left (<span
class="math inline">\(14\)</span> total). <span
class="math inline">\(P(R_1\cap
B_2)=\dfrac{6}{15}\times\dfrac{4}{14}=\dfrac{24}{210}=\dfrac{4}{35}\)</span>.</em></p></li>
</ul>
<p><em>Thus <span class="math display">\[P(B_2\mid
R_1)=\frac{4/35}{2/5}=\frac{4}{35}\times\frac{5}{2}=\frac{20}{70}=\frac{2}{7}.\]</span></em></p>
</div>
<div class="solution">
<p><strong>Solution 2</strong>. <em><strong>Problem 2.</strong> Let
<span class="math inline">\(M\)</span> = “likes Mathematics”, <span
class="math inline">\(Ph\)</span> = “likes Physics”. We need <span
class="math inline">\(P(Ph\mid M)=\dfrac{P(M\cap
Ph)}{P(M)}\)</span>.</em></p>
<ul>
<li><p><em><span
class="math inline">\(P(M)=\dfrac{120}{200}=0.60\)</span>.</em></p></li>
<li><p><em><span class="math inline">\(P(M\cap
Ph)=\dfrac{50}{200}=0.25\)</span>.</em></p></li>
</ul>
<p><em>Hence <span class="math display">\[P(Ph\mid
M)=\frac{0.25}{0.60}=\frac{5}{12}\approx0.4167.\]</span></em></p>
</div>
<div class="solution">
<p><strong>Solution 3</strong>. <em><strong>Problem 3.</strong> Given
<span class="math inline">\(P(A)=0.06\)</span>, <span
class="math inline">\(P(B)=0.07\)</span>, <span
class="math inline">\(P(A\cap B)=0.03\)</span>, <span
class="math display">\[P(A\mid B)=\frac{P(A\cap
B)}{P(B)}=\frac{0.03}{0.07}\approx0.4286.\]</span> Interpretation:
Knowing that event <span class="math inline">\(B\)</span> has occurred
raises the chance of <span class="math inline">\(A\)</span> from <span
class="math inline">\(6\%\)</span> to about <span
class="math inline">\(42.9\%\)</span>.</em></p>
</div>
<div class="solution">
<p><strong>Solution 4</strong>. <em><strong>Problem 4.</strong> We use
the complement approach: compute the probability that at least one group
receives no graduate student and subtract from <span
class="math inline">\(1\)</span>.</em></p>
<p><em>Total ways to assign the <span class="math inline">\(16\)</span>
distinct students to <span class="math inline">\(4\)</span> labelled
groups of size <span class="math inline">\(4\)</span>: <span
class="math display">\[N_{\text{total}}=\frac{16!}{(4!)^{4}}.\]</span></em></p>
<p><em>Now count assignments where a specific group, say group 1, gets
no graduate. All <span class="math inline">\(4\)</span> graduates must
go to the remaining <span class="math inline">\(3\)</span> groups (each
of size <span class="math inline">\(4\)</span>), leaving <span
class="math inline">\(12\)</span> undergraduates to fill the <span
class="math inline">\(16\)</span> spots. Choose <span
class="math inline">\(4\)</span> undergraduates for group 1: <span
class="math inline">\(\binom{12}{4}\)</span> ways. The remaining <span
class="math inline">\(12\)</span> students (4 graduates + 8
undergraduates) are distributed among groups 2,3,4: <span
class="math display">\[\frac{12!}{(4!)^{3}}.\]</span> Thus for a fixed
group: <span class="math display">\[N_{\text{no grad in that
group}}=\binom{12}{4}\frac{12!}{(4!)^{3}}.\]</span></em></p>
<p><em>By the inclusion–exclusion principle for <span
class="math inline">\(4\)</span> groups, the number of assignments with
<strong>at least one</strong> empty‑graduate group is <span
class="math display">\[\begin{aligned}
N_{\ge 1}&amp;=4\binom{12}{4}\frac{12!}{(4!)^{3}}
          -6\binom{12}{4}\binom{8}{4}\frac{8!}{(4!)^{2}}\\
        &amp;\quad+4\binom{12}{4}\binom{8}{4}\binom{4}{4}\frac{4!}{4!}
          -1\cdot\binom{12}{4}\binom{8}{4}\binom{4}{4}\binom{0}{0}\\
        &amp;=4\binom{12}{4}\frac{12!}{(4!)^{3}}
          -6\binom{12}{4}\binom{8}{4}\frac{8!}{(4!)^{2}}
          +4\binom{12}{4}\binom{8}{4}.
\end{aligned}\]</span></em></p>
<p><em>Therefore the desired probability is <span
class="math display">\[P=\;1-\frac{N_{\ge 1}}{N_{\text{total}}}
   \;=\;1-\frac{
          4\binom{12}{4}\dfrac{12!}{(4!)^{3}}
         -6\binom{12}{4}\binom{8}{4}\dfrac{8!}{(4!)^{2}}
         +4\binom{12}{4}\binom{8}{4}
        }{\dfrac{16!}{(4!)^{4}}}.\]</span></em></p>
<p><em>Evaluating the factorials gives <span
class="math display">\[P\approx 0.263\;(\text{about
}26.3\%).\]</span></em></p>
</div>
<h2 class="unnumbered" id="summary">6. Summary</h2>
<p>Conditional probability quantifies how the likelihood of an event
changes when we know that another event has occurred. The core formula
<span class="math inline">\(P(A\mid B)=\dfrac{P(A\cap B)}{P(B)}\)</span>
together with the multiplication rule and independence property forms
the foundation for solving a wide variety of problems—from simple
card‑draw scenarios to more complex grouping situations as illustrated
above.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Total Probability Formula and Bayes'' Theorem', 'Công thức xác suất toàn phần và định lý Bayes — Lớp 12.', '', 'article', '12', '<h1 class="unnumbered" id="basic-notation">1. Basic Notation</h1>
<p>Let <span
class="math inline">\((\Omega,\mathcal{F},\mathbb{P})\)</span> be a
probability space. For events <span
class="math inline">\(A,B\subseteq\Omega\)</span> we write:</p>
<ul>
<li><p><span class="math inline">\(\mathbb{P}(A)\)</span> – probability
of <span class="math inline">\(A\)</span>;</p></li>
<li><p><span class="math inline">\(\mathbb{P}(A\mid
B)=\dfrac{\mathbb{P}(A\cap B)}{\mathbb{P}(B)}\)</span> – conditional
probability of <span class="math inline">\(A\)</span> given <span
class="math inline">\(B\)</span> (provided <span
class="math inline">\(\mathbb{P}(B)&gt;0\)</span>);</p></li>
<li><p><span class="math inline">\(A^{c}\)</span> – complement of <span
class="math inline">\(A\)</span> (<span
class="math inline">\(\mathbb{P}(A^{c})=1-\mathbb{P}(A)\)</span>);</p></li>
<li><p>A collection <span class="math inline">\(\{A_{1},A_{2},\dots
,A_{n}\}\)</span> is a <em>partition</em> of <span
class="math inline">\(\Omega\)</span> if the <span
class="math inline">\(A_i\)</span> are pairwise disjoint and <span
class="math inline">\(\bigcup_{i=1}^{n}A_i=\Omega\)</span>.</p></li>
</ul>
<h1 class="unnumbered" id="law-of-total-probability">2. Law of Total
Probability</h1>
<p>If <span class="math inline">\(\{A_{1},A_{2},\dots ,A_{n}\}\)</span>
is a partition of <span class="math inline">\(\Omega\)</span>, then for
any event <span class="math inline">\(B\)</span> <span
class="math display">\[\mathbb{P}(B)=\sum_{i=1}^{n}\mathbb{P}(B\mid
A_{i})\,\mathbb{P}(A_{i}).
\tag{1}\]</span> In words: the probability of <span
class="math inline">\(B\)</span> is the weighted average of the
conditional probabilities <span class="math inline">\(\mathbb{P}(B\mid
A_i)\)</span>, the weights being the probabilities of the partitioning
events.</p>
<h2 class="unnumbered" id="simple-two-case-version">2.1 Simple two-case
version</h2>
<p>When the partition consists of an event <span
class="math inline">\(A\)</span> and its complement <span
class="math inline">\(A^{c}\)</span>, <span
class="math display">\[\mathbb{P}(B)=\mathbb{P}(B\mid
A)\,\mathbb{P}(A)+\mathbb{P}(B\mid A^{c})\,\mathbb{P}(A^{c}).
\tag{2}\]</span></p>
<h2 class="unnumbered" id="example">2.2 Example</h2>
<p>Suppose a factory has two machines:</p>
<ul>
<li><p>Machine 1 produces <span class="math inline">\(70\%\)</span> of
the items and has a defect rate <span
class="math inline">\(2\%\)</span>;</p></li>
<li><p>Machine 2 produces <span class="math inline">\(30\%\)</span> of
the items and has a defect rate <span
class="math inline">\(3\%\)</span>.</p></li>
</ul>
<p>Let <span class="math inline">\(D\)</span> be the event “a randomly
chosen item is defective”. Using (2): <span
class="math display">\[\mathbb{P}(D)=0.7\cdot0.02+0.3\cdot0.03=0.023.\]</span>
Thus <span class="math inline">\(2.3\%\)</span> of all items are
defective.</p>
<h1 class="unnumbered" id="bayes-theorem">3. Bayes’ Theorem</h1>
<p>Starting from the definition of conditional probability, <span
class="math display">\[\mathbb{P}(A_i\mid B)=\frac{\mathbb{P}(B\mid
A_i)\,\mathbb{P}(A_i)}{\mathbb{P}(B)}.
\tag{3}\]</span> If we substitute the expression for <span
class="math inline">\(\mathbb{P}(B)\)</span> from the law of total
probability (1), we obtain the <em>Bayes formula</em>: <span
class="math display">\[\boxed{\displaystyle
\mathbb{P}(A_i\mid B)=\frac{\mathbb{P}(B\mid A_i)\,\mathbb{P}(A_i)}
{\displaystyle\sum_{j=1}^{n}\mathbb{P}(B\mid A_j)\,\mathbb{P}(A_j)} }.
\tag{4}\]</span></p>
<h2 class="unnumbered" id="two-case-version">3.1 Two-case version</h2>
<p>With a partition <span class="math inline">\(\{A,A^{c}\}\)</span>,
<span class="math display">\[\mathbb{P}(A\mid B)=\frac{\mathbb{P}(B\mid
A)\,\mathbb{P}(A)}
{\mathbb{P}(B\mid A)\,\mathbb{P}(A)+\mathbb{P}(B\mid
A^{c})\,\mathbb{P}(A^{c})}.
\tag{5}\]</span></p>
<h2 class="unnumbered" id="example-1">3.2 Example</h2>
<p>Continuing the factory example, let us find the probability that a
defective item came from Machine 1. <span
class="math display">\[\mathbb{P}(\text{Machine 1}\mid
D)=\frac{0.7\cdot0.02}{0.7\cdot0.02+0.3\cdot0.03}
=\frac{0.014}{0.023}\approx0.6087.\]</span> So about <span
class="math inline">\(60.9\%\)</span> of defective items are produced by
Machine 1.</p>
<h1 class="unnumbered" id="worked-out-examples">4. Worked-out
Examples</h1>
<h2 class="unnumbered" id="example-1-plant-disease">Example 1 (Plant
disease)</h2>
<p>A field contains <span class="math inline">\(60\%\)</span> corn and
<span class="math inline">\(40\%\)</span> soybeans. The probability that
a corn plant is diseased is <span class="math inline">\(0.15\)</span>;
for a soybean plant it is <span class="math inline">\(0.10\)</span>.</p>
<ul>
<li><p><strong>Total probability of a diseased plant:</strong> <span
class="math display">\[\mathbb{P}(\text{diseased})=0.6\cdot0.15+0.4\cdot0.10=0.13.\]</span></p></li>
<li><p><strong>Probability that a diseased plant is corn:</strong> <span
class="math display">\[\mathbb{P}(\text{corn}\mid\text{diseased})=
    \frac{0.6\cdot0.15}{0.13}\approx0.6923.\]</span></p></li>
</ul>
<h2 class="unnumbered" id="example-2-medical-test">Example 2 (Medical
test)</h2>
<p>A disease has prevalence <span class="math inline">\(0.1\)</span>
(i.e., <span class="math inline">\(\mathbb{P}(D)=0.1\)</span>). A test
is positive with probability <span class="math inline">\(0.98\)</span>
if the person actually has the disease (<span
class="math inline">\(\mathbb{P}(T^{+}\mid D)=0.98\)</span>) and with
probability <span class="math inline">\(0.02\)</span> if the person is
healthy (<span class="math inline">\(\mathbb{P}(T^{+}\mid
D^{c})=0.02\)</span>).</p>
<ul>
<li><p><strong>Probability of a positive test:</strong> <span
class="math display">\[\mathbb{P}(T^{+})=0.98\cdot0.1+0.02\cdot0.9=0.098+0.018=0.116.\]</span></p></li>
<li><p><strong>Probability that a person actually has the disease given
a positive test:</strong> <span class="math display">\[\mathbb{P}(D\mid
T^{+})=
    \frac{0.98\cdot0.1}{0.116}\approx0.8448.\]</span></p></li>
</ul>
<h1 class="unnumbered" id="practice-problems">5. Practice Problems</h1>
<dl>
<dt>Problem 1</dt>
<dd>
<p>In a city, <span class="math inline">\(30\%\)</span> of residents use
public transport, <span class="math inline">\(70\%\)</span> use private
cars. Among public-transport users, <span
class="math inline">\(5\%\)</span> are late for work; among car users,
<span class="math inline">\(12\%\)</span> are late. (a) What is the
overall probability that a randomly chosen resident is late for work?
(b) If a resident is late, what is the probability that they use public
transport?</p>
</dd>
<dt>Problem 2</dt>
<dd>
<p>A box contains three types of biased coins: Coin A shows heads with
probability <span class="math inline">\(0.2\)</span> (40% of the coins),
Coin B shows heads with probability <span
class="math inline">\(0.5\)</span> (35% of the coins), Coin C shows
heads with probability <span class="math inline">\(0.8\)</span> (25% of
the coins). A coin is selected at random and flipped once, yielding
heads. Find the probability that the selected coin was Coin C.</p>
</dd>
<dt>Problem 3</dt>
<dd>
<p>A diagnostic test for a rare condition has sensitivity <span
class="math inline">\(0.95\)</span> (probability of a positive result
when the condition is present) and specificity <span
class="math inline">\(0.90\)</span> (probability of a negative result
when the condition is absent). The condition occurs in <span
class="math inline">\(0.2\%\)</span> of the population. Compute the
probability that a person actually has the condition given a positive
test result.</p>
</dd>
</dl>
<h1 class="unnumbered" id="solutions-to-practice-problems">6. Solutions
to Practice Problems</h1>
<h2 class="unnumbered" id="solution-to-problem-1">Solution to Problem
1</h2>
<p>Let <span class="math inline">\(L\)</span> be the event “late for
work”, <span class="math inline">\(P\)</span> the event “uses public
transport”, and <span class="math inline">\(C\)</span> the event “uses
car”. We have <span class="math inline">\(\mathbb{P}(P)=0.3\)</span>,
<span class="math inline">\(\mathbb{P}(C)=0.7\)</span>, <span
class="math inline">\(\mathbb{P}(L\mid P)=0.05\)</span>, <span
class="math inline">\(\mathbb{P}(L\mid C)=0.12\)</span>.</p>
<p><strong>(a) Total probability:</strong> <span
class="math display">\[\mathbb{P}(L)=\mathbb{P}(L\mid
P)\mathbb{P}(P)+\mathbb{P}(L\mid C)\mathbb{P}(C)
=0.05\cdot0.3+0.12\cdot0.7=0.015+0.084=0.099.\]</span> Thus <span
class="math inline">\(9.9\%\)</span> of residents are late.</p>
<p><strong>(b) Bayes’ theorem:</strong> <span
class="math display">\[\mathbb{P}(P\mid L)=\frac{\mathbb{P}(L\mid
P)\mathbb{P}(P)}{\mathbb{P}(L)}
=\frac{0.05\cdot0.3}{0.099}
=\frac{0.015}{0.099}\approx0.1515.\]</span> So about <span
class="math inline">\(15.2\%\)</span> of late residents use public
transport.</p>
<h2 class="unnumbered" id="solution-to-problem-2">Solution to Problem
2</h2>
<p>Let <span class="math inline">\(H\)</span> denote the event “heads
appears”. Let <span class="math inline">\(A,B,C\)</span> be the events
that the selected coin is of type A, B, C respectively. Given: <span
class="math display">\[\mathbb{P}(A)=0.4,\;\mathbb{P}(B)=0.35,\;\mathbb{P}(C)=0.25,\]</span>
<span class="math display">\[\mathbb{P}(H\mid A)=0.2,\;\mathbb{P}(H\mid
B)=0.5,\;\mathbb{P}(H\mid C)=0.8.\]</span></p>
<p><strong>Total probability of heads:</strong> <span
class="math display">\[\mathbb{P}(H)=0.2\cdot0.4+0.5\cdot0.35+0.8\cdot0.25
=0.08+0.175+0.20=0.455.\]</span></p>
<p><strong>Probability that the coin is C given heads:</strong> <span
class="math display">\[\mathbb{P}(C\mid H)=\frac{\mathbb{P}(H\mid
C)\mathbb{P}(C)}{\mathbb{P}(H)}
=\frac{0.8\cdot0.25}{0.455}
=\frac{0.20}{0.455}\approx0.4396.\]</span> Thus there is about a <span
class="math inline">\(44\%\)</span> chance the selected coin was type
C.</p>
<h2 class="unnumbered" id="solution-to-problem-3">Solution to Problem
3</h2>
<p>Define:</p>
<ul>
<li><p><span class="math inline">\(D\)</span>: person has the condition;
<span class="math inline">\(\mathbb{P}(D)=0.002\)</span>.</p></li>
<li><p><span class="math inline">\(T^{+}\)</span>: test result is
positive.</p></li>
</ul>
<p>Given: <span class="math display">\[\mathbb{P}(T^{+}\mid
D)=0.95\quad\text{(sensitivity)},\]</span> <span
class="math display">\[\mathbb{P}(T^{+}\mid
D^{c})=1-\text{specificity}=1-0.90=0.10.\]</span></p>
<p><strong>Total probability of a positive test:</strong> <span
class="math display">\[\mathbb{P}(T^{+})=0.95\cdot0.002+0.10\cdot0.998
=0.0019+0.0998=0.1017.\]</span></p>
<p><strong>Probability of having the condition given a positive
test:</strong> <span class="math display">\[\mathbb{P}(D\mid T^{+})=
\frac{0.95\cdot0.002}{0.1017}
=\frac{0.0019}{0.1017}\approx0.0187.\]</span> So even with a positive
test, only about <span class="math inline">\(1.9\%\)</span> of
individuals actually have the condition—illustrating the impact of low
prevalence.</p>
<h1 class="unnumbered" id="summary-of-key-formulas">7. Summary of Key
Formulas</h1>
<ul>
<li><p><strong>Law of Total Probability (partition <span
class="math inline">\(\{A_i\}\)</span>):</strong> <span
class="math display">\[\boxed{\displaystyle
    \mathbb{P}(B)=\sum_{i}\mathbb{P}(B\mid
A_i)\,\mathbb{P}(A_i)}.\]</span></p></li>
<li><p><strong>Bayes’ Theorem:</strong> <span
class="math display">\[\boxed{\displaystyle
    \mathbb{P}(A_i\mid B)=\frac{\mathbb{P}(B\mid A_i)\,\mathbb{P}(A_i)}
    {\sum_{j}\mathbb{P}(B\mid A_j)\,\mathbb{P}(A_j)}}.\]</span></p></li>
<li><p><strong>Two-event version (with complement):</strong> <span
class="math display">\[\mathbb{P}(B)=\mathbb{P}(B\mid
A)\mathbb{P}(A)+\mathbb{P}(B\mid A^{c})\mathbb{P}(A^{c}),\]</span> <span
class="math display">\[\mathbb{P}(A\mid B)=\frac{\mathbb{P}(B\mid
A)\mathbb{P}(A)}
    {\mathbb{P}(B\mid A)\mathbb{P}(A)+\mathbb{P}(B\mid
A^{c})\mathbb{P}(A^{c})}.\]</span></p></li>
</ul>
');