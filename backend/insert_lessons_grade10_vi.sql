-- Xoá bản ghi trùng tên (nếu re-run), rồi chèn lại 7 bài tiếng Việt Lớp 10 (đã dọn 'từ ngữ cảnh' và metadata thừa)
DELETE FROM lessons WHERE title = 'Các Mệnh đề và Tập Hợp (Lớp 10)';
DELETE FROM lessons WHERE title = 'Làm Tròn Số và Hiểu Sai Số (Lớp 10)';
DELETE FROM lessons WHERE title = 'Số Đặc Trưng Đo Lường Xu Hướng Tập Trung (Lớp 10)';
DELETE FROM lessons WHERE title = 'Quy Tắc Đếm, Chỉnh Hợp và Tổ Hợp (Lớp 10)';
DELETE FROM lessons WHERE title = 'Định Lý Nhị Thức Newton (Lớp 10)';
DELETE FROM lessons WHERE title = 'Số Đặc Trưng Đo Lường Sự Phân Tán (Lớp 10)';
DELETE FROM lessons WHERE title = 'Sự Kiện và Định Nghĩa Cổ Điển của Xác Suất (Lớp 10)';

INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Các Mệnh đề và Tập Hợp (Lớp 10)', 'Mệnh đề, các phép toán logic và tập hợp — bản tiếng Việt.', '', 'article', '10', '<h1 id="các-mệnh-đề-và-tập-hợp-lớp-10">Các Mệnh đề và Tập Hợp Lớp
10</h1>
<h3 id="các-mệnh-đề">1. Các Mệnh đề</h3>
<p>Một mệnh đề là một câu trần thuật mà có thể đúng (Đ) hoặc sai (S),
nhưng không cả hai.</p>
<h2 id="các-liên-kết-logic">Các Liên Kết Logic</h2>
<p>● Phủ định: <span class="math inline">\(\neg p\)</span> (không <span
class="math inline">\(p\)</span> ). Bảng chân trị: <span
class="math inline">\(p \text{Đ} \rightarrow \text{S}\)</span> , <span
class="math inline">\(\text{S} \rightarrow \text{Đ}\)</span> .</p>
<p>• Phép hội: <span class="math inline">\(p \wedge q\)</span> (p và q).
Chỉ đúng khi cả p và q đều đúng.</p>
<p>• Phép tuyển: <span class="math inline">\(p \lor q\)</span> (p hoặc
q). Chỉ sai khi cả p và q đều sai.</p>
<p>• Phép kéo theo: <span class="math inline">\(p \rightarrow q\)</span>
(nếu p thì q). Chỉ sai khi p đúng và q sai.</p>
<p>● Phép tương đương: <span class="math inline">\(p \leftrightarrow
q\)</span> (p nếu và chỉ nếu q). Đúng khi p và q có cùng giá trị chân
trị.</p>
<p>Ví dụ: Gọi p: Đang mưa. q: Đường đất ướt.</p>
<p><span class="math inline">\(p \rightarrow q\)</span> đọc là Nếu đang
mưa, thì đường đất ướt.</p>
<h2 id="các-tương-đương-logic">Các Tương Đương Logic</h2>
<p><span class="math display">\[p\land q\equiv q\land p\]</span></p>
<p>(Đổi chỗ)</p>
<p><span class="math display">\[p\vee q\equiv q\vee p\]</span></p>
<p><span class="math display">\[(p\land q)\land r\equiv p\land(q\land
r)\]</span></p>
<p>(Đổi chỗ)</p>
<p><span class="math display">\[(p\vee q)\vee r\equiv p\vee(q\vee
r)\]</span></p>
<p>(Tập hợp)</p>
<p>(Tập hợp)</p>
<p><span class="math display">\[p\wedge(q\vee r)\equiv(p\wedge
q)\vee(p\wedge r)\]</span></p>
<p>(Phân phối)</p>
<p><span class="math display">\[p\vee(q\wedge r)\equiv(p\vee
q)\wedge(p\vee r)\]</span></p>
<p>(Phân phối)</p>
<p><span class="math display">\[\neg(\neg p)\equiv p\]</span></p>
<p>(Phủ định kép)</p>
<p><span class="math display">\[\neg(p\land q)\equiv\neg p\lor\neg
q\]</span></p>
<p>(De Morgan)</p>
<p><span class="math display">\[\neg(p\lor q)\equiv\neg p\land\neg
q\]</span></p>
<p>(De Morgan)</p>
<p><span class="math display">\[p\rightarrow q\equiv\lnot p\lor
q\]</span></p>
<p>(Kéo theo)</p>
<p><span class="math display">\[p\leftrightarrow q\equiv(p\rightarrow
q)\land(q\rightarrow p)\]</span></p>
<p>(Tương đương)</p>
<h3 id="tập-hợp">2. Tập Hợp</h3>
<p>Một tập hợp là một tập hợp các đối tượng phân biệt, gọi là các phần
tử hoặc thành viên.</p>
<h2 id="biểu-diễn">Biểu diễn</h2>
<p>• <span class="math inline">\(x \in A\)</span> : <span
class="math inline">\(x\)</span> là một phần tử của <span
class="math inline">\(A\)</span> .</p>
<p>• <span class="math inline">\(x \notin A\)</span> : <span
class="math inline">\(x\)</span> không phải là một phần tử của <span
class="math inline">\(A\)</span> .</p>
<ul>
<li><span class="math inline">\(A \subseteq B\)</span> : mọi phần tử của
<span class="math inline">\(A\)</span> cũng là phần tử của <span
class="math inline">\(B\)</span> (tập con).</li>
</ul>
<p>• <span class="math inline">\(A = B\)</span> : <span
class="math inline">\(A \subseteq B\)</span> và <span
class="math inline">\(B \subseteq A\)</span> .</p>
<p>• <span class="math inline">\(\emptyset\)</span> : tập rỗng (không có
phần tử nào).</p>
<p>● U: tập vũ trụ (tất cả các đối tượng đang được xét xem).</p>
<h2 id="các-phép-toán">Các phép toán</h2>
<p><span class="math display">\[A\cup B=\{x\mid x\in A hoặc x\in
B\}\]</span></p>
<p>(Union)</p>
<p><span class="math display">\[A\cap B=\{x\mid x\in A và x\in
B\}\]</span></p>
<p>(Intersection)</p>
<p><span class="math display">\[A\setminus B=\{x\mid x\in A và x\notin
B\}\]</span></p>
<p>(Difference)</p>
<p><span class="math display">\[\overline{A}=U\setminus A=\{x\in U\mid
x\notin A\}\]</span></p>
<p>(Complement)</p>
<p>Ví dụ: Cho <span class="math inline">\(U = \{1, 2, 3, 4, 5,
6\}\)</span> , <span class="math inline">\(A = \{1, 2, 3\}\)</span> ,
<span class="math inline">\(B = \{3, 4, 5\}\)</span> .</p>
<p><span class="math display">\[A\cup B=\{1,2,3,4,5\},\quad A\cap
B=\{3\},\quad A\setminus
B=\{1,2\},\quad\overline{A}=\{4,5,6\}\]</span></p>
<h2 id="các-định-luật-đại-số-tập-hợp">Các định luật Đại số Tập hợp</h2>
<p><span class="math display">\[A\cup B=B\cup A\]</span></p>
<p>(Đổi chỗ)</p>
<p><span class="math display">\[A\cap B=B\cap A\]</span></p>
<p>(Đổi chỗ)</p>
<p><span class="math display">\[(A\cup B)\cup C=A\cup(B\cup
C)\]</span></p>
<p><span class="math display">\[(A\cap B)\cap C=A\cap(B\cap
C)\]</span></p>
<p>(Phát sinh)</p>
<p>(Phát sinh)</p>
<p><span class="math display">\[A\cup(B\cap C)=(A\cup B)\cap(A\cup
C)\]</span></p>
<p>(Phân phối)</p>
<p><span class="math display">\[A\cap(B\cup C)=(A\cap B)\cup(A\cap
C)\]</span></p>
<p>(Phân phối)</p>
<p><span class="math display">\[A\cup\varnothing=A\]</span></p>
<p>(Định nghĩa)</p>
<p><span class="math display">\[A\cap U=A\]</span></p>
<p>(Định nghĩa)</p>
<p><span class="math display">\[A\cup\overline{A}=U\]</span></p>
<p>(Bổ túc)</p>
<p><span
class="math display">\[A\cap\overline{A}=\varnothing\]</span></p>
<p>(Bổ túc)</p>
<p><span class="math display">\[\overline{A}=A\]</span></p>
<p><span class="math display">\[\overline{A\cup
B}=\overline{A}\cap\overline{B}\]</span></p>
<p>(Định luật Bổ túc)</p>
<p><span class="math display">\[\overline{A\cap
B}=\overline{A}\cup\overline{B}\]</span></p>
<p>(Định luật De Morgan)</p>
<p>Nguyên lý Bao Hộp Loại Trừ (Hai Tập Hợp)</p>
<p><span class="math display">\[|A\cup B|=|A|+|B|-|A\cap B|\]</span></p>
<p>trong đó | · | chỉ số lượng phần tử (số phần tử).</p>
<p>Ví dụ: <span class="math inline">\(|A| = 43\)</span> , <span
class="math inline">\(|B| = 20\)</span> , <span class="math inline">\(|A
\cap B| = 7\)</span> .</p>
<p><span class="math display">\[|A\cup B|=43+20-7=56\]</span></p>
<h3 id="mối-liên-hệ-với-xác-suất-ngắn-gọn">3. Mối Liên Hệ Với Xác Suất
(Ngắn Gọn)</h3>
<p>Khi các kết quả có cùng khả năng xảy ra,</p>
<p><span class="math display">\[P(E)=\frac{|E|}{|U|}\]</span></p>
<p>và quy tắc bao hộp loại trừ cho xác suất là</p>
<p><span class="math display">\[P(A\cup B)=P(A)+P(B)-P(A\cap
B).\]</span></p>
<p>Ví dụ: 10 người chọn ngẫu nhiên một trong 5 toa tàu. Gọi A = toa đầu
trống, B = toa thứ hai trống.</p>
<p><span
class="math display">\[P(A)=P(B)=\left(\frac{4}{5}\right)^{10},\quad
P(A\cap B)=\left(\frac{3}{5}\right)^{10},\quad P(A\cup
B)=2\left(\frac{4}{5}\right)^{10}-\left(\frac{3}{5}\right)^{10}.\]</span></p>
<h3 id="bài-tập-thực-hành">4. Bài Tập Thực Hành</h3>
<ol type="1">
<li>Logic Câu Hỏi: Xác định giá trị chân lý của mệnh đề phức tạp</li>
</ol>
<p><span class="math display">\[[\left(p\to q\right)\land\left(\lnot
r\right)]\to\left[\left(p\lor q\right)\leftrightarrow
r\right]\]</span></p>
<p>khi p đúng, q sai, và r đúng.</p>
<ol start="2" type="1">
<li>Các Phép Tác Động Trên Tập Hợp Cho <span class="math inline">\(U =
\{a, b, c, d, e, f, g, h\}\)</span> , <span class="math inline">\(X =
\{a, b, c, d\}\)</span> , <span class="math inline">\(Y = \{c, d, e,
f\}\)</span> , <span class="math inline">\(Z = \{f, g, h\}\)</span> .
Tính:</li>
</ol>
<ol type="a">
<li><p><span class="math inline">\(X \cup Y\)</span></p></li>
<li><p><span class="math inline">\(Y \cap Z\)</span></p></li>
<li><p><span class="math inline">\(X \setminus Z\)</span></p></li>
<li><p><span class="math inline">\(\overline{Y}\)</span></p></li>
</ol>
<ol start="3" type="1">
<li><p>Bao Hộp Loại Trừ Trong một lớp có 30 học sinh, 18 học sinh thích
toán học, 12 học sinh thích vật lý, và 5 học sinh thích cả hai môn học.
Hỏi có bao nhiêu học sinh thích ít nhất một trong hai môn học?</p></li>
<li><p>Xác Suất Với Tập Hợp Một túi chứa 6 bi đỏ, 4 bi xanh, và 5 bi
lục. Hai viên bi được rút ra mà không thay thế. Gọi <span
class="math inline">\(A = \text{viên bi đầu tiên là đỏ}\)</span> , <span
class="math inline">\(B = \text{viên bi thứ hai là xanh}\)</span> . Tìm
<span class="math inline">\(P(A \cup B)\)</span> .</p></li>
<li><p>Tính Chất Logic Chứng minh, bằng bảng chân lý, rằng <span
class="math inline">\(\neg(p \land q)\)</span> là logic tương đương với
<span class="math inline">\(\neg p \lor \neg q\)</span> .</p></li>
</ol>
<h3 id="giải-pháp">5. Giải pháp</h3>
<ol type="1">
<li></li>
</ol>
<p><span class="math display">\[p\rightarrow q\equiv\lnot p\lor
q=\mathrm{F}\lor\mathrm{F}=\mathrm{F}\]</span></p>
<p><span class="math display">\[\neg r\equiv F\]</span></p>
<p><span class="math display">\[(p\rightarrow q)\land(\lnot
r)\equiv\mathrm{F}\land\mathrm{F}=\mathrm{F}\]</span></p>
<p><span class="math display">\[p\vee
q\equiv\mathrm{T}\lor\mathrm{F}=\mathrm{T}\]</span></p>
<p><span class="math display">\[\left(p\vee q\right)\leftrightarrow
r\equiv T\leftrightarrow T=T\]</span></p>
<p>Mệnh đề điều kiện sai <span
class="math inline">\(\Rightarrow\)</span> toàn bộ mệnh đề là Đúng.</p>
<p>Vì vậy mệnh đề hợp thành là Đúng.</p>
<ol start="2" type="1">
<li><ol type="a">
<li><span class="math inline">\(X \cup Y = \{a, b, c, d, e,
f\}\)</span></li>
</ol></li>
</ol>
<ol start="2" type="a">
<li><p><span class="math inline">\(Y \cap Z = \{f\}\)</span></p></li>
<li><p><span class="math inline">\(X \setminus Z = \{a, b, c,
d\}\)</span> (vì không có a, b, c, d nào trong Z)</p></li>
<li><p><span class="math inline">\(\overline{Y} = U \setminus Y = \{a,
b, g, h\}\)</span></p></li>
</ol>
<ol start="3" type="1">
<li>Sử dụng nguyên lý bao hàm - loại trừ:</li>
</ol>
<p><span class="math display">\[\left|\mathrm{M a t h}\cup\mathrm{P h y
s}\right|=18+12-5=25.\]</span></p>
<p>Vậy 25 học sinh thích ít nhất một môn học.</p>
<ol start="4" type="1">
<li>Tổng số viên bi = 6 + 4 + 5 = 15.</li>
</ol>
<p><span
class="math display">\[P(A)=\frac{6}{15}=\frac{2}{5}.\]</span></p>
<p>Sau khi rút viên bi đỏ đầu tiên, còn lại 14 viên bi, trong đó vẫn có
4 viên bi xanh.</p>
<p><span class="math display">\[P(B\mid
A)=\frac{4}{14}=\frac{2}{7}.\]</span></p>
<p>Vì vậy</p>
<p><span class="math display">\[P(A\cap B)=P(A)P(B\mid
A)=\frac{2}{5}\cdot\frac{2}{7}=\frac{4}{35}.\]</span></p>
<p>Đối với <span class="math inline">\(P(B)\)</span> ta xét cả hai
trường hợp (rút bi đỏ đầu tiên hoặc không phải bi đỏ):</p>
<p><span
class="math display">\[P(B)=\frac{6}{15}\cdot\frac{4}{14}+\frac{9}{15}\cdot\frac{4}{14}=\frac{24}{210}+\frac{36}{210}=\frac{60}{210}=\frac{2}{7}.\]</span></p>
<p>Cuối cùng,</p>
<p><span class="math display">\[P(A\cup B)=P(A)+P(B)-P(A\cap
B)=\frac{2}{5}+\frac{2}{7}-\frac{4}{35}=\frac{14}{35}+\frac{10}{35}-\frac{4}{35}=\frac{20}{35}=\frac{4}{7}.\]</span></p>
<ol start="5" type="1">
<li>Bảng chân trị:</li>
</ol>
<table border="1" style="margin: auto; word-wrap: break-word;">
<tr>
<td style="text-align: center; word-wrap: break-word;">
p
</td>
<td style="text-align: center; word-wrap: break-word;">
q
</td>
<td style="text-align: center; word-wrap: break-word;">
p q
</td>
<td style="text-align: center; word-wrap: break-word;">
(p q)
</td>
<td style="text-align: center; word-wrap: break-word;">
p q
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
T
</td>
<td style="text-align: center; word-wrap: break-word;">
T
</td>
<td style="text-align: center; word-wrap: break-word;">
T
</td>
<td style="text-align: center; word-wrap: break-word;">
F
</td>
<td style="text-align: center; word-wrap: break-word;">
F
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
T
</td>
<td style="text-align: center; word-wrap: break-word;">
F
</td>
<td style="text-align: center; word-wrap: break-word;">
F
</td>
<td style="text-align: center; word-wrap: break-word;">
T
</td>
<td style="text-align: center; word-wrap: break-word;">
T
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
F
</td>
<td style="text-align: center; word-wrap: break-word;">
T
</td>
<td style="text-align: center; word-wrap: break-word;">
F
</td>
<td style="text-align: center; word-wrap: break-word;">
T
</td>
<td style="text-align: center; word-wrap: break-word;">
T
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
F
</td>
<td style="text-align: center; word-wrap: break-word;">
F
</td>
<td style="text-align: center; word-wrap: break-word;">
F
</td>
<td style="text-align: center; word-wrap: break-word;">
T
</td>
<td style="text-align: center; word-wrap: break-word;">
T
</td>
</tr>
</table>
<p>Các cột cho <span class="math inline">\(\neg(p \land q)\)</span> và
<span class="math inline">\(\neg p \lor \neg q\)</span> là giống nhau,
xác lập sự tương đương.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Làm Tròn Số và Hiểu Sai Số (Lớp 10)', 'Cách làm tròn số, sai số tuyệt đối và sai số tương đối.', '', 'article', '10', '<h1 id="làm-tròn-số-và-hiểu-sai-số">Làm tròn Số và Hiểu Sai Số</h1>
<h2 id="tại-sao-lại-làm-tròn">Tại Sao Lại Làm Tròn?</h2>
<p>Trong đời sống thực tế, chúng ta thường gặp các phép đo không chính
xác, hoặc các số có vô số chữ số thập phân (như <span
class="math inline">\(\pi\)</span> hoặc <span
class="math inline">\(\sqrt{2}\)</span> ). Việc làm tròn giúp chúng ta
làm việc với các số gần đúng đủ cho một mục đích nhất định trong khi vẫn
giữ được tính toán dễ dàng.</p>
<h2 id="các-cách-làm-tròn">Các Cách Làm Tròn</h2>
<ol type="1">
<li>Làm tròn đến một giá trị xác định</li>
</ol>
<p>Ví dụ: Làm tròn 3.14159 đến chữ số thập phân thứ hai: 3.14.</p>
<h3 id="làm-tròn-đến-một-số-lượng-nhất-định-các-chữ-số-có-nghĩa">2. Làm
tròn đến một số lượng nhất định các chữ số có nghĩa</h3>
<p>Các chữ số có nghĩa đếm tất cả các chữ số không bằng không và bất kỳ
chữ số 0 nào nằm giữa chúng hoặc sau dấu thập phân nếu chúng theo sau
một chữ số không bằng không.</p>
<p>Ví dụ: 0.004560 có bốn chữ số có nghĩa. Làm tròn đến hai chữ số có
nghĩa cho 0.0046.</p>
<h3 id="sử-dụng-cắt-bỏ-cắt-ngắn">3. Sử dụng cắt bỏ (cắt ngắn)</h3>
<p>Chỉ cần loại bỏ các chữ số vượt quá vị trí mong muốn mà không làm
tròn. Ví dụ: Cắt ngắn 2.71828 sau ba chữ số thập phân: 2.718.</p>
<h2 id="khái-niệm-sai-số">Khái Niệm Sai Số</h2>
<p>Khi chúng ta thay thế một số chính xác x bằng một phép xấp xỉ <span
class="math inline">\(\tilde{x}\)</span> , chúng ta sẽ tạo ra một sai
số.</p>
<p>● Sai số tuyệt đối: <span class="math inline">\(E_a = |x -
\tilde{x}|\)</span> .</p>
<p>• Sai số tương đối: <span class="math inline">\(E_r = \frac{|x -
\tilde{x}|}{|x|}\)</span> (với điều kiện <span class="math inline">\(x
\neq 0\)</span> ).</p>
<p>• Sai số phần trăm: <span
class="math inline">\(E_{\%}=E_{r}\times100\%\)</span> .</p>
<p>Những điều này cho chúng ta biết khoảng cách sai lệch của phép xấp xỉ
so với giá trị thực.</p>
<h2 id="truyền-bức-sai-số-trong-các-tính-toán-đơn-giản">Truyền Bức Sai
Số Trong Các Tính Toán Đơn Giản</h2>
<p>Nếu chúng ta xấp xỉ từng đầu vào trước khi tính toán, sai số tổng có
thể được giới hạn bằng cách cộng các sai số tuyệt đối (cho phép cộng)
hoặc sử dụng các sai số tương đối (cho phép nhân). Với một cách xử lý
cấp lớp 10, chúng ta sử dụng các quy tắc đơn giản:</p>
<p><span
class="math display">\[\mathrm{Đối}z=x+y:\quad|E_{z}|\leq|E_{x}|+|E_{y}|.\]</span></p>
<p><span class="math display">\[\mathrm{Đối}z=x\cdot
y:\quad\frac{\left|E_{z}\right|}{\left|z\right|}\approx\frac{\left|E_{x}\right|}{\left|x\right|}+\frac{\left|E_{y}\right|}{\left|y\right|}.\]</span></p>
<p>Đây là những xấp xỉ bậc nhất; chúng hoạt động tốt khi các lỗi riêng
lẻ là nhỏ.</p>
<h2 id="ví-dụ">Ví dụ</h2>
<h3 id="làm-tròn-và-lỗi">1. Làm tròn và lỗi</h3>
<p>Chiều dài thực của một thanh là 12.378 cm. Chúng ta đo nó bằng thước
kẻ được đánh dấu theo milimet và ghi lại 12.4 cm.</p>
<p><span class="math display">\[\tilde{x}=12.4cm\]</span></p>
<p><span
class="math display">\[E_{a}=\left|12.378-12.4\right|=0.022cm\]</span></p>
<p><span
class="math display">\[E_{r}=\frac{0.022}{12.378}\approx0.00178\]</span></p>
<p><span class="math display">\[E_{\%}\approx0.178\%\]</span></p>
<h3 id="số-chữ-số-có-nghĩa-trong-một-tích">2. Số chữ số có nghĩa trong
một tích</h3>
<p>Tính diện tích của một hình chữ nhật có các cạnh là 5.2 m (2 chữ số
có nghĩa) và 3.14 m (3 chữ số có nghĩa). Tích thô là <span
class="math inline">\(5.2 \times 3.14 = 16.328 \, m^2\)</span> . Yếu tố
ít chính xác nhất có 2 chữ số có nghĩa, vì vậy chúng ta làm tròn kết quả
đến 2 chữ số có nghĩa: <span class="math inline">\(1.6 \times 10^1 \,
m^2\)</span> (tức là <span class="math inline">\(16 \, m^2\)</span> ).
Lỗi tuyệt đối do làm tròn là tối đa nửa của chữ số được giữ lại: <span
class="math inline">\(0.5 \, m^2\)</span> . Lỗi tương đối <span
class="math inline">\(\approx 0.5/16 \approx 0.031\)</span> hoặc
3.1%.</p>
<h2 id="bài-tập-thực-hành">Bài tập thực hành</h2>
<ol type="1">
<li><p>Một sinh viên đo khối lượng của một mẫu là 23.45 g bằng một cân
đọc được đến gần nhất 0.01 g. Khối lượng thực là 23.48 g. Tìm lỗi tuyệt
đối, lỗi tương đối, và phần trăm lỗi.</p></li>
<li><p>Chu vi của một hình tròn được đo là 31.4 cm (làm tròn đến gần
nhất phần mười). Sử dụng <span class="math inline">\(\pi \approx
3.14\)</span> , ước lượng bán kính và cho kết quả với số chữ số có nghĩa
phù hợp. Tính lỗi tuyệt đối trong bán kính nếu bán kính thực là 5.00
cm.</p></li>
<li><p>Xấp xỉ <span class="math inline">\(\sqrt{2}\)</span> đến ba chữ
số thập phân. Sử dụng xấp xỉ này, tính đường chéo của một hình vuông có
độ dài cạnh là 7.0 cm. Ghi lại đường chéo với số chữ số có nghĩa đúng và
cho phần trăm lỗi so với đường chéo chính xác <span
class="math inline">\(7\sqrt{2}\)</span> cm.</p></li>
</ol>
<h2 id="giải-pháp">Giải pháp</h2>
<ol type="1">
<li>Giá trị thực <span class="math inline">\(x = 23.48 \, g\)</span> ,
xấp xỉ <span class="math inline">\(\tilde{x} = 23.45 \, g\)</span>
.</li>
</ol>
<p><span class="math display">\[E_{a}=\left|23.48-23.45\right|=0.03\
g,\qquad E_{r}=\frac{0.03}{23.48}\approx0.00128,\qquad
E_{\%}\approx0.128\%.\]</span></p>
<ol start="2" type="1">
<li>Đo chu vi <span class="math inline">\(C = 31.4 \, \text{cm}\)</span>
(chỉ ra rằng <span class="math inline">\(C\)</span> được biết đến với độ
chính xác <span class="math inline">\(\pm 0.05 \, \text{cm}\)</span> ).
Công thức bán kính: <span class="math inline">\(r =
\frac{C}{2\pi}\)</span> . Sử dụng <span class="math inline">\(\pi
\approx 3.14\)</span> :</li>
</ol>
<p><span
class="math display">\[r\approx\frac{31.4}{2\times3.14}=\frac{31.4}{6.28}=5.00cm.\]</span></p>
<p>Phép chia này liên quan đến ba chữ số có nghĩa (31.4 có ba, 6.28 có
ba), vì vậy chúng ta giữ ba chữ số có nghĩa: 5.00 cm. Bán kính thực
<span class="math inline">\(r_{\text{true}} = 5.00 \, \text{cm}\)</span>
(được cho). Sai số tuyệt đối trong bán kính: <span
class="math inline">\(|5.00 - 5.00| = 0.00 \, \text{cm}\)</span> (ước
lượng này trùng khớp với độ chính xác được hiển thị). Nếu thay vào đó
chúng ta sử dụng <span class="math inline">\(\pi\)</span> chính xác:
<span class="math inline">\(r_{\text{exact}} = 31.4 / (2\pi) \approx
5.00 \, \text{cm}\)</span> cũng như vậy, vì vậy sai số vẫn có thể bỏ qua
được ( <span class="math inline">\(|0.01\%|\)</span> ).</p>
<ol start="3" type="1">
<li><span class="math inline">\(\sqrt{2} \approx 1.414\)</span> (ba chữ
số thập phân). Độ dài đường chéo <span class="math inline">\(d =
s\sqrt{2}\)</span> với <span class="math inline">\(s = 7.0\)</span> cm
(hai chữ số có nghĩa). Sử dụng phép xấp xỉ:</li>
</ol>
<p><span
class="math display">\[d_{approx}=7.0\times1.414=9.898cm.\]</span></p>
<p>Yếu tố có số chữ số có nghĩa ít nhất là 7.0 (hai chữ số có nghĩa), vì
vậy chúng ta làm tròn tích thành hai chữ số có nghĩa: 9.9 cm. Độ dài
đường chéo chính xác: <span class="math inline">\(d_{\text{exact}} =
7\sqrt{2} \approx 9.8995 \, \text{cm}\)</span> . Sai số tuyệt đối: <span
class="math inline">\(|9.8995 - 9.898| = 0.0015 \, \text{cm}\)</span> .
Sai số phần trăm: <span class="math inline">\(\frac{0.0015}{9.8995}
\times 100\% \approx 0.015\%\)</span> .</p>
<h2 id="tóm-tắt">Tóm tắt</h2>
<p>● Xấp xỉ làm đơn giản hóa các con số nhưng gây ra sai số.</p>
<p>● Sai số tuyệt đối, sai số tương đối và sai số phần trăm lượng hóa sự
khác biệt.</p>
<p>● Khi làm tròn, hãy theo dõi các chữ số có nghĩa để tránh tuyên bố độ
chính xác quá mức.</p>
<p>● Đối với tổng, cộng các sai số tuyệt đối; đối với tích, cộng các sai
số tương đối (ước lượng bậc nhất).</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Số Đặc Trưng Đo Lường Xu Hướng Tập Trung (Lớp 10)', 'Số trung bình, trung vị, mốt và các số đặc trưng đo xu hướng trung tâm.', '', 'article', '10', '<h1 id="số-đặc-trưng-đo-lường-xu-hướng-tập-trung">Số Đặc Trưng Đo Lường
Xu Hướng Tập Trung</h1>
<h2 id="giới-thiệu">Giới Thiệu</h2>
<p>Trong thống kê, một số đặc trưng (hoặc đo lường xu hướng tập trung)
là một giá trị duy nhất cố gắng mô tả tâm của một bộ dữ liệu. Với học
sinh trung học phổ thông, các số đo phổ biến nhất là trung bình cộng,
trung vị, và mốt. Các số đo hữu ích khác bao gồm trung bình có trọng số,
trung bình nhân, và trung bình hài. Mỗi loại có những ưu điểm, nhược
điểm riêng và tình huống phù hợp.</p>
<h2 id="định-nghĩa">Định Nghĩa</h2>
<p>• Trung Bình Cộng <span class="math inline">\((\bar{x})\)</span>
:</p>
<p><span
class="math display">\[\bar{x}=\frac{1}{n}\sum_{i=1}^{n}x_{i}\]</span></p>
<p>trong đó <span class="math inline">\(x_{1},\ldots,x_{n}\)</span> là
các quan sát và n là kích thước mẫu.</p>
<p>• Trung Vị (M): Giá trị giữa sau khi sắp xếp dữ liệu từ nhỏ nhất đến
lớn nhất. Nếu n là số lẻ, <span class="math inline">\(M =
x_{\left(\frac{n+1}{2}\right)}\)</span> ; nếu n là số chẵn,</p>
<p><span
class="math display">\[M=\frac{x_{(\frac{n}{2})}+x_{(\frac{n}{2}+1)}}{2}.\]</span></p>
<ul>
<li>Mốt: Giá trị xuất hiện thường xuyên nhất. Một bộ dữ liệu có thể
không có mốt, một mốt (đơn thức), hoặc nhiều mốt (đa thức).</li>
</ul>
<p>• Trung Bình Có Trọng Số <span
class="math inline">\((\bar{x}_{w})\)</span> : Khi các quan sát <span
class="math inline">\(x_{i}\)</span> mang trọng số <span
class="math inline">\(w_{i} &gt; 0\)</span> ,</p>
<p><span
class="math display">\[\bar{x}_{w}=\frac{\sum_{i=1}^{n}w_{i}x_{i}}{\sum_{i=1}^{n}w_{i}}.\]</span></p>
<p>• Trung Bình Nhân <span class="math inline">\((G)\)</span> : Với dữ
liệu dương,</p>
<p><span
class="math display">\[G=\Big(\prod_{i=1}^{n}x_{i}\Big)^{1/n}=\exp\Big(\frac{1}{n}\sum_{i=1}^{n}\ln
x_{i}\Big).\]</span></p>
<p>• Trung Bình Hài <span class="math inline">\((H)\)</span> : Với dữ
liệu dương,</p>
<p><span
class="math display">\[H=\frac{n}{\sum_{i=1}^{n}\frac{1}{x_{i}}}.\]</span></p>
<h2 id="tính-chất-và-giải-thích">Tính Chất Và Giải Thích</h2>
<p>[label=0.]Trung bình cộng nhạy cảm với các giá trị ngoại lai; một giá
trị cực đoan có thể dịch chuyển nó đáng kể. Trung vị bền vững trước các
giá trị ngoại lai; nó chỉ phụ thuộc vào thứ tự của dữ liệu. Mốt hữu ích
cho dữ liệu phân loại hoặc rời rạc nơi chúng ta muốn tìm danh mục phổ
biến nhất. Với dữ liệu lệch phải (đuôi dài bên phải), thường</p>
<p><span class="math display">\[Mode&lt;Median&lt;\bar{x}.\]</span></p>
<p>Với dữ liệu lệch trái, bất đẳng thức sẽ đảo ngược. Trung bình có
trọng số giảm xuống thành trung bình thông thường khi tất cả <span
class="math inline">\(w_i = 1\)</span> . Trung bình nhân thích hợp cho
dữ liệu tăng theo nhân (ví dụ, tốc độ tăng trưởng, chỉ số). Trung bình
hài hữu ích khi trung bình các tốc độ (ví dụ, vận tốc, mật độ).</p>
<h2 id="chọn-một-đo-lượng">Chọn Một Đo Lượng</h2>
<p>Sử dụng trung bình khi dữ liệu gần như đối xứng và không có các giá
trị ngoại lệ cực đoan.</p>
<p>• Sử dụng trung vị khi dữ liệu bị lệch hoặc chứa các giá trị ngoại
lệ.</p>
<ul>
<li>Sử dụng chế độ để xử lý dữ liệu định danh hoặc để xác định danh mục
thường xuyên nhất, hoặc để xác định giá trị thường xuyên nhất.</li>
</ul>
<p>• Sử dụng trung bình có trọng số khi các quan sát có tầm quan trọng
hoặc độ tin cậy khác nhau.</p>
<p>• Sử dụng trung bình nhân để xử lý phần trăm, các yếu tố tăng trưởng,
hoặc tỷ lệ.</p>
<p>• Sử dụng trung bình hài hòa để tính trung bình tốc độ, tỷ lệ, hoặc
mật độ.</p>
<h2 id="ví-dụ-minh-họa">Ví dụ Minh Họa</h2>
<h2 id="ví-dụ-1-trung-bình-trung-vị-chế-độ">Ví dụ 1: Trung Bình, Trung
Vị, Chế Độ</h2>
<p>Một giáo viên đã ghi lại điểm số (trên 20) của 9 học sinh trong một
bài kiểm tra:</p>
<p>12, 15, 14, 13, 15, 16, 12, 15, 18.</p>
<p>• Trung bình:</p>
<p><span
class="math display">\[\bar{x}=\frac{12+15+14+13+15+16+12+15+18}{9}=\frac{130}{9}\approx14.44.\]</span></p>
<p>• Trung vị: Sắp xếp dữ liệu: 12, 12, 13, 14, 15, 15, 16, 18. Giá trị
thứ 5 (giữa) là 15, nên M = 15.</p>
<p>• Chế độ: Giá trị 15 xuất hiện ba lần, nhiều hơn bất kỳ giá trị nào
khác; do đó chế độ = 15.</p>
<p>Chú ý rằng trung bình hơi thấp hơn trung vị do có hai điểm số thấp
(12).</p>
<h2 id="ví-dụ-2-trung-bình-có-trọng-số">Ví dụ 2: Trung Bình Có Trọng
Số</h2>
<p>Giả sử một điểm số cuối cùng gồm có bài tập về nhà (trọng số 0.3),
bài kiểm tra giữa kỳ (trọng số 0.2), và bài thi cuối kỳ (trọng số 0.5).
Một sinh viên đạt được:</p>
<p><span class="math display">\[\mathrm{Homework}=85,\]</span></p>
<p><span class="math display">\[\mathrm{Midterm}=78,\]</span></p>
<p><span class="math display">\[Final exam=92.\]</span></p>
<p>Trung bình có trọng số là</p>
<p><span
class="math display">\[\bar{x}_{w}=\frac{0.3\cdot85+0.2\cdot78+0.5\cdot92}{0.3+0.2+0.5}=\frac{25.5+15.6+46}{1}=87.1.\]</span></p>
<h2 id="ví-dụ-3-trung-bình-nhân">Ví dụ 3: Trung Bình Nhân</h2>
<p>Một khoản đầu tư tăng trưởng 5%, <span
class="math inline">\(-2\%\)</span> , và 10% trong ba năm liên tiếp. Các
yếu tố tăng trưởng là 1.05, 0.98, và 1.10. Trung bình nhân của các yếu
tố là</p>
<p><span
class="math display">\[G=(1.05\times0.98\times1.10)^{1/3}\approx(1.1319)^{1/3}\approx1.042.\]</span></p>
<p>Do đó tỷ lệ tăng trưởng hàng năm trung bình khoảng 4.2%.</p>
<h2 id="ví-dụ-4-trung-bình-hài-hòa">Ví dụ 4: Trung Bình Hài Hòa</h2>
<p>Một chiếc xe đi 60 km với tốc độ 40 km/h, sau đó đi thêm 60 km với
tốc độ 60 km/h. Tốc độ trung bình cho cả chuyến đi là trung bình hài hòa
của hai tốc độ (vì các quãng đường bằng nhau):</p>
<p><span
class="math display">\[H=\frac{2}{\frac{1}{40}+\frac{1}{60}}=\frac{2}{\frac{3+2}{120}}=\frac{2}{\frac{5}{120}}=\frac{2\cdot120}{5}=48km/h.\]</span></p>
<h2 id="bài-tập-luyện-tập">Bài Tập Luyện Tập</h2>
<ol type="1">
<li>Tìm trung bình, trung vị, và chế độ cho tập dữ liệu:</li>
</ol>
<p>5, 8, 8, 10, 12, 12, 12, 15, 20.</p>
<ol start="2" type="1">
<li><p>Điểm của một học sinh trên bốn bài kiểm tra là 78, 85, 90, và 92.
Nếu hai bài kiểm tra đầu tiên mỗi bài chiếm 25% điểm số cuối cùng và hai
bài kiểm tra cuối cùng mỗi bài cũng chiếm 25% (tức là trọng số bằng
nhau), thì trung bình có trọng số là bao nhiêu? Nếu bài kiểm tra đầu
tiên chiếm 20%, bài kiểm tra thứ hai 30%, bài kiểm tra thứ ba 20%, và
bài kiểm tra thứ tư 30%, thì trung bình có trọng số sẽ là bao
nhiêu?</p></li>
<li><p>Giá cổ phiếu thay đổi theo +12%, -8%, +15%, và -5% trong bốn
tháng. Tính trung bình nhân của các yếu tố tăng trưởng hàng tháng và
diễn giải kết quả như một tỷ lệ phần trăm thay đổi trung bình hàng
tháng.</p></li>
<li><p>Một tay đua đi xe đạp 30 km với tốc độ 20 km/h, sau đó 30 km với
tốc độ 30 km/h, và cuối cùng 30 km với tốc độ 10 km/h. Trung bình hài
hòa của ba tốc độ là bao nhiêu? Tốc độ trung bình thực tế cho hành trình
90 km là bao nhiêu? (Gợi ý: sử dụng tổng quãng đường chia cho tổng thời
gian.)</p></li>
</ol>
<h2 id="giải-pháp">Giải Pháp</h2>
<p><span class="math display">\[1.\quad\bullet\ Trung bình:\
\bar{x}=\frac{5+8+8+10+12+12+12+15+20}{9}=\frac{102}{9}\approx11.33.\]</span></p>
<p>• Trung vị: Dữ liệu đã sắp xếp là 5, 8, 8, 10, 12, 12, 15, 20; giá
trị thứ 5 là 12, do đó M = 12.</p>
<p>• Chế độ: Giá trị 12 xuất hiện ba lần, nhiều hơn bất kỳ giá trị nào
khác; chế độ = 12.</p>
<ol start="2" type="1">
<li><span class="math inline">\(\bullet\)</span> Trọng số bằng nhau
(0.25 mỗi):</li>
</ol>
<p><span
class="math display">\[\bar{x}_{w}=0.25\cdot78+0.25\cdot85+0.25\cdot90+0.25\cdot92=19.5+21.25+22.5+23=86.25.\]</span></p>
<p>• Trọng số không bằng nhau (0.20, 0.30, 0.20, 0.30):</p>
<p><span
class="math display">\[\bar{x}_{w}=0.20\cdot78+0.30\cdot85+0.20\cdot90+0.30\cdot92=15.6+25.5+18+27.6=86.7.\]</span></p>
<ol start="3" type="1">
<li>Các yếu tố tăng trưởng: 1.12, 0.92, 1.15, 0.95.</li>
</ol>
<p><span
class="math display">\[G=(1.12\times0.92\times1.15\times0.95)^{1/4}\approx(1.124)^{1/4}\approx1.0298.\]</span></p>
<p>Trung bình nhân của các yếu tố tăng trưởng hàng tháng là khoảng
1.0298, tức là một tỷ lệ tăng trung bình hàng tháng khoảng 2.98%.</p>
<ol start="4" type="1">
<li>Trung bình hài hòa của 20, 30, 10 km/h:</li>
</ol>
<p><span
class="math display">\[H=\frac{3}{\frac{1}{20}+\frac{1}{30}+\frac{1}{10}}=\frac{3}{\frac{3+2+6}{60}}=\frac{3}{\frac{11}{60}}=\frac{180}{11}\approx16.36km/h.\]</span></p>
<p>Tốc độ trung bình thực tế: tổng quãng đường = 90 km. Thời gian: <span
class="math inline">\(t_{1} = \frac{30}{20} = 1.5\)</span> h, <span
class="math inline">\(t_{2} = \frac{30}{30} = 1\)</span> h, <span
class="math inline">\(t_{3} = \frac{30}{10} = 3\)</span> h. Tổng thời
gian = <span class="math inline">\(1.5 + 1 + 3 = 5.5\)</span> h. Tốc độ
trung bình = <span class="math inline">\(\frac{90}{5.5} \approx
16.36\)</span> km/h, điều này phù hợp với trung bình hài hòa vì quãng
đường cho từng đoạn là bằng nhau.</p>
<h2 id="tóm-tắt">Tóm Tắt</h2>
<p>Các đo lường xu hướng trung tâm cung cấp một mô tả ngắn gọn về vị trí
giữa của một tập dữ liệu. Trung bình cộng là quen thuộc nhất nhưng có
thể bị ảnh hưởng bởi các giá trị cực đoan; trung vị chống lại sự ảnh
hưởng này; chế độ nhấn mạnh quan sát thường xuyên nhất. Trung bình có
trọng số, trung bình nhân, và trung bình hài hòa mở rộng ý tưởng này đến
các tình huống mà các quan sát có tầm quan trọng khác nhau, tăng theo
cách nhân, hoặc đại diện cho tỷ lệ. Việc chọn đo lường phù hợp phụ thuộc
vào phân phối dữ liệu, sự hiện diện của các giá trị ngoại lai, và bối
cảnh của bài toán.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Quy Tắc Đếm, Chỉnh Hợp và Tổ Hợp (Lớp 10)', 'Quy tắc cộng, quy tắc nhân, chỉnh hợp và tổ hợp.', '', 'article', '10', '<h1 id="quy-tắc-đếm-lớp-10">Quy tắc đếm lớp 10</h1>
<h2 id="nguyên-tắc-đếm-cơ-bản">Nguyên tắc đếm cơ bản</h2>
<p>Nếu một công việc có thể được thực hiện theo m cách và, với mỗi cách
thực hiện công việc đầu tiên, một công việc thứ hai có thể được thực
hiện theo n cách, thì hai công việc cùng thực hiện được theo <span
class="math inline">\(m \cdot n\)</span> cách. Nguyên tắc này mở rộng
cho bất kỳ số lượng công việc nào hữu hạn:</p>
<p><span class="math display">\[Số cách =n_{1}\times
n_{2}\times\cdots\times n_{k}.\]</span></p>
<p>Ví dụ 1. Trong một bài toán chuồng gà, có hai lựa chọn độc lập: chọn
một con gà từ chuồng I và chọn một con gà từ chuồng II. Chuồng I có 5
con gà trống và 10 con gà mái → 15 khả năng. Chuồng II có 3 con gà mái
và 7 con gà trống → 10 khả năng. Do đó tổng số cặp có thứ tự (gà từ I,
gà từ II) là <span class="math inline">\(15 \times 10 = 150\)</span>
.</p>
<h2 id="chỉnh-hợp">Chỉnh hợp</h2>
<p>Một chỉnh hợp là sự sắp xếp các đối tượng theo một thứ tự cụ thể. Số
cách chỉnh hợp của n đối tượng phân biệt lấy r đối tượng là</p>
<p><span
class="math display">\[P(n,r)=\frac{n!}{(n-r)!}=n\left(n-1\right)\cdots(n-r+1).\]</span></p>
<p>Ví dụ 2: <span class="math inline">\(\Omega = 10!\)</span> Số cách
sắp xếp thuận lợi (nữ ở chỗ 1,4,7,10) = 6! · 4!. Ở đây ta trước tiên
chọn 4 trong số 10 chỗ để nữ ngồi (chỗ cố định 1,4,7,10) và sau đó sắp
xếp 4 nữ vào những chỗ đó (4! cách) và 6 nam vào những chỗ còn lại (6!
cách). Do đó số cách sắp xếp thuận lợi là <span class="math inline">\(6!
\times 4!\)</span> .</p>
<h2 id="kết-hợp">Kết hợp</h2>
<p>Một kết hợp là sự chọn các đối tượng mà thứ tự không quan trọng. Số
cách chọn r đối tượng từ n đối tượng phân biệt là</p>
<p><span
class="math display">\[\binom{n}{r}=\frac{n!}{r!\left(n-r\right)!}.\]</span></p>
<p>Ví dụ 3 (lấy bóng): Lấy 4 bóng từ 7 bóng đen +5 bóng trắng: <span
class="math inline">\(|\Omega| = C(12, 4) = 495\)</span> . Tổng số cách
chọn không thứ tự 4 bóng từ 12 là <span
class="math inline">\(\binom{12}{4} = 495\)</span> .</p>
<h2 id="nguyên-lý-cộng">Nguyên lý Cộng</h2>
<p>Nếu hai sự kiện A và B là loại trừ lẫn nhau (không thể xảy ra cùng
lúc), thì</p>
<p><span class="math display">\[|A\cup B|=|A|+|B|.\]</span></p>
<p>Nếu chúng không phải là loại trừ lẫn nhau chúng ta sử dụng Nguyên lý
Bao hàm - Loại trừ.</p>
<h2 id="nguyên-lý-bao-hàm---loại-trừ">Nguyên lý Bao hàm - Loại trừ</h2>
<p>Với hai sự kiện:</p>
<p><span class="math display">\[|A\cup B|=|A|+|B|-|A\cap
B|.\]</span></p>
<p>Với ba sự kiện:</p>
<p><span class="math display">\[|A\cup B\cup C|=|A|+|B|+|C|-|A\cap
B|-|A\cap C|-|B\cap C|+|A\cap B\cap C|.\]</span></p>
<p>Ví dụ 4. Lớp học có 40 học sinh (4 nhóm, mỗi nhóm 4 nam, 6 nữ): P(nam
hoặc thuộc nhóm 4) = <span class="math inline">\((16+10-4)/40 = 22/40 =
11/20\)</span> . Cho B = học sinh là nam, <span
class="math inline">\(G_4\)</span> = học sinh thuộc nhóm 4. <span
class="math inline">\(|B| = 16\)</span> (4 nhóm <span
class="math inline">\(\times\)</span> 4 nam), <span
class="math inline">\(|G_4| = 10\)</span> (6 nữ + 4 nam trong nhóm 4),
<span class="math inline">\(|B \cap G_4| = 4\)</span> (các nam trong
nhóm 4). Do đó <span class="math inline">\(|B \cup G_4| = 16 + 10 - 4 =
22\)</span> , cho xác suất 22/40 = 11/20.</p>
<h2 id="quy-tắc-bổ-sung">Quy tắc Bổ sung</h2>
<p>Với bất kỳ sự kiện nào A,</p>
<p><span class="math display">\[P(A^{\prime})=1-P(A).\]</span></p>
<p>Điều này được sử dụng thường xuyên khi dễ dàng hơn là đếm kết quả
ngược lại.</p>
<p>Ví dụ 5: <span class="math inline">\(P(A&#39;) = 1 - P(A)\)</span> .
Nếu <span class="math inline">\(P(A) = 1/3\)</span> thì <span
class="math inline">\(P(A&#39;) = 2/3\)</span> .</p>
<h2 id="bài-tập-thực-hành">Bài tập Thực hành</h2>
<ol type="1">
<li>Hoán vị với điều kiện. Mười học sinh sẽ được xếp thành một hàng. Hai
học sinh đặc biệt, Huyn và Quang, phải ngồi cạnh nhau. Có bao nhiêu cách
sắp xếp thỏa mãn điều kiện này?</li>
</ol>
<p>Giải. Xem Huyn và Quang như một khối. Khối này có thể được sắp xếp
trong 2! cách (HuynQuang hoặc QuangHuyn). Bây giờ chúng ta có 9 đối
tượng để sắp xếp (khối + 8 học sinh còn lại): 9! cách. Tổng cộng = 2! ×
9! = 2 × 362880 = 725760.</p>
<ol start="2" type="1">
<li>Kết hợp chọn gà. Từ chuồng I (5 gà trống, 10 gà mái) chọn 2 con gà;
từ chuồng II (3 gà mái, 7 gà trống) chọn 1 con gà. Hỏi có bao nhiêu cách
chọn (thứ tự trong mỗi chuồng không quan trọng)?</li>
</ol>
<p>Giải. Chuồng I: <span class="math inline">\(\binom{15}{2} =
105\)</span> cách. Chuồng II: <span class="math inline">\(\binom{10}{1}
= 10\)</span> cách. Theo nguyên tắc nhân, tổng cộng = 105 × 10 = 1050
cách chọn.</p>
<ol start="3" type="1">
<li>Nguyên lý bao hàm loại trừ rút bài. Ba bài được rút không hoàn lại
từ một bộ bài chuẩn 52 bài. Tìm xác suất để không có bài nào là rô.</li>
</ol>
<p>Giải. Có 13 bài rô, do đó 39 bài không phải rô. Số cách chọn 3 bài
không phải rô: <span class="math inline">\(\binom{39}{3} = 9139\)</span>
. Tổng số cách chọn bất kỳ 3 bài nào: <span
class="math inline">\(\binom{52}{3} = 22100\)</span> . Như vậy <span
class="math inline">\(P(\text{không rô}) = \frac{9139}{22100} \approx
0.4135\)</span> .</p>
<ol start="4" type="1">
<li>Bổ sung xúc xắc sản phẩm. Hai xúc xắc công bằng được gieo. Xác suất
để tích của hai số là số lẻ là bao nhiêu?</li>
</ol>
<p>Giải. Tích chỉ là số lẻ khi cả hai xúc xắc đều hiển thị số lẻ. Mỗi
xúc xắc có 3 mặt lẻ, do đó <span class="math inline">\(P(\text{số lẻ
trên một xúc xắc}) = 3/6 = 1/2\)</span> . Theo tính độc lập, <span
class="math inline">\(P(\text{cả hai lẻ}) = (1/2) \times (1/2) =
1/4\)</span> . Như vậy <span class="math inline">\(P(\text{tích lẻ}) =
1/4\)</span> . (Sử dụng bổ sung: <span
class="math inline">\(P(\text{tích chẵn}) = 1 - 1/4 = 3/4\)</span>
.)</p>
<ol start="5" type="1">
<li>Đếm với nhóm. Một lớp có 40 học sinh chia thành 4 nhóm mỗi nhóm 10
người, mỗi nhóm chứa 4 nam và 6 nữ. Tìm xác suất để một học sinh được
chọn ngẫu nhiên là nam hoặc thuộc nhóm 4.</li>
</ol>
<p>Giải. Số học sinh nam: <span class="math inline">\(4 \times 4 =
16\)</span> . Số học sinh trong nhóm 4: 10. Giao (nam trong nhóm 4): 4.
Như vậy <span class="math inline">\(|B \cup G_4| = 16 + 10 - 4 =
22\)</span> . Xác suất = 22/40 = 11/20.</p>
<h2 id="tóm-tắt-các-công-thức-chính">Tóm tắt Các Công Thức Chính</h2>
<p>● Nguyên tắc nhân: <span class="math inline">\(n_{1}n_{2}\ldots
n_{k}\)</span> .</p>
<p>● Hoán vị: <span class="math inline">\(P(n, r) = \frac{n!}{(n -
r)!}\)</span> .</p>
<p>● Tổ hợp: <span class="math inline">\(\binom{n}{r} =
\frac{n!}{r!(n-r)!}\)</span> .</p>
<p>● Cộng (không giao nhau): <span class="math inline">\(|A \cup B| =
|A| + |B|\)</span> .</p>
<p>● Nguyên lý bao hàm - loại trừ (hai sự kiện): <span
class="math inline">\(|A \cup B| = |A| + |B| - |A \cap B|\)</span> .</p>
<p>● Bù: <span class="math inline">\(P(A&#39;) = 1 - P(A)\)</span> .</p>
<p>Giáo viên</p>
<h2 id="giới-thiệu">1 Giới thiệu</h2>
<p>Đếm số cách sắp xếp hoặc chọn các vật thể là kỹ năng cơ bản trong
toán học. Ba ý tưởng liên quan chặt chẽ xuất hiện lặp lại:</p>
<p>• Chỉnh hợp: thứ tự quan trọng, tất cả các vật thể đều khác nhau.</p>
<p>• Tổ hợp: thứ tự không quan trọng, chúng tôi chỉ quan tâm đến các vật
thể được chọn.</p>
<p>• Sắp xếp có lặp: chúng ta có các vật thể giống nhau lặp lại; chúng
tôi chia cho giai thừa của từng số lần lặp.</p>
<p>Các phần dưới đây phát triển các khái niệm này từ các nguyên tắc đếm
cơ bản, đưa ra nhiều ví dụ được giải chi tiết, và cung cấp các bài toán
thực hành với lời giải đầy đủ.</p>
<h2 id="nguyên-tắc-đếm-cơ-bản-1">2 Nguyên tắc Đếm Cơ Bản</h2>
<p>Trước khi đi vào chỉnh hợp và tổ hợp, chúng ta nhớ lại hai quy tắc mà
tất cả các lập luận đếm đều dựa vào.</p>
<p>Quy tắc Tổng Nếu một nhiệm vụ có thể được hoàn thành bằng cách chọn
một trong hai cách loại trừ lẫn nhau, với N cách cho cách đầu tiên và M
cách cho cách thứ hai, thì tổng số cách là <span class="math inline">\(N
+ M\)</span> cách.</p>
<p>Quy tắc Nhân Nếu một công việc bao gồm <span
class="math inline">\(m\)</span> giai đoạn liên tiếp, và giai đoạn thứ
<span class="math inline">\(i\)</span> có thể được thực hiện trong <span
class="math inline">\(N_{i}\)</span> cách độc lập, thì tổng số cách thực
hiện là <span class="math inline">\(N_{1} \times N_{2} \times \cdots
\times N_{m}\)</span> .</p>
<p>Những quy tắc này chứng minh các công thức mà chúng ta sẽ đi vào
sau.</p>
<h2 id="chỉnh-hợp-của-các-đối-tượng-phân-biệt">3 Chỉnh hợp của Các Đối
tượng Phân biệt</h2>
<p>Một chỉnh hợp của n đối tượng phân biệt là một cách sắp xếp tất cả n
đối tượng. Theo Quy tắc Nhân, chúng ta có thể chọn đối tượng đầu tiên
trong n cách, đối tượng thứ hai trong n - 1 cách, và cứ như vậy, cho
ta</p>
<p><span
class="math display">\[P_{n}=n\cdot(n-1)\cdot\cdots\cdot2\cdot1=n!.\]</span></p>
<p>Ví dụ 1. Với <span class="math inline">\(3! = 3 \cdot 2 \cdot 1 =
6\)</span> cách sắp xếp của ba sinh viên phân biệt.</p>
<p>Ví dụ 2. Với 10 sinh viên phân biệt,</p>
<p><span
class="math display">\[10!=10\cdot9\cdot8\cdot7\cdot6\cdot5\cdot4\cdot3\cdot2\cdot1=3628800\]</span></p>
<p>các cách sắp xếp khác nhau.</p>
<h3 id="chỉnh-hợp-một-phần-k-chỉnh-hợp">3.1 Chỉnh hợp Một Phần (k-Chỉnh
hợp)</h3>
<p>Đôi khi chúng ta chỉ muốn sắp xếp k trong số n đối tượng phân biệt (
<span class="math inline">\(0 \leq k \leq n\)</span> ). Số lượng các
cách sắp xếp như vậy được ký hiệu là <span class="math inline">\(P(n,
k)\)</span> hoặc <span class="math inline">\(_{n}P_{k}\)</span> và
bằng</p>
<p><span
class="math display">\[P(n,k)=\frac{n!}{(n-k)!}=n\cdot(n-1)\cdots(n-k+1).\]</span></p>
<p>Ví dụ 3. Có bao nhiêu từ 4 chữ cái có thể được tạo thành bằng cách sử
dụng các chữ cái phân biệt từ bảng chữ cái Anh? Ở đây n = 26, k = 4:</p>
<p><span
class="math display">\[P(26,4)=\frac{26!}{22!}=26\cdot25\cdot24\cdot23=358800.\]</span></p>
<h2 id="kết-hợp-1">4 Kết hợp</h2>
<p>Khi thứ tự của các đối tượng được chọn không quan trọng, ta sử dụng
kết hợp. Số cách chọn k đối tượng từ n đối tượng khác nhau là hệ số nhị
thức</p>
<p><span
class="math display">\[\binom{n}{k}=C(n,k)=\frac{n!}{k!(n-k)!}.\]</span></p>
<p>Ví dụ 4. Chọn một ban chấp hành gồm 3 sinh viên từ một lớp có 10 sinh
viên:</p>
<p><span class="math display">\[\begin{pmatrix}10\\
3\end{pmatrix}=\frac{10!}{3!7!}=\frac{10\cdot9\cdot8}{3\cdot2\cdot1}=120.\]</span></p>
<p>Ví dụ 5. Số lượng đường đi lưới đơn điệu từ <span
class="math inline">\((0,0)\)</span> đến <span
class="math inline">\((3,4)\)</span> sử dụng chỉ các bước Bắc <span
class="math inline">\((N)\)</span> và Đông <span
class="math inline">\((E)\)</span> là <span
class="math inline">\(\binom{7}{3} = \binom{7}{4} = 35\)</span> , vì ta
phải chọn 3 trong 7 bước là bước Bắc.</p>
<h3 id="đối-xứng-và-quy-tắc-pascal">4.1 Đối xứng và Quy tắc Pascal</h3>
<p>Hai đẳng thức hữu ích là</p>
<p><span
class="math display">\[\binom{n}{k}=\binom{n}{n-k}\qquad{\mathrm{(đối
xứng)}},\]</span></p>
<p>và</p>
<p><span
class="math display">\[\binom{n}{k}=\binom{n-1}{k-1}+\binom{n-1}{k}\qquad(\mathrm{Quy
tắc~Pascal}).\]</span></p>
<h2 id="sắp-xếp-với-các-đối-tượng-lặp-lại-hệ-số-đa-thức">5 Sắp xếp với
Các Đối Tượng Lặp Lại (Hệ Số Đa thức)</h2>
<p>Nếu ta có <span class="math inline">\(n\)</span> đối tượng mà trong
đó có <span class="math inline">\(n_{1}\)</span> bản sao loại 1, <span
class="math inline">\(n_{2}\)</span> bản sao loại 2,…, <span
class="math inline">\(n_{k}\)</span> bản sao loại k (với <span
class="math inline">\(n_{1} + n_{2} + \cdots + n_{k} = n\)</span> ), thì
số cách sắp xếp tuyến tính khác nhau là hệ số đa thức</p>
<p><span class="math display">\[\frac{n!}{n_{1}!n_{2}!\cdots
n_{k}!}.\]</span></p>
<p>Ví dụ 6. Sắp xếp các chữ cái của từ POOPOO (2 chữ P, 4 chữ O):</p>
<p><span
class="math display">\[\frac{6!}{2!4!}=\frac{720}{2\cdot24}=15.\]</span></p>
<p>Ví dụ 7. Có bao nhiêu cách sắp xếp khác nhau gồm 3 mặt ngửa (H) và 7
mặt sấp (T) trong một chuỗi 10 lần tung đồng xu?</p>
<p><span
class="math display">\[\frac{10!}{3!7!}=\binom{10}{3}=120.\]</span></p>
<p>Ví dụ 8. Sắp xếp lại các chữ cái của BABYYYBAY (3 chữ B, 2 chữ A, 4
chữ Y):</p>
<p><span
class="math display">\[\frac{9!}{3!2!4!}=\frac{362880}{6\cdot2\cdot24}=1260.\]</span></p>
<h2 id="ứng-dụng-và-bài-tập-thực-hành">6 Ứng dụng và Bài tập Thực
hành</h2>
<p>Dưới đây là một số bài tập kết hợp các ý tưởng đã thảo luận. Hãy cố
gắng giải từng bài trước khi đọc lời giải.</p>
<p>Bài tập 1. Có bao nhiêu cách xếp 5 cuốn sách khác nhau lên một kệ nếu
hai cuốn sách đặc biệt phải đứng cạnh nhau?</p>
<p>Lời giải 1. Xem hai cuốn sách phải đứng cạnh nhau như một khối. Sau
đó chúng ta có 4 đối tượng để sắp xếp (khối cùng ba cuốn sách còn lại),
điều này có thể được thực hiện theo 4! cách. Trong khối, hai cuốn sách
có thể được sắp xếp theo 2! cách. Theo Quy tắc Nhân, tổng số là</p>
<p><span class="math display">\[4!\times2!=24\times2=48.\]</span></p>
<p>Bài tập 2. Một mật khẩu gồm đúng 6 ký tự được chọn từ 26 chữ cái in
hoa, với phép lặp được phép. Có bao nhiêu mật khẩu khác nhau có thể?</p>
<p>Lời giải 2. Mỗi trong 6 vị trí có thể được điền độc lập với bất kỳ
chữ cái nào trong 26 chữ cái. Theo Quy tắc Nhân,</p>
<p><span class="math display">\[26^{6}=308915776.\]</span></p>
<p>Bài tập 3. Từ một bộ bài 52 lá, có bao nhiêu tay bài 5 lá chứa đúng 2
quân át?</p>
<p>Giải pháp 3. Chọn 2 quân bài ác từ 4 quân bài có sẵn: <span
class="math inline">\(\binom{4}{2} = 6\)</span> cách. Chọn 3 quân bài
còn lại từ 48 quân bài không phải ác: <span
class="math inline">\(\binom{48}{3} = 17296\)</span> cách. Nhân:</p>
<p><span class="math display">\[6\times17296=103776.\]</span></p>
<p>Bài tập 4. Hỏi có bao nhiêu cách sắp xếp các chữ cái trong từ
MISSISSIPPI?</p>
<p>Giải pháp 4. Từ này có 11 chữ cái với các số lượng như sau: M = 1, I
= 4, S = 4, P = 2. Do đó</p>
<p><span
class="math display">\[\frac{11!}{1!\,4!\,4!\,2!}=\frac{39\,916\,800}{1\cdot24\cdot24\cdot2}=34\,650.\]</span></p>
<p>Bài tập 5. Một đội gồm 8 học sinh cần được chia thành hai nhóm có 3
người và một nhóm có 2 người (học sinh còn lại làm riêng). Hỏi có bao
nhiêu cách chia khác nhau nếu các nhóm không được đánh dấu (tức là chỉ
kích thước quan trọng)?</p>
<p>Giải pháp 5. Trước hết chọn nhóm có 3 người: <span
class="math inline">\(\binom{8}{3} = 56\)</span> . Từ số còn lại 5 người
chọn nhóm có 3 người nữa: <span class="math inline">\(\binom{5}{3} =
10\)</span> . Hai người còn lại tự động tạo thành cặp. Vì hai nhóm có
kích thước 3 là không phân biệt, ta đã tính thừa một yếu tố 2!. Do
đó</p>
<p><span class="math display">\[\frac{56\times10}{2}=280.\]</span></p>
<h2 id="tóm-tắt">7 Tóm tắt</h2>
<p>• Hoán vị của n đối tượng phân biệt: <span
class="math inline">\(n!\)</span> .</p>
<p>● k-Hoán vị: <span class="math inline">\(P(n, k) =
\frac{n!}{(n-k)!}\)</span> .</p>
<p>● Kết hợp: <span class="math inline">\(\binom{n}{k} =
\frac{n!}{k!(n-k)!}\)</span> .</p>
<p>● Sắp xếp có lặp lại: <span class="math inline">\(\frac{n!}{n_1! n_2!
\cdots n_k!}\)</span> .</p>
<p>● Quy tắc Tổng và Quy tắc Tích chứng minh tất cả các công thức
này.</p>
<p>Sự thành thạo các công thức này, cùng với việc luyện tập để xác định
khi nào thứ tự quan trọng và các đối tượng có khác nhau hay không, giúp
người học giải quyết một loạt các bài toán đếm gặp phải trong đại số,
xác suất và toán rời rạc.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Định Lý Nhị Thức Newton (Lớp 10)', 'Nhị thức Newton và khai triển lũy thừa của tổng.', '', 'article', '10', '<h1 id="định-lý-nhị-thức-newton-lớp-10">Định lý Nhị thức Newton Lớp
10</h1>
<h2 id="giới-thiệu">Giới thiệu</h2>
<p>Định lý nhị thức cho một công thức để khai triển lũy thừa của một
tổng gồm hai số hạng. Với bất kỳ số nguyên không âm nào n,</p>
<p><span
class="math display">\[(a+b)^{n}=\sum_{k=0}^{n}\binom{n}{k}a^{n-k}b^{k},\]</span></p>
<p>trong đó <span class="math inline">\(\binom{n}{k} =
\frac{n!}{k!(n-k)!}\)</span> là hệ số nhị thức. Định lý này được đặt tên
theo Isaac Newton, người cũng đã mở rộng nó cho các số mũ tùy ý (thực
hoặc phức); ở đây chúng ta xét trường hợp số nguyên, đây là phiên bản
được học trong lớp 10.</p>
<h2 id="phát-biểu-của-định-lý">Phát biểu của Định lý</h2>
<p>Với mọi số nguyên <span class="math inline">\(n \geq 0\)</span> và
bất kỳ các số nào <span class="math inline">\(a, b\)</span> ,</p>
<p><span
class="math display">\[(a+b)^{n}=\binom{n}{0}a^{n}b^{0}+\binom{n}{1}a^{n-1}b^{1}+\cdots+\binom{n}{n-1}a^{1}b^{n-1}+\binom{n}{n}a^{0}b^{n}.\]</span></p>
<p>Trong ký hiệu gọn:</p>
<p><span
class="math display">\[(a+b)^{n}=\sum_{k=0}^{n}\binom{n}{k}a^{n-k}b^{k}.\]</span></p>
<h2 id="chứng-minh-bằng-quy-nạp-toán-học">Chứng minh bằng quy nạp toán
học</h2>
<p>Chúng ta chứng minh công thức đúng với mọi <span
class="math inline">\(n \geq 0\)</span> .</p>
<p>Trường hợp cơ sở <span class="math inline">\((n=0)\)</span> :</p>
<p><span
class="math display">\[(a+b)^{0}=1=\binom{0}{0}a^{0}b^{0}.\]</span></p>
<p>Công thức đúng.</p>
<p>Bước quy nạp: Giả sử công thức đúng với một số <span
class="math inline">\(n = m \geq 0\)</span> :</p>
<p><span
class="math display">\[(a+b)^{m}=\sum_{k=0}^{m}\binom{m}{k}a^{m-k}b^{k}.\]</span></p>
<p>Chúng ta chứng minh nó đúng với <span class="math inline">\(n = m +
1\)</span> :</p>
<p><span
class="math display">\[\begin{align*}(a+b)^{m+1}&amp;=(a+b)(a+b)^{m}\\&amp;=(a+b)\sum_{k=0}^{m}\binom{m}{k}a^{m-k}b^{k}\\&amp;=\sum_{k=0}^{m}\binom{m}{k}a^{m+1-k}b^{k}+\sum_{k=0}^{m}\binom{m}{k}a^{m-k}b^{k+1}.\end{align*}\]</span></p>
<p>Trong tổng thứ hai đặt <span class="math inline">\(j = k + 1\)</span>
( <span class="math inline">\(k = j - 1\)</span> ); sau đó j chạy từ 1
đến <span class="math inline">\(m + 1\)</span> :</p>
<p><span
class="math display">\[\sum_{k=0}^{m}\binom{m}{k}a^{m-k}b^{k+1}=\sum_{j=1}^{m+1}\binom{m}{j-1}a^{m+1-j}b^{j}.\]</span></p>
<p>Bây giờ kết hợp hai tổng, lưu ý rằng các số hạng cho k = 0 trong tổng
thứ nhất và <span class="math inline">\(j = m + 1\)</span> trong tổng
thứ hai chỉ xuất hiện một lần:</p>
<p><span
class="math display">\[(a+b)^{m+1}=\binom{m}{0}a^{m+1}b^{0}+\sum_{k=1}^{m}\left[\binom{m}{k}+\binom{m}{k-1}\right]a^{m+1-k}b^{k}+\binom{m}{m}a^{0}b^{m+1}.\]</span></p>
<p>Sử dụng công thức Pascals <span
class="math inline">\(\binom{m}{k}+\binom{m}{k-1}=\binom{m+1}{k}\)</span>
ta thu được</p>
<p><span
class="math display">\[(a+b)^{m+1}=\sum_{k=0}^{m+1}\binom{m+1}{k}a^{m+1-k}b^{k},\]</span></p>
<p>đó chính là công thức cho <span class="math inline">\(n = m +
1\)</span> . Bằng quy nạp, định lý đúng với mọi <span
class="math inline">\(n \geq 0\)</span> .</p>
<h2 id="tam-giác-pascals">Tam giác Pascals</h2>
<p>Các hệ số <span class="math inline">\(\binom{n}{k}\)</span> tạo thành
tam giác Pascals:</p>
<p><span class="math display">\[\begin{array}{r l r l r
l}{{1}}&amp;{}&amp;{}&amp;{}&amp;{}\\
&amp;{}&amp;{1}&amp;{}&amp;{1}&amp;{}\\
&amp;{}&amp;{1}&amp;{2}&amp;{1}&amp;{}\\
{1}&amp;{}&amp;{3}&amp;{3}&amp;{1}&amp;{}\\ \end{array}\]</span></p>
<p>Mỗi mục là tổng của hai mục phía trên nó, phản ánh công thức Pascals
được sử dụng trong chứng minh.</p>
<h2 id="ví-dụ">Ví dụ</h2>
<ol type="1">
<li>Mở rộng <span class="math inline">\((x + y)^{3}\)</span> .</li>
</ol>
<p><span
class="math display">\[(x+y)^{3}=\binom{3}{0}x^{3}y^{0}+\binom{3}{1}x^{2}y^{1}+\binom{3}{2}x^{1}y^{2}+\binom{3}{3}x^{0}y^{3}=x^{3}+3x^{2}y+3xy^{2}+y^{3}.\]</span></p>
<ol start="2" type="1">
<li>Mở rộng <span class="math inline">\((2x - 3)^4\)</span> . Trước hết
viết <span class="math inline">\((2x + (-3))^4\)</span> và áp dụng định
lý:</li>
</ol>
<p><span
class="math display">\[(2x-3)^{4}=\sum_{k=0}^{4}\binom{4}{k}(2x)^{4-k}(-3)^{k}.\]</span></p>
<p>Tính từng số hạng:</p>
<p><span class="math display">\[k=0:\begin{pmatrix}4\\
0\end{pmatrix}(2x)^{4}(-3)^{0}=1\cdot16x^{4}\cdot1=16x^{4},\]</span></p>
<p><span
class="math display">\[k=1:\binom{4}{1}(2x)^{3}(-3)^{1}=4\cdot8x^{3}\cdot(-3)=-96x^{3},\]</span></p>
<p><span class="math display">\[k=2:\begin{pmatrix}4\\
2\end{pmatrix}(2x)^{2}(-3)^{2}=6\cdot4x^{2}\cdot9=216x^{2},\]</span></p>
<p><span
class="math display">\[k=3:\binom{4}{3}(2x)^{1}(-3)^{3}=4\cdot2x\cdot(-27)=-216x,\]</span></p>
<p><span
class="math display">\[k=4:\binom{4}{4}(2x)^{0}(-3)^{4}=1\cdot1\cdot81=81.\]</span></p>
<p>Vậy</p>
<p><span
class="math display">\[(2x-3)^{4}=16x^{4}-96x^{3}+216x^{2}-216x+81.\]</span></p>
<ol start="3" type="1">
<li>Tìm hệ số của <span class="math inline">\(x^{5}y^{2}\)</span> trong
<span class="math inline">\((x+y)^{7}\)</span> . Số hạng chứa <span
class="math inline">\(x^{5}y^{2}\)</span> tương ứng với k = 2 (lũy thừa
của y). Hệ số của nó là <span class="math inline">\(\binom{7}{2} =
21\)</span> .</li>
</ol>
<h2 id="bài-tập-thực-hành">Bài tập thực hành</h2>
<ol type="1">
<li><p>Khai triển <span class="math inline">\((a + 2b)^{5}\)</span> và
viết kết quả theo lũy thừa giảm dần của <span
class="math inline">\(a\)</span> .</p></li>
<li><p>Xác định hệ số của <span class="math inline">\(x^{3}\)</span>
trong khai triển của <span class="math inline">\((1 - 2x)^{6}\)</span>
.</p></li>
<li><p>Sử dụng định lý nhị thức, tính <span
class="math inline">\((1.01)^{10}\)</span> với độ chính xác bốn chữ số
thập phân (bạn có thể giữ các số hạng đến k = 3).</p></li>
</ol>
<h2 id="giải-pháp">Giải pháp</h2>
<ol type="1">
<li>Áp dụng <span class="math inline">\((a + 2b)^{5} = \sum_{k=0}^{5}
\binom{5}{k} a^{5-k} (2b)^{k}\)</span> :</li>
</ol>
<p><span
class="math display">\[k=0:\binom{5}{0}a^{5}(2b)^{0}=a^{5},\]</span></p>
<p><span class="math display">\[k=1:\binom{5}{1}a^{4}(2b)^{1}=5\cdot
a^{4}\cdot2b=10a^{4}b,\]</span></p>
<p><span class="math display">\[k=2:\begin{pmatrix}5\\
2\end{pmatrix}a^{3}(2b)^{2}=10\cdot
a^{3}\cdot4b^{2}=40a^{3}b^{2},\]</span></p>
<p><span class="math display">\[k=3:\binom{5}{3}a^{2}(2b)^{3}=10\cdot
a^{2}\cdot8b^{3}=80a^{2}b^{3},\]</span></p>
<p><span class="math display">\[k=4:\binom{5}{4}a^{1}(2b)^{4}=5\cdot
a\cdot16b^{4}=80ab^{4},\]</span></p>
<p><span
class="math display">\[k=5:\binom{5}{5}a^{0}(2b)^{5}=1\cdot1\cdot32b^{5}=32b^{5}.\]</span></p>
<p>Vậy</p>
<p><span
class="math display">\[(a+2b)^{5}=a^{5}+10a^{4}b+40a^{3}b^{2}+80a^{2}b^{3}+80ab^{4}+32b^{5}.\]</span></p>
<ol start="2" type="1">
<li>Trong <span class="math inline">\((1 - 2x)^{6} = \sum_{k=0}^{6}
\binom{6}{k} 1^{6-k} (-2x)^{k}\)</span> , số hạng chứa <span
class="math inline">\(x^{3}\)</span> có <span class="math inline">\(k =
3\)</span> :</li>
</ol>
<p><span class="math display">\[Hệ
số=\binom{6}{3}(-2)^{3}=20\cdot(-8)=-160.\]</span></p>
<p>Vậy hệ số của <span class="math inline">\(x^{3}\)</span> là -160.</p>
<ol start="3" type="1">
<li>Sử dụng <span
class="math inline">\((1+u)^{10}=\sum_{k=0}^{10}\binom{10}{k}u^{k}\)</span>
với u=0.01:</li>
</ol>
<p><span
class="math display">\[\begin{aligned}(1.01)^{10}&amp;\approx\binom{10}{0}(0.01)^{0}+\binom{10}{1}(0.01)^{1}+\binom{10}{2}(0.01)^{2}+\binom{10}{3}(0.01)^{3}\\&amp;=1+10\cdot0.01+45\cdot0.0001+120\cdot0.000001\\&amp;=1+0.10+0.0045+0.00012\\&amp;=1.10462.\end{aligned}\]</span></p>
<p>Làm tròn đến bốn chữ số thập phân: 1.1046.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Số Đặc Trưng Đo Lường Sự Phân Tán (Lớp 10)', 'Khoảng biến thiên, phương sai, độ lệch chuẩn.', '', 'article', '10', '<h1 id="số-đặc-trưng-đo-lường-sự-phân-tán-lớp-10">Số Đặc trưng Đo Lường
Sự Phân Tán (Lớp 10)</h1>
<p>Trong thống kê, một khi chúng ta đã mô tả trung tâm của một tập dữ
liệu (trung bình, trung vị, mốt), chúng ta thường cần biết dữ liệu phân
tán như thế nào. Các số đo lường sự phân tán này được gọi là các đại
lượng đo lường sự phân tán. Dưới đây chúng ta sẽ thảo luận các đại lượng
phổ biến nhất phù hợp với chương trình lớp 10, đưa ra định nghĩa, công
thức, ví dụ, và cung cấp các bài tập với lời giải chi tiết.</p>
<h3 id="phạm-vi">1. Phạm Vi</h3>
<p>Đại lượng đơn giản nhất đo lường sự phân tán là hiệu giữa giá trị lớn
nhất và giá trị nhỏ nhất.</p>
<p><span class="math display">\[\mathrm{Phạm\
vi}=x_{\max}-x_{\min}\]</span></p>
<p>Ví dụ 1 Xét điểm thi của mười học sinh lớp 10:</p>
<p><span
class="math display">\[\{58,62,67,70,73,75,78,82,85,90\}.\]</span></p>
<p>Tại đây <span class="math inline">\(x_{\min} = 58\)</span> và <span
class="math inline">\(x_{\max} = 90\)</span> ; do đó</p>
<p><span class="math display">\[\mathrm{Phạm\ vi}=90-58=32.\]</span></p>
<p>Ghi chú Phạm vi dễ tính toán nhưng chỉ sử dụng hai quan sát; nó có
thể bị ảnh hưởng mạnh bởi các giá trị ngoại lệ.</p>
<h3 id="phạm-vi-tứ-phân-vị-iqr">2. Phạm Vi Tứ Phân Vị (IQR)</h3>
<p>Phạm vi tứ phân vị đo lường sự phân tán của 50% dữ liệu ở giữa. Trước
hết tìm tứ phân vị thứ nhất <span class="math inline">\(Q_{1}\)</span>
(trung vị của nửa dưới) và tứ phân vị thứ ba <span
class="math inline">\(Q_{3}\)</span> (trung vị của nửa trên). Sau đó</p>
<p><span class="math display">\[\mathrm{Phạm\ vi\ tứ\ phân\
vị}=Q_{3}-Q_{1}.\]</span></p>
<p>[Ảnh về biểu đồ hộp cho thấy IQR và các tứ phân vị]</p>
<p><span class="math display">\[Mốt=\frac{73+75}{2}=74,\]</span></p>
<p><span
class="math display">\[\mathrm{Phần~trái}=\{58,62,67,70,73\},\]</span></p>
<p><span class="math display">\[Q_{1}=mốt của phần trái=67,\]</span></p>
<p><span
class="math display">\[\mathrm{Phần~phải}=\{75,78,82,85,90\},\]</span></p>
<p><span class="math display">\[Q_{3}=mốt của phần phải=82.\]</span></p>
<p>Như vậy</p>
<p><span class="math display">\[\mathrm{IQR}=82-67=15.\]</span></p>
<p>Ghi chú: IQR ít bị ảnh hưởng bởi các giá trị ngoại lệ vì nó loại bỏ
25% giá trị thấp nhất và 25% giá trị cao nhất của các quan sát.</p>
<h3 id="độ-lệch-tuyệt-đối-trung-bình-mad">3. Độ lệch tuyệt đối trung
bình (MAD)</h3>
<p>MAD là trung bình của các khoảng cách tuyệt đối của mỗi quan sát so
với giá trị trung bình <span class="math inline">\(\bar{x}\)</span>
.</p>
<p><span
class="math display">\[\mathrm{MAD}=\frac{1}{n}\sum_{i=1}^{n}\left|x_{i}-\bar{x}\right|.\]</span></p>
<p>Ví dụ 3: Với bộ dữ liệu <span
class="math inline">\(\{58,62,67,70,73,75,78,82,85,90\}\)</span> :</p>
<p><span
class="math display">\[\bar{x}=\frac{58+62+67+70+73+75+78+82+85+90}{10}=74.\]</span></p>
<p>Tính các độ lệch tuyệt đối:</p>
<table border="1" style="margin: auto; word-wrap: break-word;">
<tr>
<td style="text-align: center; word-wrap: break-word;">
<span class="math inline">\(x_{i}\)</span>
</td>
<td style="text-align: center; word-wrap: break-word;">
<span class="math inline">\(|x_{i}-x|\)</span>
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
58
</td>
<td style="text-align: center; word-wrap: break-word;">
16
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
62
</td>
<td style="text-align: center; word-wrap: break-word;">
12
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
67
</td>
<td style="text-align: center; word-wrap: break-word;">
7
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
70
</td>
<td style="text-align: center; word-wrap: break-word;">
4
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
73
</td>
<td style="text-align: center; word-wrap: break-word;">
1
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
75
</td>
<td style="text-align: center; word-wrap: break-word;">
1
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
78
</td>
<td style="text-align: center; word-wrap: break-word;">
4
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
82
</td>
<td style="text-align: center; word-wrap: break-word;">
8
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
85
</td>
<td style="text-align: center; word-wrap: break-word;">
11
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
90
</td>
<td style="text-align: center; word-wrap: break-word;">
16
</td>
</tr>
</table>
<p>Tổng = 80; do đó</p>
<p><span
class="math display">\[\mathrm{MAD}=\frac{80}{10}=8.\]</span></p>
<p>Ghi chú MAD là trực quan (khoảng cách trung bình từ giá trị trung
bình) nhưng ít được sử dụng trong toán học hơn phương sai do sử dụng giá
trị tuyệt đối.</p>
<h3 id="phương-sai-và-độ-lệch-chuẩn">4. Phương sai và Độ lệch chuẩn</h3>
<p>Phương sai đo lường trung bình độ lệch bình phương so với giá trị
trung bình. Đối với một mẫu, chúng ta sử dụng</p>
<p><span
class="math display">\[s^{2}=\frac{1}{n-1}\sum_{i=1}^{n}\left(x_{i}-\bar{x}\right)^{2},\]</span></p>
<p>và độ lệch chuẩn (của mẫu) là <span class="math inline">\(s =
\sqrt{s^2}\)</span> . Đối với một quần thể, chúng ta thay n - 1 bằng
N.</p>
<p>Ví dụ 4 Sử dụng cùng dữ liệu:</p>
<table border="1" style="margin: auto; word-wrap: break-word;">
<tr>
<td style="text-align: center; word-wrap: break-word;">
<span class="math inline">\(x_{i}\)</span>
</td>
<td style="text-align: center; word-wrap: break-word;">
<span class="math inline">\(x_{i}-\bar{x}\)</span>
</td>
<td style="text-align: center; word-wrap: break-word;">
<span class="math inline">\((x_{i}-\bar{x})^{2}\)</span>
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
58
</td>
<td style="text-align: center; word-wrap: break-word;">
-16
</td>
<td style="text-align: center; word-wrap: break-word;">
256
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
62
</td>
<td style="text-align: center; word-wrap: break-word;">
-12
</td>
<td style="text-align: center; word-wrap: break-word;">
144
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
67
</td>
<td style="text-align: center; word-wrap: break-word;">
-7
</td>
<td style="text-align: center; word-wrap: break-word;">
49
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
70
</td>
<td style="text-align: center; word-wrap: break-word;">
-4
</td>
<td style="text-align: center; word-wrap: break-word;">
16
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
73
</td>
<td style="text-align: center; word-wrap: break-word;">
-1
</td>
<td style="text-align: center; word-wrap: break-word;">
1
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
75
</td>
<td style="text-align: center; word-wrap: break-word;">
1
</td>
<td style="text-align: center; word-wrap: break-word;">
1
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
78
</td>
<td style="text-align: center; word-wrap: break-word;">
4
</td>
<td style="text-align: center; word-wrap: break-word;">
16
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
82
</td>
<td style="text-align: center; word-wrap: break-word;">
8
</td>
<td style="text-align: center; word-wrap: break-word;">
64
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
85
</td>
<td style="text-align: center; word-wrap: break-word;">
11
</td>
<td style="text-align: center; word-wrap: break-word;">
121
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
90
</td>
<td style="text-align: center; word-wrap: break-word;">
16
</td>
<td style="text-align: center; word-wrap: break-word;">
256
</td>
</tr>
</table>
<p>Tổng bình phương = 924. Với n = 10,</p>
<p><span
class="math display">\[s^{2}=\frac{924}{10-1}=\frac{924}{9}=102.\overline{6}\approx102.67,\qquad
s=\sqrt{102.67}\approx10.13.\]</span></p>
<p>Ghi chú Phương sai được tính bằng đơn vị bình phương; lấy căn bậc hai
sẽ đưa độ phân tán trở lại đơn vị gốc. Độ lệch chuẩn là thước đo độ phân
tán được sử dụng phổ biến nhất.</p>
<h3 id="hệ-số-biến-thiên-cv">5. Hệ số biến thiên (CV)</h3>
<p>Khi so sánh mức độ biến thiên giữa các tập dữ liệu có giá trị trung
bình khác nhau (hoặc đơn vị khác nhau), chúng ta chuẩn hóa độ lệch chuẩn
bằng giá trị trung bình:</p>
<p><span
class="math display">\[CV=\frac{s}{\bar{x}}\times100\%.\]</span></p>
<p>Ví dụ 5 Hai lớp có các thống kê tóm tắt sau cho một bài kiểm tra toán
học:</p>
<p><span class="math display">\[Lớp A:\bar{x}=78,s=5.2\]</span></p>
<p><span class="math display">\[Lớp B:\bar{x}=65,s=4.8\]</span></p>
<p><span
class="math display">\[CV_{A}=\frac{5.2}{78}\times100\%\approx6.67\%,
\quad CV_{B}=\frac{4.8}{65}\times100\%\approx7.38\%.\]</span></p>
<p>Mặc dù Lớp A có độ lệch chuẩn tuyệt đối lớn hơn, biến thiên tương đối
so với trung bình của nó nhỏ hơn.</p>
<h2 id="bài-tập-luyện-tập">Bài tập Luyện Tập</h2>
<ol type="1">
<li><p>Tính khoảng biến thiên, IQR, MAD, phương sai, độ lệch chuẩn, và
CV cho tập dữ liệu <span class="math inline">\(\{12, 15, 14, 10, 18, 20,
22, 19, 17, 16\}\)</span> .</p></li>
<li><p>Một nhà khoa học đo chiều cao (trong cm) của mười học sinh lớp
10:</p></li>
</ol>
<p><span
class="math display">\[\{158,162,165,160,159,163,167,161,166,164\}.\]</span></p>
<p>Tìm phương sai và độ lệch chuẩn mẫu.</p>
<ol start="3" type="1">
<li>Hai lô sản phẩm có các thống kê tóm tắt sau:</li>
</ol>
<p><span
class="math display">\[\mathrm{Lô~}1\colon\bar{x}=50\mathrm{~mm},\
s=2.0\mathrm{~mm}\]</span></p>
<p><span
class="math display">\[\mathrm{Lô~2:}\bar{x}=75\mathrm{~mm},s=3.0\mathrm{~mm}\]</span></p>
<p>Lô nào thể hiện sự biến thiên tương đối lớn hơn? Hãy giải thích bằng
hệ số biến thiên.</p>
<ol start="4" type="1">
<li>Bảng tần suất sau cho biết số cuốn sách được đọc bởi học sinh lớp 10
trong một tháng:</li>
</ol>
<table border="1" style="margin: auto; word-wrap: break-word;">
<tr>
<td style="text-align: center; word-wrap: break-word;">
Sách
</td>
<td style="text-align: center; word-wrap: break-word;">
Tần suất
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
0
</td>
<td style="text-align: center; word-wrap: break-word;">
5
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
1
</td>
<td style="text-align: center; word-wrap: break-word;">
8
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
2
</td>
<td style="text-align: center; word-wrap: break-word;">
12
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
3
</td>
<td style="text-align: center; word-wrap: break-word;">
7
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
4
</td>
<td style="text-align: center; word-wrap: break-word;">
3
</td>
</tr>
</table>
<p>Tính trung bình, phương sai, và độ lệch chuẩn cho dữ liệu nhóm
này.</p>
<h2 id="giải-pháp">Giải Pháp</h2>
<p>Giải pháp cho Bài toán 1 Sắp xếp: <span
class="math inline">\(\{10,12,14,15,16,17,18,19,20,22\}\)</span> .</p>
<p>• Khoảng biến thiên: 22 - 10 = 12.</p>
<p>● Trung vị: 16.5. <span class="math inline">\(Q_{1}=14,
Q_{3}=19\)</span> . IQR = 5.</p>
<p>● Trung bình <span class="math inline">\(\bar{x} = 16.3\)</span> .
MAD = 2.8.</p>
<p>● Phương sai mẫu <span class="math inline">\(s^{2} \approx
13.57\)</span> .</p>
<p>• Độ lệch chuẩn <span class="math inline">\(s \approx 3.68\)</span>
.</p>
<p>● CV ≈ 22.6%.</p>
<p>Giải bài toán số 2 Trung bình: 162.5. Phương sai mẫu <span
class="math inline">\(s^{2} \approx 9.17\)</span> . Độ lệch chuẩn <span
class="math inline">\(s \approx 3.03\)</span> cm.</p>
<p>Giải bài toán số 3 <span class="math inline">\(CV_{1} = CV_{2} =
4\%\)</span> . Cả hai lô hàng đều có độ biến thiên tương đối giống
nhau.</p>
<p>Giải bài toán số 4 Trung bình <span class="math inline">\(\bar{x}
\approx 1.86\)</span> . Phương sai <span class="math inline">\(s^2
\approx 1.36\)</span> . Độ lệch chuẩn <span class="math inline">\(s
\approx 1.17\)</span> .</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Sự Kiện và Định Nghĩa Cổ Điển của Xác Suất (Lớp 10)', 'Không gian mẫu, biến cố và định nghĩa cổ điển của xác suất.', '', 'article', '10', '<h1 id="sự-kiện-và-định-nghĩa-cổ-điển-của-xác-suất">Sự kiện và Định
nghĩa cổ điển của Xác suất</h1>
<h3 id="không-gian-mẫu-và-sự-kiện">1. Không gian mẫu và Sự kiện</h3>
<ul>
<li>Không gian mẫu <span class="math inline">\(\Omega\)</span> là tập
hợp tất cả các kết quả có thể xảy ra của một thí nghiệm ngẫu nhiên.</li>
</ul>
<p>• Một sự kiện là bất kỳ tập con nào <span class="math inline">\(A
\subseteq \Omega\)</span> .</p>
<p>• Ví dụ:</p>
<p><span
class="math display">\[\Omega=\{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\}.\]</span></p>
<p>• Định nghĩa</p>
<p><span class="math display">\[E=\{\mathrm{số
lẻ}\}=\{1,3,5,7,9,11,13,15\},\]</span></p>
<p><span class="math display">\[F=\{\mathrm{số nguyên
tố}\}=\{2,3,5,7,11,13\},\]</span></p>
<p><span class="math display">\[G=E\cup
F=\{1,2,3,5,7,9,11,13,15\}.\]</span></p>
<h3 id="định-nghĩa-cổ-điển-của-xác-suất">2. Định nghĩa cổ điển của Xác
suất</h3>
<p>Nếu tất cả các kết quả trong <span
class="math inline">\(\Omega\)</span> đều có cùng khả năng xảy ra, thì
với bất kỳ sự kiện nào <span class="math inline">\(A \subseteq
\Omega\)</span></p>
<p><span class="math display">\[P(A)=\frac{|A|}{|\Omega|},\]</span></p>
<p>trong đó <span class="math inline">\(|A|\)</span> ký hiệu số kết quả
trong A.</p>
<h2 id="ví-dụ-1">Ví dụ 1</h2>
<p>Xác suất rút một số lẻ từ <span class="math inline">\(\Omega\)</span>
là</p>
<p><span
class="math display">\[P(E)=\frac{|E|}{|\Omega|}=\frac{8}{15}.\]</span></p>
<h2 id="ví-dụ-2">Ví dụ 2</h2>
<p>Xác suất rút một số nguyên tố đồng thời là số lẻ và nguyên tố (tức là
<span class="math inline">\(E \cap F\)</span> ):</p>
<p><span class="math display">\[E\cap F=\{3,5,7,11,13\},\qquad|E\cap
F|=5,\]</span></p>
<p><span class="math display">\[P(E\cap
F)=\frac{5}{15}=\frac{1}{3}.\]</span></p>
<h3 id="các-phép-tác-động-cơ-bản-trên-sự-kiện">3. Các Phép Tác Động Cơ
Bản Trên Sự Kiện</h3>
<p>• Hợp: <span class="math inline">\(A \cup B = \text{các kết quả trong
} A \text{ hoặc } B\)</span> (hoặc cả hai).</p>
<p>• Giao: <span class="math inline">\(A \cap B =\)</span> các kết quả
trong cả A và B.</p>
<p>• Bổ sung: <span class="math inline">\(A^c = \Omega \setminus A
=\)</span> các kết quả không trong A.</p>
<p>Tính chất:</p>
<p><span class="math display">\[P(A\cup B)=P(A)+P(B)-P(A\cap B),\qquad
P(A^{c})=1-P(A).\]</span></p>
<p>Ví dụ 3 (sử dụng E và F)</p>
<p><span class="math display">\[P(E\cup F)=P(E)+P(F)-P(E\cap
F)=\frac{8}{15}+\frac{6}{15}-\frac{5}{15}=\frac{9}{15}=\frac{3}{5}.\]</span></p>
<h3 id="sự-kiện-không-chéo-nhau">4. Sự Kiện Không Chéo Nhau</h3>
<p>Hai sự kiện A và B được gọi là không chéo nhau (phân biệt) nếu <span
class="math inline">\(A \cap B = \varnothing\)</span> . Khi đó</p>
<p><span class="math display">\[P(A\cup B)=P(A)+P(B).\]</span></p>
<h2 id="bài-tập-thực-hành-4">Bài Tập Thực Hành 4</h2>
<p>Một hộp chứa 20 tấm thẻ được đánh số từ 1 đến 20. Gọi A là “rút một
số chẵn &gt; 9”. Gọi B là “rút một số từ 8 đến 15 (bao gồm cả hai đầu)”.
Tìm <span class="math inline">\(|A \cup B|\)</span> .</p>
<p>Giải:</p>
<p><span class="math display">\[A=\{10,12,14,16,18,20\},\
|A|=6.\]</span></p>
<p><span class="math display">\[B=\{8,9,10,11,12,13,14,15\},\
|B|=8.\]</span></p>
<p><span class="math display">\[A\cap B=\{10,12,14\},\ |A\cap
B|=3.\]</span></p>
<p><span class="math display">\[|A\cup B|=|A|+|B|-|A\cap
B|=6+8-3=11.\]</span></p>
<p>Vì vậy, đáp án đúng là A. 11.</p>
<h3 id="sự-kiện-độc-lập">5. Sự Kiện Độc Lập</h3>
<p>Hai sự kiện A và B được gọi là độc lập nếu</p>
<p><span class="math display">\[P(A\cap B)=P(A)P(B).\]</span></p>
<h2 id="bài-tập-thực-hành-5">Bài Tập Thực Hành 5</h2>
<p>Cho <span class="math inline">\(P(A) = 0.3\)</span> , <span
class="math inline">\(P(B) = 0.4\)</span> , <span
class="math inline">\(P(A \cap B) = 0.2\)</span> . Xác định xem A và B
có phải là không chéo nhau và/or độc lập hay không.</p>
<p>Giải:</p>
<p>• Không chéo nhau? <span class="math inline">\(P(A \cap B) = 0.2 \neq
0\)</span> Không phải sự kiện không chéo nhau.</p>
<p>• Độc lập? <span class="math inline">\(P(A)P(B) = 0.3 \times 0.4 =
0.12 \neq 0.2\)</span> Không độc lập.</p>
<p>Do đó, A và B không phải là sự kiện không chéo nhau cũng không phải
là sự kiện độc lập.</p>
<h3 id="xác-suất-có-điều-kiện-ngắn-gọn">6. Xác suất có điều kiện (ngắn
gọn)</h3>
<p><span class="math display">\[P(A\mid B)=\frac{P(A\cap
B)}{P(B)},\qquad P(B)&gt;0.\]</span></p>
<h3 id="ứng-dụng">7. Ứng dụng</h3>
<h2 id="sắp-xếp-chỗ-ngồi">Sắp xếp chỗ ngồi</h2>
<p>Mười người được xếp vào một hàng. Quang và Huyn phải ngồi cạnh nhau.
Số cách xếp mà họ ngồi cạnh nhau: <span class="math inline">\(6 \cdot 3!
\cdot 5! = 6 \cdot 6 \cdot 120 = 4320\)</span> . Tổng số cách xếp 10
người: <span class="math inline">\(10! = 3628800\)</span> . Do đó</p>
<p><span class="math display">\[P(Quang và Huyn ngồi cạnh
nhau)=\frac{4320}{3628800}=\frac{1}{280}.\]</span></p>
<h2 id="bốc-bóng-không-hoàn-lại">Bốc bóng không hoàn lại</h2>
<p>Một cái urn chứa 7 bóng xanh và 8 bóng đỏ (tổng cộng 15 bóng). Bốc 3
bóng không hoàn lại. Xác suất có ít nhất một bóng đỏ:</p>
<p><span class="math display">\[P(tối thiểu một bóng đỏ)=1-P(tất cả bóng
xanh)=1-\frac{\binom{7}{3}}{\binom{15}{3}}=1-\frac{35}{455}=1-\frac{1}{13}=\frac{12}{13}.\]</span></p>
<h3 id="bài-tập-bổ-sung">8. Bài tập bổ sung</h3>
<ol type="1">
<li>Một xúc xắc sáu mặt được gieo. Gọi <span
class="math inline">\(A\)</span> là “kết quả là số chẵn”. Tìm <span
class="math inline">\(P(A)\)</span> .</li>
</ol>
<p>Giải: <span class="math inline">\(A = \{2, 4, 6\}\)</span> , <span
class="math inline">\(|A| = 3\)</span> , <span
class="math inline">\(|\Omega| = 6\)</span> , do đó <span
class="math inline">\(P(A) = \frac{3}{6} = \frac{1}{2}\)</span> .</p>
<ol start="2" type="1">
<li><p>Hai đồng xu được tung. Định nghĩa <span
class="math inline">\(B\)</span> là “chính xác một mặt ngửa xuất hiện”.
Tính <span class="math inline">\(P(B)\)</span> . Giải: Không gian mẫu
<span class="math inline">\(\{HH, HT, TH, TT\}\)</span> ; thuận lợi
<span class="math inline">\(\{HT, TH\}\)</span> ; <span
class="math inline">\(|B| = 2\)</span> , <span
class="math inline">\(|\Omega| = 4\)</span> , <span
class="math inline">\(P(B) = \frac{2}{4} = \frac{1}{2}\)</span>
.</p></li>
<li><p>Từ một bộ bài 52 lá, ba lá được rút không hoàn lại. Tìm xác suất
rằng không có lá nào là lá rô. Giải:</p></li>
</ol>
<p><span
class="math display">\[P=\frac{39}{52}\cdot\frac{38}{51}\cdot\frac{37}{50}=\frac{39\cdot38\cdot37}{52\cdot51\cdot50}=\frac{54834}{132600}=\frac{9139}{22100}\approx0.413.\]</span></p>
<ol start="4" type="1">
<li>Một sinh viên phải chọn một môn tự chọn trong nghệ thuật, địa chất,
tâm lý học. Cô ấy có khả năng như nhau chọn nghệ thuật hoặc tâm lý học
và gấp đôi khả năng chọn địa chất. Tìm xác suất cho mỗi lựa chọn. Giải:
Gọi p là <span class="math inline">\(P(\text{nghệ thuật}) = P(\text{tâm
lý học})\)</span> . Khi đó <span class="math inline">\(P(\text{địa
chất}) = 2p\)</span> . Vì tổng xác suất bằng 1:</li>
</ol>
<p><span class="math display">\[p+2p+p=4p=1\implies
p=\frac{1}{4}.\]</span></p>
<p>Do đó</p>
<p><span class="math display">\[P(\mathrm{nghệ thuật})=P(\mathrm{tâm lý
học})=\frac{1}{4},\qquad P(\mathrm{địa chất})=\frac{1}{2}.\]</span></p>
<h3 id="tóm-tắt">9. Tóm tắt</h3>
<p>● Định nghĩa cổ điển áp dụng khi các kết quả có cùng khả năng xảy
ra.</p>
<p>● Xác suất của một sự kiện A là tỉ số giữa số kết quả thuận lợi và
tổng số kết quả.</p>
<p>• Sử dụng các phép toán tập hợp (hợp, giao, phần bù) để kết hợp các
sự kiện.</p>
<p>• Các sự kiện loại trừ lẫn nhau đơn giản hóa quy tắc cộng.</p>
<ul>
<li>Các sự kiện độc lập thỏa mãn <span class="math inline">\(P(A \cap B)
= P(A)P(B)\)</span> .</li>
</ul>
<p>• Xác suất có điều kiện xử lý sự phụ thuộc giữa các sự kiện.</p>
');