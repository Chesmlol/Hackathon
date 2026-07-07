-- Xoá bản ghi trùng tên (nếu đã import trước đó), rồi chèn lại với difficulty='11'
DELETE FROM lessons WHERE title = 'Union, Intersection, and Independent Events';
DELETE FROM lessons WHERE title = 'Addition Rule of Probability';
DELETE FROM lessons WHERE title = 'Product of Probabilities of Two Independent Events';

INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Union, Intersection, and Independent Events', 'Hợp, giao và tính độc lập của biến cố — quy tắc cộng xác suất.', '', 'article', '11', '<h1 class="unnumbered"
id="union-intersection-and-independence-of-events-grade-11">Union,
Intersection, and Independence of Events (Grade 11)</h1>
<h2 class="unnumbered" id="union-of-events">1. Union of Events</h2>
<div class="trivlist">
<p>For two events <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> in a sample space <span
class="math inline">\(S\)</span>, the <strong>union</strong> <span
class="math inline">\(A\cup B\)</span> is the event that occurs when at
least one of <span class="math inline">\(A\)</span> or <span
class="math inline">\(B\)</span> occurs: <span
class="math display">\[A\cup B=\{x\in S\mid x\in A\ \text{or}\ x\in
B\}.\]</span></p>
</div>
<div class="trivlist">
<p>For any two events <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span>, <span class="math display">\[P(A\cup
B)=P(A)+P(B)-P(A\cap B).\]</span> If <span
class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are <em>mutually exclusive</em> (<span
class="math inline">\(A\cap B=\varnothing\)</span>), then <span
class="math inline">\(P(A\cup B)=P(A)+P(B)\)</span>.</p>
</div>
<div class="trivlist">
<p>Let <span class="math inline">\(A\)</span> be the event “the die
shows an even number’’ and <span class="math inline">\(B\)</span> the
event “the die shows a number <span class="math inline">\(\ge
4\)</span>’’ on a fair six-sided die. <span
class="math inline">\(A=\{2,4,6\}\)</span>, <span
class="math inline">\(B=\{4,5,6\}\)</span>, <span
class="math inline">\(A\cap B=\{4,6\}\)</span>. Thus <span
class="math display">\[P(A)=\frac{3}{6},\quad P(B)=\frac{3}{6},\quad
P(A\cap B)=\frac{2}{6},\]</span> and <span
class="math display">\[P(A\cup
B)=\frac{3}{6}+\frac{3}{6}-\frac{2}{6}=\frac{4}{6}=\frac{2}{3}.\]</span></p>
</div>
<div class="trivlist">
<p>Romeo and Juliet each arrive uniformly at random between 0 and 1
hour. Let <span class="math inline">\(X\)</span> be Romeo’s arrival time
and <span class="math inline">\(Y\)</span> Juliet’s. Define the meeting
event <span class="math inline">\(M=\{(x,y):|x-y|\le
\tfrac{1}{4}\}\)</span>. Compute <span
class="math inline">\(P(M)\)</span>.</p>
</div>
<div class="trivlist">
<p>The region <span class="math inline">\(|x-y|\le \frac{1}{4}\)</span>
inside the unit square has an area calculated by subtracting the two
corner triangles from the total area (1): <span
class="math display">\[\text{Area} = 1 - 2\left(\frac{1}{2} \cdot
\frac{3}{4} \cdot \frac{3}{4}\right) = 1 - \frac{9}{16} =
\frac{7}{16}.\]</span> Since the joint distribution is uniform, <span
class="math inline">\(P(M)=\frac{7}{16}\)</span>.</p>
</div>
<div class="trivlist">
<p>Let <span class="math inline">\(A=\{\text{even numbers } &gt;9 \text{
up to } 20\}\)</span> and <span
class="math inline">\(B=\{8,9,\dots,15\}\)</span>. Find <span
class="math inline">\(|A\cup B|\)</span>.</p>
</div>
<div class="trivlist">
<p><span class="math inline">\(A=\{10,12,14,16,18,20\}\)</span>, <span
class="math inline">\(|A|=6\)</span>. <span
class="math inline">\(B=\{8,9,10,11,12,13,14,15\}\)</span>, <span
class="math inline">\(|B|=8\)</span>. <span class="math inline">\(A\cap
B=\{10,12,14\}\)</span>, <span class="math inline">\(|A\cap
B|=3\)</span>. Hence <span class="math inline">\(|A\cup
B|=|A|+|B|-|A\cap B|=6+8-3=11\)</span>.</p>
</div>
<h2 class="unnumbered" id="intersection-of-events">2. Intersection of
Events</h2>
<div class="trivlist">
<p>The <strong>intersection</strong> <span class="math inline">\(A\cap
B\)</span> is the event that occurs when both <span
class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> occur: <span
class="math display">\[A\cap B=\{x\in S\mid x\in A\ \text{and}\ x\in
B\}.\]</span></p>
</div>
<div class="trivlist">
<p>For any events <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span>, <span class="math display">\[P(A\cap
B)=P(A)+P(B)-P(A\cup B).\]</span> If <span
class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are independent, then <span
class="math inline">\(P(A\cap B)=P(A)P(B)\)</span>.</p>
</div>
<div class="trivlist">
<p>A box contains 5 blue and 3 red balls. Two balls are drawn without
replacement. Let <span class="math inline">\(A\)</span> be “first ball
is blue’’ and <span class="math inline">\(B\)</span> “second ball is
blue’’. Compute <span class="math inline">\(P(A\cap B)\)</span>.</p>
</div>
<div class="trivlist">
<p><span class="math inline">\(P(A)=\frac{5}{8}\)</span>. After a blue
is removed, 4 blue and 3 red remain, so <span
class="math inline">\(P(B\mid A)=\frac{4}{7}\)</span>. Thus <span
class="math inline">\(P(A\cap B)=P(A)P(B\mid
A)=\frac{5}{8}\cdot\frac{4}{7}=\frac{20}{56}=\frac{5}{14}\)</span>.</p>
</div>
<h2 class="unnumbered" id="independent-events">3. Independent
Events</h2>
<div class="trivlist">
<p>Two events <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are <strong>independent</strong> if
<span class="math display">\[P(A\cap B)=P(A)P(B).\]</span> Independence
does <em>not</em> imply mutual exclusivity; in fact, if <span
class="math inline">\(P(A)&gt;0\)</span> and <span
class="math inline">\(P(B)&gt;0\)</span>, mutually exclusive events
cannot be independent.</p>
</div>
<div class="trivlist">
<p>In a standard deck, let <span class="math inline">\(A\)</span> be
“the card is red’’ and <span class="math inline">\(B\)</span> “the card
is an Ace’’. <span
class="math display">\[P(A)=\frac{26}{52}=\frac{1}{2}, \quad
P(B)=\frac{4}{52}=\frac{1}{13}, \quad P(A\cap
B)=\frac{2}{52}=\frac{1}{26}.\]</span> Since <span
class="math inline">\(\frac{1}{2} \cdot \frac{1}{13} =
\frac{1}{26}\)</span>, the events are independent.</p>
</div>
<div class="trivlist">
<p>After removing the ace of spades from a deck, find a nontrivial pair
of independent events.</p>
</div>
<div class="trivlist">
<p>The deck now has 51 cards. Define the following two events: <span
class="math display">\[\begin{aligned}
A &amp;= \{\text{all hearts}\} \cup \{2\spadesuit, 3\spadesuit,
4\spadesuit, 5\spadesuit\}, \\
B &amp;= \{2\heartsuit, 3\diamondsuit, 4\clubsuit\}.
\end{aligned}\]</span> Sizes: <span class="math inline">\(|A| = 13 + 4 =
17\)</span>, <span class="math inline">\(|B| = 3\)</span>. The
intersection <span class="math inline">\(A\cap B\)</span> contains only
one card: <span class="math inline">\(\{2\heartsuit\}\)</span>. Thus
<span class="math inline">\(|A\cap B| = 1\)</span>. With <span
class="math inline">\(N=51\)</span> total cards: <span
class="math display">\[P(A) = \frac{17}{51}, \quad P(B) = \frac{3}{51} =
\frac{1}{17}, \quad P(A\cap B) = \frac{1}{51}.\]</span> Calculating the
product: <span class="math display">\[P(A)P(B) = \frac{17}{51} \cdot
\frac{3}{51} = \frac{51}{2601} = \frac{1}{51} = P(A\cap B).\]</span>
Since <span class="math inline">\(P(A\cap B) = P(A)P(B)\)</span>, events
<span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are independent.</p>
</div>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Addition Rule of Probability', 'Đi sâu vào quy tắc cộng P(A∪B) = P(A) + P(B) − P(A∩B) với ví dụ xúc xắc.', '', 'article', '11', '<h1 class="unnumbered" id="addition-rule-of-probability">Addition Rule
of Probability</h1>
<p>For any two events <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> in a sample space <span
class="math inline">\(S\)</span>,</p>
<p><span class="math display">\[P(A\cup B)=P(A)+P(B)-P(A\cap
B).\]</span></p>
<p>If <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are mutually exclusive (i.e., <span
class="math inline">\(A\cap B=\varnothing\)</span>), the formula
simplifies to</p>
<p><span class="math display">\[P(A\cup B)=P(A)+P(B).\]</span></p>
<h2 class="unnumbered" id="why-the-subtraction">Why the
subtraction?</h2>
<p>When we add <span class="math inline">\(P(A)\)</span> and <span
class="math inline">\(P(B)\)</span> we count the outcomes that belong to
both <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> twice. Subtracting <span
class="math inline">\(P(A\cap B)\)</span> removes the double count.</p>
<h2 class="unnumbered" id="example-1-dice-sums">Example 1 – Dice
sums</h2>
<p>Roll two fair six-sided dice. Let</p>
<ul>
<li><p><span class="math inline">\(A\)</span> = “the sum is 7”,</p></li>
<li><p><span class="math inline">\(B\)</span> = “the sum is
11”.</p></li>
</ul>
<p>The sample space has <span class="math inline">\(6\times6=36\)</span>
equally likely outcomes.</p>
<p><span class="math display">\[\begin{aligned}
P(A)&amp;=\frac{6}{36}=\frac{1}{6} \quad\text{(pairs:
}(1,6),(2,5),(3,4),(4,3),(5,2),(6,1)),\\[2mm]
P(B)&amp;=\frac{2}{36}=\frac{1}{18}\quad\text{(pairs: }(5,6),(6,5)).
\end{aligned}\]</span></p>
<p>Since a roll cannot simultaneously give a sum of 7 and 11, <span
class="math inline">\(A\cap B=\varnothing\)</span> and</p>
<p><span class="math display">\[P(A\cup
B)=P(A)+P(B)=\frac{1}{6}+\frac{1}{18}=\frac{3}{18}+\frac{1}{18}=\frac{4}{18}=\frac{2}{9}.\]</span></p>
<p>Thus the probability of obtaining a sum of 7 or 11 is <span
class="math inline">\(\displaystyle \frac{2}{9}\)</span>.</p>
<h2 class="unnumbered" id="example-2-overlapping-events">Example 2 –
Overlapping events</h2>
<p>Roll two dice again. Define</p>
<ul>
<li><p><span class="math inline">\(C\)</span> = “the sum is
even”,</p></li>
<li><p><span class="math inline">\(D\)</span> = “the sum is greater than
8”.</p></li>
</ul>
<p>We compute each probability:</p>
<p><span class="math display">\[\begin{aligned}
P(C)&amp;=\frac{18}{36}=\frac{1}{2} \quad\text{(half of the 36 outcomes
give an even sum)},\\[2mm]
P(D)&amp;=\frac{10}{36}=\frac{5}{18}\quad\text{(sums 9,10,11,12:
}4+3+2+1=10\text{ outcomes)}.
\end{aligned}\]</span></p>
<p>The intersection <span class="math inline">\(C\cap D\)</span>
consists of even sums greater than 8, i.e., 10 and 12.</p>
<p><span class="math display">\[P(C\cap
D)=\frac{3+1}{36}=\frac{4}{36}=\frac{1}{9}.\]</span></p>
<p>Now apply the addition rule:</p>
<p><span class="math display">\[\begin{aligned}
P(C\cup D)&amp;=P(C)+P(D)-P(C\cap D) \\
          &amp;=\frac{1}{2}+\frac{5}{18}-\frac{1}{9} \\
          &amp;=\frac{9}{18}+\frac{5}{18}-\frac{2}{18} \\
          &amp;=\frac{12}{18} \\
          &amp;=\frac{2}{3}.
\end{aligned}\]</span></p>
<p>Hence the chance of obtaining an even sum or a sum larger than 8 is
<span class="math inline">\(\displaystyle \frac{2}{3}\)</span>.</p>
<h2 class="unnumbered" id="practice-problems">Practice Problems</h2>
<ol>
<li><p><strong>Problem 1:</strong> A card is drawn from a standard
52-card deck. Let <span class="math inline">\(A\)</span> be “the card is
a heart” and <span class="math inline">\(B\)</span> be “the card is a
face card (J, Q, K)”. Find <span class="math inline">\(P(A\cup
B)\)</span>.</p></li>
<li><p><strong>Problem 2:</strong> In a class of 40 students, 22 study
mathematics, 18 study physics, and 9 study both subjects. What is the
probability that a randomly chosen student studies mathematics or
physics?</p></li>
<li><p><strong>Problem 3:</strong> Three fair coins are tossed. Let
<span class="math inline">\(E\)</span> be “at least one head appears”
and <span class="math inline">\(F\)</span> be “exactly two tails
appear”. Compute <span class="math inline">\(P(E\cup
F)\)</span>.</p></li>
</ol>
<h2 class="unnumbered" id="solutions">Solutions</h2>
<ol>
<li><p>There are 13 hearts and 12 face cards. The three face cards that
are hearts (J<span class="math inline">\(\heartsuit\)</span>, Q<span
class="math inline">\(\heartsuit\)</span>, K<span
class="math inline">\(\heartsuit\)</span>) are counted twice, so</p>
<p><span class="math display">\[P(A)=\frac{13}{52}=\frac{1}{4},\qquad
    P(B)=\frac{12}{52}=\frac{3}{13},\qquad
    P(A\cap B)=\frac{3}{52}.\]</span></p>
<p>Thus</p>
<p><span class="math display">\[P(A\cup
B)=\frac{1}{4}+\frac{3}{13}-\frac{3}{52}
              =\frac{13}{52}+\frac{12}{52}-\frac{3}{52}
              =\frac{22}{52}
              =\frac{11}{26}.\]</span></p></li>
<li><p>Using the addition rule for the events “studies mathematics”
(<span class="math inline">\(M\)</span>) and “studies physics” (<span
class="math inline">\(P\)</span>):</p>
<p><span class="math display">\[P(M)=\frac{22}{40}=\frac{11}{20},\quad
    P(P)=\frac{18}{40}=\frac{9}{20},\quad
    P(M\cap P)=\frac{9}{40}.\]</span></p>
<p>Hence</p>
<p><span class="math display">\[P(M\cup
P)=\frac{11}{20}+\frac{9}{20}-\frac{9}{40}
              =\frac{20}{20}-\frac{9}{40}
              =1-\frac{9}{40}
              =\frac{31}{40}.\]</span></p></li>
<li><p>The sample space for three coin tosses has <span
class="math inline">\(2^3=8\)</span> equally likely outcomes.</p>
<ul>
<li><p><span class="math inline">\(E\)</span> = “at least one head”. The
only outcome not in <span class="math inline">\(E\)</span> is TTT, so
<span
class="math inline">\(P(E)=1-\frac{1}{8}=\frac{7}{8}\)</span>.</p></li>
<li><p><span class="math inline">\(F\)</span> = “exactly two tails”. The
favorable outcomes are TTH, THT, HTT, so <span
class="math inline">\(P(F)=\frac{3}{8}\)</span>.</p></li>
<li><p><span class="math inline">\(E\cap F\)</span> = outcomes that
satisfy both: exactly two tails (which already guarantees at least one
head). Thus <span class="math inline">\(E\cap F = F\)</span> and <span
class="math inline">\(P(E\cap F)=\frac{3}{8}\)</span>.</p></li>
</ul>
<p>Applying the rule:</p>
<p><span class="math display">\[P(E\cup F)=P(E)+P(F)-P(E\cap F)
              =\frac{7}{8}+\frac{3}{8}-\frac{3}{8}
              =\frac{7}{8}.\]</span></p></li>
</ol>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Product of Probabilities of Two Independent Events', 'Quy tắc nhân cho biến cố độc lập P(A∩B) = P(A)P(B).', '', 'article', '11', '<h1 class="unnumbered"
id="product-of-the-probabilities-of-two-independent-events">Product of
the Probabilities of Two Independent Events</h1>
<p><em>Target audience: Grade 11 Mathematics</em></p>
<h2 class="unnumbered" id="definition-of-independent-events">Definition
of Independent Events</h2>
<p>Two events <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are said to be
<strong>independent</strong> if the occurrence of one does not affect
the probability of the other. Mathematically this is expressed as <span
class="math display">\[P(A\cap B)=P(A)\,P(B). \tag{1}\]</span> Equation
(1) is often called the <strong>product rule</strong> for independent
events.</p>
<p>From the definition we also obtain the conditional probabilities
<span class="math display">\[P(A\mid B)=\frac{P(A\cap
B)}{P(B)}=\frac{P(A)P(B)}{P(B)}=P(A),\]</span> <span
class="math display">\[P(B\mid A)=\frac{P(A\cap
B)}{P(A)}=\frac{P(A)P(B)}{P(A)}=P(B),\]</span> provided <span
class="math inline">\(P(A)&gt;0\)</span> and <span
class="math inline">\(P(B)&gt;0\)</span>. Hence, for independent events,
<span class="math display">\[P(A\mid B)=P(A)\qquad\text{and}\qquad
P(B\mid A)=P(B). \tag{2}\]</span></p>
<h2 class="unnumbered" id="why-the-product-works">Why the Product
Works</h2>
<p>Intuitively, if <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are independent, knowing that <span
class="math inline">\(B\)</span> happened does not change the chance of
<span class="math inline">\(A\)</span>. Therefore the fraction of
outcomes where both happen is simply the fraction where <span
class="math inline">\(A\)</span> happens multiplied by the fraction
where <span class="math inline">\(B\)</span> happens.</p>
<h2 class="unnumbered" id="examples">Examples</h2>
<ol>
<li><p><strong>Coin and die.</strong> Flip a fair coin (<span
class="math inline">\(A\)</span>: heads) and roll a fair six‑sided die
(<span class="math inline">\(B\)</span>: showing a 4). <span
class="math display">\[P(A)=\frac12,\qquad P(B)=\frac16.\]</span> Since
the coin flip does not influence the die roll, the events are
independent and <span class="math display">\[P(A\cap
B)=P(A)P(B)=\frac12\cdot\frac16=\frac1{12}.\]</span> Indeed, among the
12 equally likely outcomes <span class="math inline">\(\{H1,H2,\dots
,H6,T1,\dots ,T6\}\)</span> only <span class="math inline">\(H4\)</span>
satisfies both.</p></li>
<li><p><strong>Card draw with replacement.</strong> From a standard deck
of 52 cards draw two cards <em>with</em> replacement. Let <span
class="math inline">\(A\)</span>: first card is a spade, <span
class="math inline">\(B\)</span>: second card is a king. <span
class="math display">\[P(A)=\frac{13}{52}=\frac14,\qquad
  P(B)=\frac{4}{52}=\frac1{13}.\]</span> Because the first card is
replaced, the composition of the deck for the second draw is unchanged,
so <span class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are independent. <span
class="math display">\[P(A\cap
B)=\frac14\cdot\frac1{13}=\frac1{52}.\]</span> This matches the direct
count: there are 13 spades and 4 kings, giving <span
class="math inline">\(13\cdot4=52\)</span> favourable ordered pairs out
of <span class="math inline">\(52\cdot52\)</span> total.</p></li>
</ol>
<h2 class="unnumbered" id="practice-problems">Practice Problems</h2>
<ol>
<li><p>If <span class="math inline">\(P(A)=0.27\)</span> and <span
class="math inline">\(P(B)=0.43\)</span> and <span
class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are independent, find <span
class="math inline">\(P(A\cap B)\)</span>.</p></li>
<li><p>Given <span class="math inline">\(P(A)=0.55\)</span>, <span
class="math inline">\(P(B)=0.62\)</span> and <span
class="math inline">\(P(A\cap B)=0.341\)</span>, determine whether <span
class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are independent.</p></li>
<li><p>A bag contains 8 red marbles and 12 blue marbles. Two marbles are
drawn <em>with</em> replacement. Let <span
class="math inline">\(A\)</span> be “the first marble is red’’ and <span
class="math inline">\(B\)</span> be “the second marble is blue.’’
Compute <span class="math inline">\(P(A\cap B)\)</span>.</p></li>
<li><p>In a survey, 60% of students like mathematics (<span
class="math inline">\(M\)</span>) and 40% like physics (<span
class="math inline">\(P\)</span>). Assuming the preferences are
independent, what percentage of students like both subjects?</p></li>
</ol>
<h2 class="unnumbered" id="solutions">Solutions</h2>
<ol>
<li><p>Using the product rule (1): <span class="math display">\[P(A\cap
B)=P(A)P(B)=0.27\times0.43=0.1161.\]</span> Hence <span
class="math inline">\(P(A\cap B)=0.1161\)</span>.</p></li>
<li><p>Compute the product of the marginal probabilities: <span
class="math display">\[P(A)P(B)=0.55\times0.62=0.341.\]</span> Since
this equals the given <span class="math inline">\(P(A\cap
B)=0.341\)</span>, the condition (1) holds; therefore <span
class="math inline">\(A\)</span> and <span
class="math inline">\(B\)</span> are independent.</p></li>
<li><p>First draw: <span
class="math inline">\(P(A)=\frac{8}{8+12}=\frac{8}{20}=0.4\)</span>.
Second draw (with replacement): the composition is unchanged, so <span
class="math inline">\(P(B)=\frac{12}{20}=0.6\)</span>. By independence,
<span class="math display">\[P(A\cap B)=0.4\times0.6=0.24.\]</span> Thus
there is a 24% chance of drawing a red then a blue marble.</p></li>
<li><p>Convert percentages to decimals: <span
class="math inline">\(P(M)=0.60\)</span>, <span
class="math inline">\(P(P)=0.40\)</span>. Assuming independence, <span
class="math display">\[P(M\cap P)=0.60\times0.40=0.24.\]</span> Hence
24% of students like both mathematics and physics.</p></li>
</ol>
<h2 class="unnumbered" id="key-takeaways">Key Take‑aways</h2>
<ul>
<li><p>For independent events the joint probability is the product of
the individual probabilities: <span class="math inline">\(P(A\cap
B)=P(A)P(B)\)</span>.</p></li>
<li><p>The product rule follows directly from the definition of
independence and can be used to test independence: if <span
class="math inline">\(P(A\cap B)\stackrel{?}{=}P(A)P(B)\)</span> holds,
the events are independent.</p></li>
<li><p>When sampling <em>with</em> replacement, successive draws are
independent; without replacement they are generally <em>not</em>
independent.</p></li>
</ul>
');