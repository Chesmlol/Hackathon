-- Xoá bản ghi trùng tên (nếu re-run), rồi chèn lại 3 bài tiếng Việt Lớp 11
DELETE FROM lessons WHERE title = 'Hợp, Giao và Sự Độc Lập của Các Sự Kiện (Lớp 11)';
DELETE FROM lessons WHERE title = 'Quy Tắc Cộng Xác Suất (Lớp 11)';
DELETE FROM lessons WHERE title = 'Tích Của Các Xác Suất Của Hai Sự Kiện Độc Lập (Lớp 11)';

INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Hợp, Giao và Sự Độc Lập của Các Sự Kiện (Lớp 11)', 'Hợp, giao và tính độc lập của biến cố — bản tiếng Việt.', '', 'article', '11', '<h1 id="hợp-giao-và-sự-độc-lập-của-các-sự-kiện-lớp-11">Hợp, Giao và Sự
Độc Lập của Các Sự Kiện (Lớp 11)</h1>
<h3 id="hợp-của-các-sự-kiện">1. Hợp của Các Sự Kiện</h3>
<p>Định nghĩa: Với hai sự kiện A và B trong không gian mẫu S, hợp <span
class="math inline">\(A \cup B\)</span> là sự kiện xảy ra khi ít nhất
một trong các sự kiện A hoặc B xảy ra:</p>
<p><span class="math display">\[A\cup B=\{x\in S\mid x\in A \text{ hoặc
} x\in B\}.\]</span></p>
<p>Định lý: [Quy tắc Cộng] Với bất kỳ hai sự kiện A và B nào,</p>
<p><span class="math display">\[P(A\cup B)=P(A)+P(B)-P(A\cap
B).\]</span></p>
<p>Nếu <span class="math inline">\(A\)</span> và <span
class="math inline">\(B\)</span> là các sự kiện loại trừ lẫn nhau (
<span class="math inline">\(A \cap B = \varnothing\)</span> ), thì <span
class="math inline">\(P(A \cup B) = P(A) + P(B)\)</span> .</p>
<p>Ví dụ: Gọi <span class="math inline">\(A\)</span> là sự kiện con xúc
xắc cho số chẵn và <span class="math inline">\(B\)</span> là sự kiện con
xúc xắc cho số <span class="math inline">\(\geq 4\)</span> trên một con
xúc xắc sáu mặt công bằng. <span class="math inline">\(A = \{2, 4,
6\}\)</span> , <span class="math inline">\(B = \{4, 5, 6\}\)</span> ,
<span class="math inline">\(A \cap B = \{4, 6\}\)</span> . Do đó</p>
<p><span class="math display">\[P(A)=\frac{3}{6},\quad
P(B)=\frac{3}{6},\quad P(A\cap B)=\frac{2}{6},\]</span></p>
<p>và</p>
<p><span class="math display">\[P(A\cup
B)=\frac{3}{6}+\frac{3}{6}-\frac{2}{6}=\frac{4}{6}=\frac{2}{3}.\]</span></p>
<p>Bài tập: Romeo và Juliet mỗi người đến ngẫu nhiên giữa 0 và 1 giờ.
Gọi X là thời gian đến của Romeo và Y là thời gian đến của Juliet. Định
nghĩa sự kiện gặp nhau <span class="math inline">\(M = \{(x, y) : |x -
y| \leq \frac{1}{4}\}\)</span> . Tính <span
class="math inline">\(P(M)\)</span> .</p>
<p>Giải: Vùng <span class="math inline">\(|x-y| \leq
\frac{1}{4}\)</span> bên trong hình vuông đơn vị có diện tích được tính
bằng cách trừ diện tích hai tam giác góc cạnh khỏi diện tích tổng
(1):</p>
<p><span
class="math display">\[Area=1-2\left(\frac{1}{2}\cdot\frac{3}{4}\cdot\frac{3}{4}\right)=1-\frac{9}{16}=\frac{7}{16}.\]</span></p>
<p>Vì phân phối chung là đều, <span class="math inline">\(P(M) =
\frac{7}{16}\)</span> .</p>
<p>Bài tập: Gọi <span class="math inline">\(A = \{số chẵn &gt; 9\ lên
đến 20\}\)</span> và <span class="math inline">\(B =
\{8,9,\ldots,15\}\)</span> . Tìm <span class="math inline">\(|A \cup
B|\)</span> .</p>
<p>Giải: <span class="math inline">\(A = \{10, 12, 14, 16, 18,
20\}\)</span> , <span class="math inline">\(|A| = 6\)</span> . <span
class="math inline">\(B = \{8, 9, 10, 11, 12, 13, 14, 15\}\)</span> ,
<span class="math inline">\(|B| = 8\)</span> . <span
class="math inline">\(A \cap B = \{10, 12, 14\}\)</span> , <span
class="math inline">\(|A \cap B| = 3\)</span> . Do đó <span
class="math inline">\(|A \cup B| = |A| + |B| - |A \cap B| = 6 + 8 - 3 =
11\)</span> .</p>
<h3 id="giao-của-các-sự-kiện">2. Giao của Các Sự Kiện</h3>
<p>Định nghĩa: Giao <span class="math inline">\(A \cap B\)</span> là sự
kiện xảy ra khi cả A và B đều xảy ra:</p>
<p><span class="math display">\[A\cap B=\{x\in S\mid x\in A và x\in
B\}.\]</span></p>
<p>Định lý: Với bất kỳ các sự kiện A và B nào,</p>
<p><span class="math display">\[P(A\cap B)=P(A)+P(B)-P(A\cup
B).\]</span></p>
<p>Nếu <span class="math inline">\(A\)</span> và <span
class="math inline">\(B\)</span> là độc lập, thì <span
class="math inline">\(P(A \cap B) = P(A)P(B)\)</span> .</p>
<p>Bài tập: Một hộp chứa 5 quả bóng xanh và 3 quả bóng đỏ. Hai quả bóng
được rút ra mà không thay thế. Gọi A là quả bóng đầu tiên là xanh và B
quả bóng thứ hai là xanh. Tính <span class="math inline">\(P(A \cap
B)\)</span> .</p>
<p>Giải pháp: <span class="math inline">\(P(A) = \frac{5}{8}\)</span> .
Sau khi rút một quả bóng xanh, còn lại 4 quả bóng xanh và 3 quả bóng đỏ,
do đó <span class="math inline">\(P(B \mid A) = \frac{4}{7}\)</span> .
Như vậy <span class="math inline">\(P(A \cap B) = P(A)P(B \mid A) =
\frac{5}{8} \cdot \frac{4}{7} = \frac{20}{56} = \frac{5}{14}\)</span>
.</p>
<h3 id="các-sự-kiện-độc-lập">3. Các Sự Kiện Độc Lập</h3>
<p>Định nghĩa: Hai sự kiện A và B được gọi là độc lập nếu</p>
<p><span class="math display">\[P(A\cap B)=P(A)P(B).\]</span></p>
<p>Sự độc lập không kéo theo tính loại trừ lẫn nhau; thực tế, nếu <span
class="math inline">\(P(A) &gt; 0\)</span> và <span
class="math inline">\(P(B) &gt; 0\)</span> , các sự kiện loại trừ lẫn
nhau không thể độc lập.</p>
<p>Ví dụ: Trong một bộ bài chuẩn, gọi A là quân bài là đỏ và B là quân
bài là Ace.</p>
<p><span class="math display">\[P(A)=\frac{26}{52}=\frac{1}{2},\quad
P(B)=\frac{4}{52}=\frac{1}{13},\quad P(A\cap
B)=\frac{2}{52}=\frac{1}{26}.\]</span></p>
<p>Vì <span class="math inline">\(\frac{1}{2} \cdot \frac{1}{13} =
\frac{1}{26}\)</span> , các sự kiện là độc lập.</p>
<p>Bài tập: Sau khi loại bỏ quân Ace của cõi, hãy tìm một cặp sự kiện
độc lập không tầm thường.</p>
<p>Giải pháp: Bộ bài giờ có 51 quân. Định nghĩa hai sự kiện sau:</p>
<p><span class="math display">\[A=\{\mathrm{a l l~h e a r t
s}\}\cup\{2\spadesuit,3\spadesuit,4\spadesuit,5\spadesuit\},\]</span></p>
<p><span
class="math display">\[B=\{2\heartsuit,3\diamondsuit,4\clubsuit\}.\]</span></p>
<p>Số phần tử: <span class="math inline">\(|A| = 13 + 4 = 17\)</span> ,
<span class="math inline">\(|B| = 3\)</span> . Giao <span
class="math inline">\(A \cap B\)</span> chỉ chứa một quân bài: <span
class="math inline">\(\{2\heartsuit\}\)</span> . Như vậy <span
class="math inline">\(|A \cap B| = 1\)</span> . Với tổng số quân bài là
<span class="math inline">\(N = 51\)</span> :</p>
<p><span class="math display">\[P(A)=\frac{17}{51},\quad
P(B)=\frac{3}{51}=\frac{1}{17},\quad P(A\cap
B)=\frac{1}{51}.\]</span></p>
<p>Tính tích:</p>
<p><span
class="math display">\[P(A)P(B)=\frac{17}{51}\cdot\frac{3}{51}=\frac{51}{2601}=\frac{1}{51}=P(A\cap
B).\]</span></p>
<p>Vì <span class="math inline">\(P(A \cap B) = P(A)P(B)\)</span> , các
sự kiện A và B là độc lập.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Quy Tắc Cộng Xác Suất (Lớp 11)', 'Quy tắc cộng xác suất P(A∪B) = P(A) + P(B) − P(A∩B).', '', 'article', '11', '<h1 id="quy-tắc-cộng-xác-suất">Quy tắc cộng xác suất</h1>
<p>Với bất kỳ hai sự kiện A và B nào trong không gian mẫu S,</p>
<p><span class="math display">\[P(A\cup B)=P(A)+P(B)-P(A\cap
B).\]</span></p>
<p>Nếu <span class="math inline">\(A\)</span> và <span
class="math inline">\(B\)</span> là sự kiện xung khắc (tức là <span
class="math inline">\(A \cap B = \varnothing\)</span> ), công thức đơn
giản hóa thành</p>
<p><span class="math display">\[P(A\cup B)=P(A)+P(B).\]</span></p>
<h2 id="tại-sao-lại-trừ">Tại sao lại trừ?</h2>
<p>Khi chúng ta cộng <span class="math inline">\(P(A)\)</span> và <span
class="math inline">\(P(B)\)</span> , chúng ta đếm các kết quả thuộc cả
A và B hai lần. Trừ đi <span class="math inline">\(P(A \cap B)\)</span>
sẽ loại bỏ việc đếm trùng.</p>
<h2 id="ví-dụ-1-tổng-của-hai-con-xúc-xắc">Ví dụ 1 Tổng của hai con xúc
xắc</h2>
<p>Lắc hai con xúc xắc sáu mặt công bằng. Gọi</p>
<p>• A = tổng là 7,</p>
<p>● B = tổng là 11.</p>
<p>Không gian mẫu có <span class="math inline">\(6 \times 6 =
36\)</span> kết quả có cùng khả năng xảy ra.</p>
<p><span
class="math display">\[P(A)=\frac{6}{36}=\frac{1}{6}\quad(pairs:(1,6),(2,5),(3,4),(4,3),(5,2),(6,1)),\]</span></p>
<p><span
class="math display">\[P(B)=\frac{2}{36}=\frac{1}{18}\quad(pairs:(5,6),(6,5)).\]</span></p>
<p>Vì một lần lắc không thể đồng thời cho tổng là 7 và 11, <span
class="math inline">\(A \cap B = \varnothing\)</span> và</p>
<p><span class="math display">\[P(A\cup
B)=P(A)+P(B)=\frac{1}{6}+\frac{1}{18}=\frac{3}{18}+\frac{1}{18}=\frac{4}{18}=\frac{2}{9}.\]</span></p>
<p>Do đó, xác suất để có được tổng là 7 hoặc 11 là <span
class="math inline">\(\frac{2}{9}\)</span> .</p>
<h2 id="ví-dụ-2-các-sự-kiện-chồng-lấn">Ví dụ 2 Các sự kiện chồng
lấn</h2>
<p>Lắc hai con xúc xắc lại. Định nghĩa</p>
<p>• C = tổng là chẵn,</p>
<p>• D = tổng lớn hơn 8.</p>
<p>Chúng ta tính toán mỗi xác suất:</p>
<p><span class="math display">\[P(C)=\frac{18}{36}=\frac{1}{2}\quad(nửa
số 36 kết quả cho tổng chẵn),\]</span></p>
<p><span
class="math display">\[P(D)=\frac{10}{36}=\frac{5}{18}\quad(tổng
9,10,11,12\text{:}4+3+2+1=10kết quả).\]</span></p>
<p>Giao của <span class="math inline">\(C \cap D\)</span> gồm các tổng
chẵn lớn hơn 8, tức là 10 và 12.</p>
<p><span class="math display">\[P(C\cap
D)=\frac{3+1}{36}=\frac{4}{36}=\frac{1}{9}.\]</span></p>
<p>Bây giờ áp dụng quy tắc cộng:</p>
<p><span class="math display">\[\begin{aligned}P(C\cup
D)&amp;=P(C)+P(D)-P(C\cap
D)\\&amp;=\frac{1}{2}+\frac{5}{18}-\frac{1}{9}\\&amp;=\frac{9}{18}+\frac{5}{18}-\frac{2}{18}\\&amp;=\frac{12}{18}\\&amp;=\frac{2}{3}.\end{aligned}\]</span></p>
<p>Vậy xác suất để có tổng chẵn hoặc tổng lớn hơn 8 là <span
class="math inline">\(\frac{2}{3}\)</span> .</p>
<h2 id="bài-tập-luyện-tập">Bài Tập Luyện Tập</h2>
<ol type="1">
<li><p>Bài toán 1: Một con bài được rút từ bộ bài 52 con bài tiêu chuẩn.
Gọi A là con bài là cơ và B là con bài là con bài (J, Q, K). Tìm <span
class="math inline">\(P(A \cup B)\)</span> .</p></li>
<li><p>Bài toán 2: Trong một lớp học có 40 học sinh, 22 học toán, 18 học
vật lý, và 9 học cả hai môn. Xác suất để một học sinh được chọn ngẫu
nhiên học toán hoặc vật lý là bao nhiêu?</p></li>
<li><p>Bài toán 3: Ba đồng xu được tung. Gọi <span
class="math inline">\(E\)</span> là ít nhất một mặt ngửa xuất hiện và
<span class="math inline">\(F\)</span> là chính xác hai mặt sấp xuất
hiện. Tính <span class="math inline">\(P(E \cup F)\)</span> .</p></li>
</ol>
<h2 id="giải-pháp">Giải Pháp</h2>
<ol type="1">
<li>Có 13 con cơ và 12 con bài. Ba con bài là cơ <span
class="math inline">\((J\heartsuit, Q\heartsuit, K\heartsuit)\)</span>
được tính hai lần, do đó</li>
</ol>
<p><span class="math display">\[P(A)=\frac{13}{52}=\frac{1}{4},\qquad
P(B)=\frac{12}{52}=\frac{3}{13},\qquad P(A\cap
B)=\frac{3}{52}.\]</span></p>
<p>Do đó</p>
<p><span class="math display">\[P(A\cup
B)=\frac{1}{4}+\frac{3}{13}-\frac{3}{52}=\frac{13}{52}+\frac{12}{52}-\frac{3}{52}=\frac{22}{52}=\frac{11}{26}.\]</span></p>
<ol start="2" type="1">
<li>Sử dụng quy tắc cộng cho các sự kiện học toán học (M) và học vật lý
(P):</li>
</ol>
<p><span class="math display">\[P(M)=\frac{22}{40}=\frac{11}{20},\quad
P(P)=\frac{18}{40}=\frac{9}{20},\quad P(M\cap
P)=\frac{9}{40}.\]</span></p>
<p>Do đó</p>
<p><span class="math display">\[P(M\cup
P)=\frac{11}{20}+\frac{9}{20}-\frac{9}{40}=\frac{20}{20}-\frac{9}{40}=1-\frac{9}{40}=\frac{31}{40}.\]</span></p>
<ol start="3" type="1">
<li>Không gian mẫu cho ba lần tung đồng xu có <span
class="math inline">\(2^{3} = 8\)</span> kết quả có thể xảy ra như
nhau.</li>
</ol>
<p>• E = ít nhất một mặt ngửa. Kết quả duy nhất không thuộc E là TTT, do
đó <span class="math inline">\(P(E) = 1 - \frac{1}{8} =
\frac{7}{8}\)</span> .</p>
<ul>
<li><p>F = chính xác hai mặt sấp. Các kết quả thuận lợi là TTH, THT,
HTT, do đó <span class="math inline">\(P(F) = \frac{3}{8}\)</span>
.</p></li>
<li><p><span class="math inline">\(E \cap F = \text{kết quả thỏa mãn cả
hai: chính xác hai mặt sấp (đã đảm bảo ít nhất một mặt ngửa). Do đó } E
\cap F = F \text{ và } P(E \cap F) = \frac{3}{8}.\)</span></p></li>
</ul>
<p>Áp dụng quy tắc:</p>
<p><span class="math display">\[P(E\cup F)=P(E)+P(F)-P(E\cap
F)=\frac{7}{8}+\frac{3}{8}-\frac{3}{8}=\frac{7}{8}.\]</span></p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Tích Của Các Xác Suất Của Hai Sự Kiện Độc Lập (Lớp 11)', 'Quy tắc nhân cho biến cố độc lập P(A∩B) = P(A)P(B).', '', 'article', '11', '<h1 id="tích-của-các-xác-suất-của-hai-sự-kiện-độc-lập">Tích Của Các Xác
Suất Của Hai Sự Kiện Độc Lập</h1>
<h2 id="định-nghĩa-của-các-sự-kiện-độc-lập">Định Nghĩa Của Các Sự Kiện
Độc Lập</h2>
<p>Hai sự kiện A và B được gọi là độc lập nếu việc xảy ra của một không
ảnh hưởng đến xác suất xảy ra của sự kiện kia. Về mặt toán học điều này
được biểu diễn như sau</p>
<p><span class="math display">\[P(A\cap B)=P(A)P(B).\]</span></p>
<p>Phương trình (1) thường được gọi là quy tắc nhân cho các sự kiện độc
lập. Từ định nghĩa này ta cũng thu được các xác suất có điều kiện</p>
<p><span class="math display">\[P(A\mid B)=\frac{P(A\cap
B)}{P(B)}=\frac{P(A)P(B)}{P(B)}=P(A),\]</span></p>
<p><span class="math display">\[P(B\mid A)=\frac{P(A\cap
B)}{P(A)}=\frac{P(A)P(B)}{P(A)}=P(B),\]</span></p>
<p>với điều kiện <span class="math inline">\(P(A) &gt; 0\)</span> và
<span class="math inline">\(P(B) &gt; 0\)</span> . Do đó, với các sự
kiện độc lập,</p>
<p><span class="math display">\[P(A\mid B)=P(A)\qquad và\qquad P(B\mid
A)=P(B).\]</span></p>
<h2 id="tại-sao-quy-tắc-nhân-hoạt-động">Tại Sao Quy Tắc Nhân Hoạt
Động</h2>
<p>Thực tế, nếu A và B là các sự kiện độc lập, việc biết rằng B xảy ra
không thay đổi khả năng xảy ra của A. Do đó, tỉ lệ kết quả mà cả hai
cùng xảy ra là đơn giản là tỉ lệ kết quả mà A xảy ra nhân với tỉ lệ kết
quả mà B xảy ra.</p>
<h2 id="ví-dụ">Ví Dụ</h2>
<ol type="1">
<li>Đồng tiền và xúc xắc. Lật một đồng xu công bằng (A: mặt ngửa) và
gieo một xúc xắc sáu mặt công bằng (B: hiển thị số 4).</li>
</ol>
<p><span class="math display">\[P(A)=\frac{1}{2},\qquad
P(B)=\frac{1}{6}.\]</span></p>
<p>Vì việc lật đồng xu không ảnh hưởng đến việc gieo xúc xắc, các sự
kiện là độc lập và</p>
<p><span class="math display">\[P(A\cap
B)=P(A)P(B)=\frac{1}{2}\cdot\frac{1}{6}=\frac{1}{12}.\]</span></p>
<p>Thật vậy, trong các kết quả có thể xảy ra 12 kết quả đều khả thi
<span class="math inline">\(\{H1, H2, \ldots, H6, T1, \ldots,
T6\}\)</span> chỉ có H4 thỏa mãn cả hai.</p>
<ol start="2" type="1">
<li>Lấy bài từ bộ bài với thay thế. Từ một bộ bài chuẩn gồm 52 lá bài
rút hai lá bài với thay thế. Gọi A: lá bài đầu tiên là cây rô, B: lá bài
thứ hai là con king.</li>
</ol>
<p><span class="math display">\[P(A)=\frac{13}{52}=\frac{1}{4},\qquad
P(B)=\frac{4}{52}=\frac{1}{13}.\]</span></p>
<p>Vì lá bài đầu tiên bị thay thế, thành phần của bộ bài cho lần rút
tiếp theo không thay đổi, do đó A và B là độc lập.</p>
<p><span class="math display">\[P(A\cap
B)=\frac{1}{4}\cdot\frac{1}{13}=\frac{1}{52}.\]</span></p>
<p>Điều này trùng với đếm trực tiếp: có 13 lá bài cơ và 4 quân vua, cho
<span class="math inline">\(13 \cdot 4 = 52\)</span> cặp có thứ tự thuận
lợi trong tổng số <span class="math inline">\(52 \cdot 52\)</span> .</p>
<h2 id="bài-tập-thực-hành">Bài tập thực hành</h2>
<ol type="1">
<li><p>Nếu P(A) = 0.27 và P(B) = 0.43 và A và B là độc lập, hãy tìm P(A
∩ B).</p></li>
<li><p>Cho <span class="math inline">\(P(A) = 0.55\)</span> , <span
class="math inline">\(P(B) = 0.62\)</span> và <span
class="math inline">\(P(A \cap B) = 0.341\)</span> , hãy xác định xem A
và B có độc lập hay không.</p></li>
<li><p>Một túi chứa 8 viên bi đỏ và 12 viên bi xanh. Hai viên bi được
rút ra với thay thế. Gọi A là viên bi đầu tiên là đỏ và B là viên bi thứ
hai là xanh. Tính <span class="math inline">\(P(A \cap B)\)</span>
.</p></li>
<li><p>Trong một cuộc khảo sát, 60% học sinh thích toán học (M) và 40%
thích vật lý (P). Giả sử sở thích là độc lập, tỷ lệ phần trăm học sinh
thích cả hai môn là bao nhiêu?</p></li>
</ol>
<h2 id="giải-pháp">Giải pháp</h2>
<ol type="1">
<li>Sử dụng quy tắc nhân (1):</li>
</ol>
<p><span class="math display">\[P(A\cap
B)=P(A)P(B)=0.27\times0.43=0.1161.\]</span></p>
<p>Do đó <span class="math inline">\(P(A \cap B) = 0.1161\)</span> .</p>
<ol start="2" type="1">
<li>Tính tích của xác suất biên:</li>
</ol>
<p><span
class="math display">\[P(A)P(B)=0.55\times0.62=0.341.\]</span></p>
<p>Vì kết quả này bằng với xác suất đã cho <span
class="math inline">\(P(A \cap B) = 0.341\)</span> , điều kiện (1) được
thỏa mãn; do đó A và B là độc lập.</p>
<ol start="3" type="1">
<li>Lần rút đầu tiên: <span class="math inline">\(P(A) = \frac{8}{8+12}
= \frac{8}{20} = 0.4\)</span> . Lần rút thứ hai (với thay thế): thành
phần không thay đổi, do đó <span class="math inline">\(P(B) =
\frac{12}{20} = 0.6\)</span> . Theo tính độc lập,</li>
</ol>
<p><span class="math display">\[P(A\cap
B)=0.4\times0.6=0.24.\]</span></p>
<p>Vì vậy, có 24% khả năng rút được một viên bi đỏ rồi một viên bi
xanh.</p>
<ol start="4" type="1">
<li>Chuyển phần trăm thành số thập phân: <span
class="math inline">\(P(M) = 0.60\)</span> , <span
class="math inline">\(P(P) = 0.40\)</span> . Giả sử độc lập,</li>
</ol>
<p><span class="math display">\[P(M\cap
P)=0.60\times0.40=0.24.\]</span></p>
<p>Do đó 24% học sinh thích cả toán học và vật lý.</p>
<h2 id="điểm-tóm-tắt">Điểm Tóm Tắt</h2>
<p>● Đối với các sự kiện độc lập, xác suất đồng thời là tích của các xác
suất riêng lẻ: <span class="math inline">\(P(A \cap B) =
P(A)P(B)\)</span> .</p>
<ul>
<li>Quy tắc nhân suy ra trực tiếp từ định nghĩa của sự độc lập và có thể
được sử dụng để kiểm tra sự độc lập: nếu <span class="math inline">\(P(A
\cap và B) \stackrel{?}{=} P(A)P(B)\)</span> đúng, các sự kiện là độc
lập.</li>
</ul>
<p>● Khi lấy mẫu có hoàn lại, các lần rút tiếp theo là độc lập; không có
hoàn lại thì chúng thường không độc lập.</p>
');