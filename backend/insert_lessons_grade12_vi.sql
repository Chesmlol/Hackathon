-- Xoá bản ghi trùng tên (nếu re-run), rồi chèn lại 4 bài tiếng Việt Lớp 12 (đã dọn 'từ ngữ cảnh' và tiêu đề thừa)
DELETE FROM lessons WHERE title = 'Khoảng Biến Thiên và Khoảng Tứ Phân Vị (Lớp 12)';
DELETE FROM lessons WHERE title = 'Phương Sai và Độ Lệch Chuẩn (Lớp 12)';
DELETE FROM lessons WHERE title = 'Xác Suất Có Điều Kiện (Lớp 12)';
DELETE FROM lessons WHERE title = 'Công Thức Xác Suất Toàn Phần và Định Lý Bayes (Lớp 12)';

INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Khoảng Biến Thiên và Khoảng Tứ Phân Vị (Lớp 12)', 'Khoảng biến thiên và khoảng tứ phân vị.', '', 'article', '12', '<h1 id="các-khoảng-biến-thể-và-khoảng-tứ-phân-vị">Các Khoảng Biến Thể và
Khoảng Tứ Phân Vị</h1>
<p>Đối Tượng Học Sinh: Lớp 12</p>
<h3 id="giới-thiệu">1. Giới Thiệu</h3>
<p>Trong thống kê, chúng ta thường cần một số duy nhất để cho biết dữ
liệu “rải rác” như thế nào. Hai trong số những thước đo phân tán phổ
biến nhất là:</p>
<ul>
<li><p>Phạm vi (Range): Hiệu giữa giá trị lớn nhất và nhỏ nhất.</p></li>
<li><p>Khoảng Tứ Phân Vị (IQR): Hiệu giữa tứ phân vị thứ ba ( <span
class="math inline">\(Q_{3}\)</span> ) và tứ phân vị thứ nhất ( <span
class="math inline">\(Q_{1}\)</span> ); nó đo lường sự rải rác của 50%
dữ liệu ở giữa.</p></li>
</ul>
<p>Cả hai đều dễ tính toán, nhưng chúng có độ nhạy khác nhau đối với các
giá trị cực đoan (outliers). Hiểu rõ khi nào nên sử dụng từng thước đo
là cần thiết để diễn giải dữ liệu chính xác.</p>
<h3 id="định-nghĩa">2. Định Nghĩa</h3>
<p>Phạm Vi</p>
<p><span
class="math display">\[R=\max\{x_{i}\}-\min\{x_{i}\}.\]</span></p>
<p>Tứ Phân Vị Thứ Nhất <span class="math inline">\((Q_{1})\)</span> :
Giá trị dưới đó 25% dữ liệu nằm. Tương đương, là trung vị của nửa dưới
dữ liệu (trừ trung vị tổng thể nếu n lẻ).</p>
<p>Tứ Phân Vị Thứ Ba <span class="math inline">\((Q_{3})\)</span> : Giá
trị dưới đó 75% dữ liệu nằm. Tương đương, là trung vị của nửa trên dữ
liệu.</p>
<p>Khoảng Tứ Phân Vị (IQR)</p>
<p><span class="math display">\[IQR=Q_{3}-Q_{1}.\]</span></p>
<h3 id="tính-chất">3. Tính Chất</h3>
<ol type="1">
<li><p>Phạm vi chỉ sử dụng hai quan sát cực đoan; do đó nó rất nhạy với
ngoại lệ.</p></li>
<li><p>Khoảng Tứ Phân Vị sử dụng 50% dữ liệu ở giữa; nó chống chịu tốt
với một số lượng vừa phải các giá trị cực đoan.</p></li>
<li><p>Cả hai thước đo đều không âm, và chúng bằng không chỉ khi tất cả
quan sát giống nhau.</p></li>
<li><p>Đối với phân phối đối xứng, trung vị nằm giữa <span
class="math inline">\(Q_{1}\)</span> và <span
class="math inline">\(Q_{3}\)</span> : Trung vị <span
class="math inline">\(\approx (Q_{1} + Q_{3})/2\)</span> .</p></li>
</ol>
<h3 id="tính-tứ-phân-vị-bước-nhảy">4. Tính Tứ Phân Vị Bước Nhảy</h3>
<p>Cho một tập dữ liệu đã sắp xếp <span class="math inline">\(x_{(1)}
\leq x_{(2)} \leq \cdots \leq x_{(n)}\)</span> :</p>
<ol type="1">
<li><p>Tìm trung vị (vị trí <span class="math inline">\((n+1)/2\)</span>
). Chia dữ liệu thành nửa dưới và nửa trên.</p></li>
<li><p>Nếu n lẻ, loại bỏ trung vị khỏi cả hai nửa; nếu n chẵn, chỉ cần
chia ở giữa.</p></li>
<li><p><span class="math inline">\(Q_{1}\)</span> = trung vị của nửa
dưới.</p></li>
<li><p><span class="math inline">\(Q_{3}\)</span> = trung vị của nửa
trên.</p></li>
</ol>
<p>Ví dụ: Dữ liệu chiều cao (trong cm) cho một mẫu:</p>
<p>159, 162, 165, 168, 170, 172.</p>
<p>Ở đây <span class="math inline">\(n=6\)</span> (chẵn). Nửa dưới =
{159,162,165}, nửa trên = {168,170,172}.</p>
<p><span
class="math display">\[Q_{1}=\mathrm{median~of~lower~half}=162,\qquad
Q_{3}=\mathrm{median~of~upper~half}=170.\]</span></p>
<p>Do đó</p>
<p><span
class="math display">\[\mathrm{IQR}=Q_{3}-Q_{1}=170-162=8\mathrm{~cm}.\]</span></p>
<p>(Với <span class="math inline">\(Q_{1}=9.5\)</span> , <span
class="math inline">\(Q_{3}=19.5\)</span> cho một tập dữ liệu khác, quy
trình tương tự.)</p>
<h3 id="phát-hiện-giá-trị-ngoại-lai-bằng-iqr">5. Phát hiện giá trị ngoại
lai bằng IQR</h3>
<p>Một quy tắc phổ biến (Tukey’s fences) xác định các quan sát có thể là
giá trị ngoại lai là các quan sát nằm ngoài</p>
<p><span
class="math display">\[\left[\begin{array}{c}{Q_{1}-1.5\mathrm{I Q
R},}\end{array}\right.Q_{3}+1.5\mathrm{I Q R}\left.\right].\]</span></p>
<p>Ví dụ: Đối với một tập dữ liệu với <span class="math inline">\(Q_1 =
135\)</span> mg, <span class="math inline">\(Q_3 = 205\)</span> mg,</p>
<p><span
class="math display">\[\mathrm{IQR}=205-135=70\mathrm{mg},\]</span></p>
<p>Giới hạn dưới = 135 - 1.5 <span class="math inline">\(\times\)</span>
70 = 30 mg, Giới hạn trên = 205 + 1.5 <span
class="math inline">\(\times\)</span> 70 = 310 mg.</p>
<p>Các quan sát &lt;30 mg hoặc &gt;310 mg được đánh dấu là giá trị ngoại
lai. Trong dữ liệu được cho, 0 mg và 340 mg thỏa mãn điều kiện này.</p>
<h3 id="mối-quan-hệ-giữa-phạm-vi-và-iqr">6. Mối quan hệ giữa phạm vi và
IQR</h3>
<p>Mặc dù phạm vi phản ánh sự phân tán tổng thể, IQR phản ánh sự phân
tán của khối trung tâm. Do đó:</p>
<p>• Nếu dữ liệu chứa các giá trị ngoại lai cực đoan, phạm vi sẽ lớn hơn
đáng kể so với IQR.</p>
<ul>
<li>Đối với một tập dữ liệu không có giá trị ngoại lai, hai chỉ số này
thường có độ lớn tương đương (mặc dù phạm vi vẫn <span
class="math inline">\(\geq\)</span> IQR).</li>
</ul>
<p>Minh họa:</p>
<p>Nhóm 1: Phạm vi = 2, Phạm vi = 4 <span
class="math inline">\(\Rightarrow\)</span> Nhóm 1 đồng đều hơn (phân tán
nhỏ hơn).</p>
<p>Dữ liệu chiều cao: Phạm vi = 172 - 159 = 13 cm, IQR = 10 (từ một ví
dụ khác).</p>
<p>Ở đây, phạm vi (13 cm) vượt qua IQR (10 cm) vì các giá trị cực trị
(159 cm và 172 cm) tạo thêm sự phân tán ngoài khối giữa 50%.</p>
<h3 id="ví-dụ-được-giải">7. Ví dụ được giải</h3>
<p>Ví dụ 1. Một mẫu gồm 9 điểm số thi (trên 100) là:</p>
<p><span class="math display">\[\begin{array}{l}
55,~60,~62,~68,~70,~73,~78,~85,~92. \end{array}\]</span></p>
<p>Tìm phạm vi, <span class="math inline">\(Q_{1}\)</span> , <span
class="math inline">\(Q_{3}\)</span> , và IQR.</p>
<p>Giải pháp. Dữ liệu đã được sắp xếp; n = 9.</p>
<p>• Phạm vi = max - min = 92 - 55 = 37.</p>
<p>• Trung vị (giá trị thứ 5) = 70.</p>
<p>• Nửa dưới = <span class="math inline">\(\{55,60,62,68\} \rightarrow
Q_{1} = trung vị của nửa dưới = (60+62)/2 = 61\)</span> .</p>
<p>• Nửa trên = <span class="math inline">\(\{73, 78, 85, 92\}
\rightarrow Q_{3} = trung vị của nửa trên = (78 + 85)/2 = 81.5\)</span>
.</p>
<p>IQR = Q_{3} - Q_{1} = 81.5 - 61 = 20.5.</p>
<p>Ví dụ 2. Sử dụng dữ liệu thuế thuốc lá: 12 trong số 51 thành phố có
thuế cao hơn 36 đơn vị. Giả sử các giá trị thuế (theo đơn vị) đã được
sắp xếp như thế nào đó mà <span class="math inline">\(Q_{1}=36\)</span>
và <span class="math inline">\(Q_{3}=100\)</span> . Tính phạm vi và IQR
nếu giá trị thuế thấp nhất quan sát được là 0 và cao nhất là 120.</p>
<p>Giải pháp.</p>
<p>• Phạm vi = 120 - 0 = 120.</p>
<p>• Cho <span class="math inline">\(Q_1 = 36\)</span> , <span
class="math inline">\(Q_3 = 100 \to IQR = 100 - 36 = 64\)</span> .</p>
<p>Do đó, 50% giá trị giữa của các thành phố có thuế nằm trong khoảng 36
đến 100 đơn vị, trong khi mẫu toàn bộ trải dài từ 0 đến 120 đơn vị.</p>
<h3 id="bài-tập-luyện-tập">8. Bài Tập Luyện Tập</h3>
<ol type="1">
<li>Dữ liệu sau đây đại diện cho số giờ sinh viên đã dành để học cho một
kỳ thi cuối (trong giờ):</li>
</ol>
<p>2, 3, 3, 4, 5, 5, 6, 7, 8, 9, 10, 12.</p>
<p>Tính khoảng biến thiên, <span class="math inline">\(Q_{1}\)</span> ,
<span class="math inline">\(Q_{3}\)</span> , và IQR. Nhận diện bất kỳ
giá trị ngoại lệ nào bằng quy tắc <span
class="math inline">\(1.5\times\mathrm{IQR}\)</span> .</p>
<ol start="2" type="1">
<li>Một nhà sinh học đã đo độ dài (trong mm) của 15 con cá:</li>
</ol>
<p>45, 48, 50, 52, 53, 55, 57, 58, 60, 62, 63, 65, 68, 70, 73.</p>
<p>Tìm khoảng biến thiên và IQR. Nhận xét xem chỉ số nào phản ánh tốt
hơn về sự phân tán thông thường của dữ liệu.</p>
<ol start="3" type="1">
<li>Xét bộ dữ liệu:</li>
</ol>
<p>0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9.</p>
<p>Tính khoảng biến thiên và IQR. Giải thích tại sao IQR bằng không hoặc
không bằng không trong trường hợp này.</p>
<h3 id="giải-pháp-cho-bài-tập-luyện-tập">9. Giải Pháp Cho Bài Tập Luyện
Tập</h3>
<p>Giải pháp (Bài 1). Dữ liệu đã được sắp xếp (đã có). n = 12.</p>
<p>• Khoảng biến thiên = 12 - 2 = 10.</p>
<p>• Trung vị = trung bình của giá trị thứ 6 và thứ 7 = <span
class="math inline">\((5+6)/2 = 5.5\)</span> .</p>
<p>• Nửa dưới = <span class="math inline">\(\{2, 3, 3, 4, 5,
5\}\)</span> <span class="math inline">\(\rightarrow Q_{1} = (3 + 4)/2 =
3.5\)</span> .</p>
<p>• Nửa trên = <span class="math inline">\(\{6,7,8,9,10,12\}
\rightarrow Q_{3} = (8+9)/2 = 8.5\)</span> .</p>
<p>IQR=8.5-3.5=5.</p>
<p>Khoảng ngoại lệ:</p>
<p><span class="math display">\[Lower=Q_{1}-1.5\cdot
IQR=3.5-7.5=-4,\qquad Upper=Q_{3}+1.5\cdot IQR=8.5+7.5=16.\]</span></p>
<p>Tất cả các quan sát nằm trong khoảng <span
class="math inline">\([-4,16]\)</span> , do đó không có giá trị ngoại
lệ.</p>
<p>Giải pháp (Bài 2). n = 15.</p>
<p>• Khoảng biến thiên = 73 - 45 = 28 mm.</p>
<p>• Trung vị (giá trị thứ 8) = 58 mm.</p>
<p>• Nửa dưới = 7 giá trị đầu tiên → trung vị của {45, 48, 50, 52, 53,
55, 57} = 52 mm → <span class="math inline">\(Q_{1}\)</span> = 52.</p>
<p>• Nửa trên = 7 giá trị cuối cùng → trung vị của {60, 62, 63, 65, 68,
70, 73} = 65 mm → <span class="math inline">\(Q_{3}\)</span> = 65.</p>
<p>IQR=65-52=13 mm.</p>
<p>Khoảng biến thiên (28 mm) bị ảnh hưởng bởi cá nhỏ nhất (45 mm) và cá
lớn nhất (73 mm). IQR (13 mm) phản ánh sự phân tán của 50% dữ liệu trung
tâm và ít bị ảnh hưởng bởi những giá trị cực đoan này, do đó nó phản ánh
tốt hơn sự phân tán thông thường cho phần lớn các con cá.</p>
<p>Giải pháp (Bài 3). Dữ liệu đối xứng và mỗi số nguyên từ 0 đến 9 đều
xuất hiện hai lần.</p>
<p>• Khoảng biến thiên = 9 - 0 = 9.</p>
<p>• <span class="math inline">\(n = 20\)</span> (chẵn). Trung vị =
trung bình của <span class="math inline">\(10\)</span> giá trị thứ <span
class="math inline">\(10\)</span> và thứ <span
class="math inline">\(11\)</span> = <span class="math inline">\((4 +
5)/2 = 4.5\)</span> .</p>
<p>• Nửa dưới = 10 giá trị đầu tiên <span
class="math inline">\(\{0,0,1,1,2,2,3,3,4,4\}\)</span> <span
class="math inline">\(\rightarrow\)</span> trung vị = <span
class="math inline">\((2+3)/2 = 2.5 \rightarrow Q_{1} = 2.5\)</span>
.</p>
<p>• Nửa trên = 10 giá trị cuối cùng <span class="math inline">\(\{5, 5,
6, 6, 7, 7, 8, 8, 9, 9\}\)</span> <span
class="math inline">\(\rightarrow\)</span> trung vị = <span
class="math inline">\((7 + 8)/2 = 7.5 \rightarrow Q_{3} = 7.5\)</span>
.</p>
<p>IQR=7.5-2.5=5.</p>
<p>IQR không bằng không vì 50% dữ liệu ở giữa (phân vị thứ 2 và thứ 3)
vẫn có sự biến thiên; chỉ khi tất cả dữ liệu đều giống nhau thì cả
khoảng biến thiên và IQR mới bằng không.</p>
<h3 id="tóm-tắt">10. Tóm tắt</h3>
<p>• Phạm vi = giá trị lớn nhất - giá trị nhỏ nhất. Đơn giản, nhưng rất
nhạy cảm với các giá trị ngoại lai.</p>
<p>• Độ lệch tứ phân vị (IQR) = <span class="math inline">\(Q_{3} -
Q_{1}\)</span> . Đo lường sự phân tán của 50% dữ liệu trung tâm; bền
vững trước các giá trị ngoại lai.</p>
<p>• Phát hiện giá trị ngoại lai: bất kỳ quan sát nào nằm ngoài khoảng
<span class="math inline">\([Q_{1}-1.5\mathrm{IQR},
Q_{3}+1.5\mathrm{IQR}]\)</span> được coi là một giá trị tiềm năng ngoại
lai.</p>
<ul>
<li>Với dữ liệu đối xứng và không có giá trị ngoại lai, phạm vi và IQR
thường có kích thước so sánh; ngược lại, phạm vi sẽ vượt qua IQR.</li>
</ul>
<p>Hiểu rõ cả hai chỉ số này giúp bạn mô tả chính xác độ biến thiên của
dữ liệu và chọn được thống kê tóm tắt phù hợp tùy theo sự hiện diện của
các giá trị cực trị.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Phương Sai và Độ Lệch Chuẩn (Lớp 12)', 'Phương sai và độ lệch chuẩn — số đo độ phân tán của dữ liệu.', '', 'article', '12', '<h1 id="phương-sai-và-độ-lệch-chuẩn">Phương sai và độ lệch chuẩn</h1>
<h2 id="độ-lệch-chuẩn-là-gì">1 Độ lệch chuẩn là gì?</h2>
<p>Độ lệch chuẩn đo lường mức độ phân tán các giá trị của một biến ngẫu
nhiên (hoặc một tập dữ liệu) quanh giá trị trung bình của nó. Với một
mẫu <span class="math inline">\(\{X_{1}, \ldots, X_{n}\}\)</span> độ
lệch chuẩn mẫu không thiên lệch là</p>
<p><span
class="math display">\[S^{2}=\frac{1}{n-1}\sum_{i=1}^{n}(X_{i}-\bar{X})^{2},\qquad\mathrm{w
h e r e~}\bar{X}=\frac{1}{n}\sum_{i=1}^{n}X_{i}.\]</span></p>
<p>Mẫu số <span class="math inline">\(n-1\)</span> (thay vì <span
class="math inline">\(n\)</span> ) làm cho <span
class="math inline">\(S^{2}\)</span> trở thành ước lượng không thiên
lệch của độ lệch chuẩn tổng thể <span
class="math inline">\(\sigma^{2}\)</span> .</p>
<h2 id="độ-lệch-chuẩn-mẫu">2 Độ lệch chuẩn mẫu</h2>
<p>Độ lệch chuẩn mẫu là căn bậc hai của phương sai:</p>
<p><span
class="math display">\[S=\sqrt{S^{2}}=\sqrt{\frac{1}{n-1}\sum_{i=1}^{n}(X_{i}-\bar{X})^{2}}.\]</span></p>
<p>Nó có cùng đơn vị với dữ liệu gốc, điều này làm cho nó dễ diễn giải
hơn so với phương sai (nào có đơn vị là bình phương).</p>
<h2 id="công-thức-cho-dữ-liệu-nhóm">3 Công thức cho dữ liệu nhóm</h2>
<p>Khi dữ liệu được trình bày dưới dạng bảng tần số với các giá trị
riêng biệt <span class="math inline">\(x_i\)</span> xuất hiện <span
class="math inline">\(f_i\)</span> lần ( <span class="math inline">\(N =
\sum f_i\)</span> ),</p>
<p><span class="math display">\[\bar{x}=\frac{\sum f_{i}x_{i}}{N},\qquad
s^{2}=\frac{\sum f_{i}(x_{i}-\bar{x})^{2}}{N-1}.\]</span></p>
<p>Những công thức này được suy trực tiếp từ định nghĩa của phương sai
bằng cách xem mỗi quan sát là lặp lại <span
class="math inline">\(f_{i}\)</span> lần.</p>
<h2 id="tính-chất">4 Tính chất</h2>
<p>• <span class="math inline">\(\mathrm{Var}(aX + b) =
a^{2}\mathrm{Var}(X)\)</span> với các hằng số <span
class="math inline">\(a, b\)</span> .</p>
<p>• Nếu <span class="math inline">\(X\)</span> và <span
class="math inline">\(Y\)</span> độc lập, <span
class="math inline">\(\mathrm{Var}(X + Y) = \mathrm{Var}(X) +
\mathrm{Var}(Y)\)</span> .</p>
<p>• <span class="math inline">\(\mathrm{Var}(X) = E[X^2] -
(E[X])^2\)</span> .</p>
<h2 id="ví-dụ">5 Ví dụ</h2>
<h3 id="ví-dụ-1-cân-nặng-túi">5.1 Ví dụ 1: Cân nặng túi</h3>
<p>Từ một mẫu gồm 20 túi, trung bình mẫu cân nặng là <span
class="math inline">\(\bar{X} = 48\)</span> kg và phương sai mẫu không
thiên là</p>
<p><span class="math display">\[S^{2}=(0.5\ kg)^{2}=0.25\
kg^{2}.\]</span></p>
<p>Do đó, độ lệch chuẩn mẫu là</p>
<p><span class="math display">\[S=\sqrt{0.25}=0.5\ kg.\]</span></p>
<p>Giải thích: Cân nặng túi điển hình lệch khỏi trung bình khoảng nửa
kilogram.</p>
<h3 id="ví-dụ-2-lắc-xúc-xắc-phân-phối-đều-rời-rạc">5.2 Ví dụ 2: Lắc xúc
xắc (Phân phối đều rời rạc)</h3>
<p>Với một xúc xắc sáu mặt công bằng, <span class="math inline">\(X \in
\{1,2,3,4,5,6\}\)</span> với <span class="math inline">\(P(X = k) =
\frac{1}{6}\)</span> .</p>
<p><span
class="math display">\[E[X]=\frac{1+2+3+4+5+6}{6}=3.5,\]</span></p>
<p><span
class="math display">\[E[X^{2}]=\frac{1^{2}+2^{2}+3^{2}+4^{2}+5^{2}+6^{2}}{6}=\frac{91}{6}\approx15.1667,\]</span></p>
<p><span
class="math display">\[\mathrm{Var}(X)=E[X^{2}]-(E[X])^{2}=\frac{91}{6}-\left(\frac{7}{2}\right)^{2}=\frac{35}{12}\approx2.9167.\]</span></p>
<p>Do đó, độ lệch chuẩn là</p>
<p><span
class="math display">\[\sigma=\sqrt{\frac{35}{12}}\approx1.708.\]</span></p>
<h3 id="ví-dụ-3-kiểm-định-bằng-phương-sai-kiểm-định-f">5.3 Ví dụ 3: Kiểm
định bằng phương sai (Kiểm định F)</h3>
<p>Hai mẫu độc lập:</p>
<p>Trẻ trai: n = 25, <span class="math inline">\(S_{X}^{2} =
40266.67\)</span> .</p>
<p>Trẻ gái: m = 28, <span class="math inline">\(S_{Y}^{2} =
37407.41\)</span> .</p>
<p>Thống kê kiểm định cho sự bằng nhau của phương sai là</p>
<p><span
class="math display">\[F=\frac{S_{X}^{2}}{S_{Y}^{2}}=1.076.\]</span></p>
<p>Với <span class="math inline">\(\alpha=0.05\)</span> , <span
class="math inline">\(df_{1}=24\)</span> , <span
class="math inline">\(df_{2}=27\)</span> , giá trị tới hạn là <span
class="math inline">\(F_{0.05}(24,27)=1.89\)</span> . Vì <span
class="math inline">\(1.076&lt;1.89\)</span> , chúng ta không bác bỏ
<span class="math inline">\(H_{0}\)</span> ; phương sai không khác biệt
đáng kể ở mức <span class="math inline">\(5\%\)</span> .</p>
<h3 id="ví-dụ-4-phương-pháp-chỉ-số-hộp-rỗng">5.4 Ví dụ 4: Phương pháp
chỉ số Hộp rỗng</h3>
<p>Đẩy 12 quả bóng độc lập và đều vào 7 hộp. Gọi <span
class="math inline">\(I_{j}\)</span> là chỉ số cho hộp j rỗng. Khi
đó</p>
<p><span
class="math display">\[P(I_{j}=1)=\left(1-\frac{1}{7}\right)^{12}=\left(\frac{6}{7}\right)^{12}.\]</span></p>
<p>Định nghĩa <span class="math inline">\(X = \sum_{j=1}^{7}
I_{j}\)</span> (tổng số hộp rỗng). Bởi vì các <span
class="math inline">\(I_{j}\)</span> phân bố giống nhau nhưng không độc
lập,</p>
<p><span
class="math display">\[E[X]=7\left(\frac{6}{7}\right)^{12}\approx7\cdot0.1122=0.7854.\]</span></p>
<p>Đối với phương sai, chúng ta cần các hiệp phương sai:</p>
<p><span class="math display">\[\mathrm{C o v}(I_{j},I_{k})=P(\mathrm{b
i n s}~j,k~\mathrm{b o t h}~\mathrm{e m p t
y})-E[I_{j}]E[I_{k}].\]</span></p>
<p>Cả hai hộp rỗng xảy ra khi mỗi quả bóng tránh hai hộp cụ thể:</p>
<p><span
class="math display">\[P(\mathrm{both~empty})=\left(1-\frac{2}{7}\right)^{12}=\left(\frac{5}{7}\right)^{12}.\]</span></p>
<p>Do đó</p>
<p><span class="math display">\[\mathrm{C o
v}(I_{j},I_{k})=\left(\frac{5}{7}\right)^{12}-\left[\left(\frac{6}{7}\right)^{12}\right]^{2}.\]</span></p>
<p>Cuối cùng</p>
<p><span
class="math display">\[\mathrm{Var}(X)=\sum_{j}\mathrm{Var}(I_{j})+2\sum_{j&lt;k}\mathrm{Cov}(I_{j},I_{k})=7p(1-p)+42\left[\left(\frac{5}{7}\right)^{12}-p^{2}\right],\]</span></p>
<p>trong đó <span
class="math inline">\(p=\left(\frac{6}{7}\right)^{12}\)</span> . Tính
toán số học cho kết quả <span
class="math inline">\(\mathrm{Var}(X)\approx0.61\)</span> và <span
class="math inline">\(\sigma_{X}\approx0.78\)</span> .</p>
<h2 id="bài-tập-luyện-tập">6 Bài Tập Luyện Tập</h2>
<ol type="1">
<li><p>Một mẫu gồm 15 học sinh có điểm số trên một bài kiểm tra với giá
trị trung bình là 78 và tổng các độ lệch bình phương là <span
class="math inline">\(\sum(X_i - \bar{X})^2 = 945\)</span> . Tính phương
sai mẫu không thiên lệch và độ lệch chuẩn.</p></li>
<li><p>Với biến ngẫu nhiên rời rạc Y có phân phối</p></li>
</ol>
<p><span class="math display">\[P(Y=0)=0.2,\ P(Y=2)=0.5,\
P(Y=4)=0.3,\]</span></p>
<p>tìm <span class="math inline">\(E[Y]\)</span> , <span
class="math inline">\(\mathrm{Var}(Y)\)</span> , và độ lệch chuẩn.</p>
<ol start="3" type="1">
<li>Sử dụng dữ liệu nhóm dưới đây, tính trung bình mẫu và phương sai
mẫu.</li>
</ol>
<table border="1" style="margin: auto; word-wrap: break-word;">
<tr>
<td style="text-align: center; word-wrap: break-word;">
Giá trị <span class="math inline">\(x_i\)</span>
</td>
<td style="text-align: center; word-wrap: break-word;">
Tần số <span class="math inline">\(f_i\)</span>
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
10
</td>
<td style="text-align: center; word-wrap: break-word;">
3
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
12
</td>
<td style="text-align: center; word-wrap: break-word;">
5
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
14
</td>
<td style="text-align: center; word-wrap: break-word;">
2
</td>
</tr>
<tr>
<td style="text-align: center; word-wrap: break-word;">
16
</td>
<td style="text-align: center; word-wrap: break-word;">
4
</td>
</tr>
</table>
<ol start="4" type="1">
<li>Giả sử chúng ta ném 20 quả bóng độc lập vào 10 thùng. Sử dụng biến
chỉ báo, tìm số lượng thùng trống kỳ vọng và phương sai của nó.</li>
</ol>
<h2 id="giải-pháp">7 Giải Pháp</h2>
<ol type="1">
<li>Phương sai:</li>
</ol>
<p><span
class="math display">\[s^{2}=\frac{1}{15-1}\cdot945=\frac{945}{14}=67.5.\]</span></p>
<p>Độ lệch chuẩn: <span class="math inline">\(s = \sqrt{67.5} \approx
8.215\)</span> .</p>
<ol start="2" type="1">
<li>Trước tiên tính giá trị trung bình:</li>
</ol>
<p><span
class="math display">\[E[Y]=0\cdot0.2+2\cdot0.5+4\cdot0.3=0+1+1.2=2.2.\]</span></p>
<p>Giá trị kỳ vọng của bình phương:</p>
<p><span
class="math display">\[E[Y^{2}]=0^{2}\cdot0.2+2^{2}\cdot0.5+4^{2}\cdot0.3=0+4\cdot0.5+16\cdot0.3=2+4.8=6.8.\]</span></p>
<p>Phương sai:</p>
<p><span
class="math display">\[\mathrm{Var}(Y)=E[Y^{2}]-(E[Y])^{2}=6.8-(2.2)^{2}=6.8-4.84=1.96.\]</span></p>
<p>Độ lệch chuẩn: <span class="math inline">\(\sigma = \sqrt{1.96} =
1.4\)</span> .</p>
<ol start="3" type="1">
<li>Tần số tổng cộng N = 3 + 5 + 2 + 4 = 14. Trung bình:</li>
</ol>
<p><span
class="math display">\[\bar{x}=\frac{3\cdot10+5\cdot12+2\cdot14+4\cdot16}{14}=\frac{30+60+28+64}{14}=\frac{182}{14}=13.\]</span></p>
<p>Tổng các độ lệch bình phương được trọng số:</p>
<p><span class="math display">\[\sum
f_{i}(x_{i}-\bar{x})^{2}=3(10-13)^{2}+5(12-13)^{2}+2(14-13)^{2}+4(16-13)^{2}=3\cdot9+5\cdot1+2\cdot1+4\cdot9=27+5+2+36=100+100=100\cdot2\times100=100\times100=100\times100=100\times100=10\]</span></p>
<p>Phương sai mẫu:</p>
<p><span
class="math display">\[s^{2}=\frac{70}{14-1}=\frac{70}{9}\approx7.78.\]</span></p>
<p>Độ lệch chuẩn: <span class="math inline">\(s = \sqrt{70/9} \approx
2.79\)</span> .</p>
<ol start="4" type="1">
<li>Gọi <span class="math inline">\(I_{j}\)</span> là chỉ số cho thùng
<span class="math inline">\(j\)</span> trống sau khi ném 20 quả bóng vào
10 thùng. Xác suất một thùng tránh tất cả các quả bóng:</li>
</ol>
<p><span
class="math display">\[p=\left(1-\frac{1}{10}\right)^{20}=\left(\frac{9}{10}\right)^{20}\approx0.1216.\]</span></p>
<p>Số lượng kỳ vọng các thùng trống:</p>
<p><span class="math display">\[E[X]=10p\approx1.216.\]</span></p>
<p>Đối với hai thùng khác nhau <span class="math inline">\(j \neq
k\)</span> , cả hai đều trống xảy ra khi mỗi quả bóng tránh hai
thùng:</p>
<p><span
class="math display">\[p_{2}=\left(1-\frac{2}{10}\right)^{20}=\left(\frac{8}{10}\right)^{20}\approx0.0115.\]</span></p>
<p>Phương sai hiệp phương sai:</p>
<p><span
class="math display">\[\mathrm{Cov}(I_{j},I_{k})=p_{2}-p^{2}\approx0.0115-0.0148=-0.0033.\]</span></p>
<p>Phương sai:</p>
<p><span
class="math display">\[\mathrm{Var}(X)=10p(1-p)+2\binom{10}{2}\mathrm{Cov}(I_{j},I_{k})\approx10(0.1216)(0.8784)+90(-0.0033)\approx1.067-0.297\approx0.77.\]</span></p>
<p>Độ lệch chuẩn: <span class="math inline">\(\sigma_{X} \approx
\sqrt{0.77} \approx 0.88\)</span> .</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Xác Suất Có Điều Kiện (Lớp 12)', 'Xác suất có điều kiện P(A|B).', '', 'article', '12', '<h1 id="xác-suất-có-điều-kiện">Xác suất có điều kiện</h1>
<h3 id="định-nghĩa">1. Định nghĩa</h3>
<p>Cho <span class="math inline">\(A\)</span> và <span
class="math inline">\(B\)</span> là hai sự kiện trong không gian mẫu
<span class="math inline">\(S\)</span> với <span
class="math inline">\(P(B) &gt; 0\)</span> . Xác suất có điều kiện của
<span class="math inline">\(A\)</span> cho <span
class="math inline">\(B\)</span> được ký hiệu là <span
class="math inline">\(P(A \mid B)\)</span> và được định nghĩa như
sau</p>
<p><span class="math display">\[P(A\mid B)=\frac{P(A\cap
B)}{P(B)}.\]</span></p>
<p>Nếu <span class="math inline">\(P(B) = 0\)</span> thì xác suất có
điều kiện không được định nghĩa.</p>
<h3 id="tính-chất-cơ-bản">2. Tính chất cơ bản</h3>
<p>• <span class="math inline">\(0 \leq P(A \mid B) \leq 1\)</span>
.</p>
<p><span class="math inline">\(P(B \mid B) = 1\)</span> .</p>
<p>• Nếu <span class="math inline">\(A\)</span> và <span
class="math inline">\(B\)</span> độc lập, thì <span
class="math inline">\(P(A \mid B) = P(A)\)</span> và <span
class="math inline">\(P(B \mid A) = P(B)\)</span> .</p>
<p>• Quy tắc nhân: <span class="math inline">\(P(A \cap B) = P(A)P(B
\mid A) = P(B)P(A \mid B)\)</span> .</p>
<h3 id="các-ví-dụ-minh-họa">3. Các ví dụ minh họa</h3>
<p>Ví dụ 1. Cho <span class="math inline">\(P(A) = 0.97\)</span> và
<span class="math inline">\(P(B \mid A) = 0.95\)</span> , tìm <span
class="math inline">\(P(A \cap B)\)</span> .</p>
<p><span class="math display">\[P(A\cap B)=P(A)\,P(B\mid
A)=0.97\times0.95=0.9215\approx0.92.\]</span></p>
<p>Ví dụ 2. Giả sử <span class="math inline">\(P(A)=0.30\)</span> và
<span class="math inline">\(P(A\cap B)=0.24\)</span> . Tính <span
class="math inline">\(P(\neg B\mid A)\)</span> . Trước hết tìm <span
class="math inline">\(P(B\mid A)=\frac{P(A\cap
B)}{P(A)}=\frac{0.24}{0.30}=0.8\)</span> . Sau đó <span
class="math inline">\(P(\neg B\mid A)=1-P(B\mid A)=1-0.8=0.2\)</span>
.</p>
<p>Ví dụ 3. Trong lớp 12A có 30 học sinh, 17 trong số đó là nữ. Ba học
sinh tên là Hin: một nữ và hai nam. Tìm xác suất để một học sinh được
gọi ngẫu nhiên là tên Hin và là nữ.</p>
<p><span class="math display">\[P({H i n~a n d~f e m a l e})=\frac{{n u
m b e r~o f~f e m a l e~H i n}}{{t o t a l~s t u d e n t
s}}=\frac{1}{30}.\]</span></p>
<p>Ví dụ 4. Tính <span class="math inline">\(P(A \mid B)\)</span> khi
<span class="math inline">\(P(A) = \frac{13}{40}\)</span> , <span
class="math inline">\(P(B) = \frac{17}{40}\)</span> , và <span
class="math inline">\(P(A \cap B) = \frac{5}{40}\)</span> .</p>
<p><span class="math display">\[P(A\mid B)=\frac{P(A\cap
B)}{P(B)}=\frac{5/40}{17/40}=\frac{5}{17}.\]</span></p>
<h3 id="bài-tập-luyện-tập">4. Bài Tập Luyện Tập</h3>
<p>Bài 1. Một túi chứa 6 hòn bi đỏ, 4 hòn bi xanh, và 5 hòn bi lục. Hai
hòn bi được lấy ra mà không thay thế. Tìm xác suất để hòn bi thứ hai là
xanh cho biết hòn bi đầu tiên được lấy ra là đỏ.</p>
<p>Bài 2. Trong một cuộc khảo sát 200 học sinh, 120 học sinh thích Toán
học, 80 học sinh thích Vật lý, và 50 học sinh thích cả hai môn học. Xác
suất để một học sinh thích Vật lý cho biết học sinh đó thích Toán học là
bao nhiêu?</p>
<p>Bài 3. Từ dữ liệu: <span class="math inline">\(P(A) = 0.06\)</span> ,
<span class="math inline">\(P(B) = 0.07\)</span> , <span
class="math inline">\(P(A \cap B) = 0.03\)</span> . Tính <span
class="math inline">\(P(A \mid B)\)</span> và diễn giải kết quả.</p>
<p>Bài 4. Một lớp học gồm 4 sinh viên cao học và 12 sinh viên đại học.
16 sinh viên được chia ngẫu nhiên thành 4 nhóm, mỗi nhóm 4 người. Xác
suất để mỗi nhóm chứa ít nhất một sinh viên cao học là bao nhiêu?</p>
<h3 id="giải-pháp-các-bài-tập-luyện-tập">5. Giải Pháp Các Bài Tập Luyện
Tập</h3>
<p>Giải pháp 1. Bài 1. Gọi <span class="math inline">\(R_1\)</span> là
sự kiện viên bi đầu tiên là đỏ và <span
class="math inline">\(B_2\)</span> là sự kiện viên bi thứ hai là xanh.
Chúng ta cần <span class="math inline">\(P(B_2 \mid R_1) = \frac{P(R_1
\cap B_2)}{P(R_1)}\)</span> .</p>
<p><span class="math display">\[\bullet
P(R_{1})=\frac{6}{15}=\frac{2}{5}.\]</span></p>
<p>• Sau khi lấy ra viên bi đỏ, còn lại 5 viên bi đỏ, 4 viên bi xanh, 5
viên bi lục (tổng cộng 14 viên).</p>
<p><span class="math inline">\(P(R_{1} \cap B_{2}) = \frac{6}{15} \times
\frac{4}{14} = \frac{24}{210} = \frac{4}{35}\)</span> .</p>
<p>Do đó</p>
<p><span class="math display">\[P(B_{2}\mid
R_{1})=\frac{4/35}{2/5}=\frac{4}{35}\times\frac{5}{2}=\frac{20}{70}=\frac{2}{7}.\]</span></p>
<p>Giải pháp 2. Bài 2. Gọi <span class="math inline">\(M = \text{thích
Toán học}\)</span> , <span class="math inline">\(Ph = \text{thích Vật
lý}\)</span> . Chúng ta cần <span class="math inline">\(P(Ph \mid M) =
\frac{P(M \cap Ph)}{P(M)}\)</span> .</p>
<p><span class="math display">\[\bullet \quad
P(M)=\frac{120}{200}=0.60.\]</span></p>
<p><span class="math display">\[\bullet \quad P(M\cap
Ph)=\frac{50}{200}=0.25.\]</span></p>
<p>Vì vậy</p>
<p><span class="math display">\[P(Ph\mid
M)=\frac{0.25}{0.60}=\frac{5}{12}\approx0.4167.\]</span></p>
<p>Giải pháp 3. Bài 3. Cho <span class="math inline">\(P(A) =
0.06\)</span> , <span class="math inline">\(P(B) = 0.07\)</span> , <span
class="math inline">\(P(A \cap B) = 0.03\)</span> ,</p>
<p><span class="math display">\[P(A\mid B)=\frac{P(A\cap
B)}{P(B)}=\frac{0.03}{0.07}\approx0.4286.\]</span></p>
<p>Diễn giải: Biết rằng sự kiện B đã xảy ra làm tăng xác suất của A từ
6% lên khoảng 42.9%.</p>
<p>Giải pháp 4. Bài toán 4. Chúng ta sử dụng phương pháp bổ sung: tính
xác suất để ít nhất một nhóm không nhận sinh viên thạc sĩ và trừ đi từ
1.</p>
<p>Tổng số cách phân bổ 16 sinh viên khác nhau vào 4 nhóm được đánh dấu
có kích thước 4:</p>
<p><span class="math display">\[N_{t o t a
l}=\frac{16!}{(4!)^{4}}.\]</span></p>
<p>Bây giờ đếm các cách phân bổ mà một nhóm cụ thể, ví dụ nhóm 1, không
nhận sinh viên thạc sĩ. Tất cả 4 sinh viên thạc sĩ phải đi đến 3 nhóm
còn lại (mỗi nhóm có kích thước 4), để lại 12 sinh viên đại học để điền
vào 16 vị trí. Chọn 4 sinh viên đại học cho nhóm 1: <span
class="math inline">\(\binom{12}{4}\)</span> cách. Các sinh viên còn lại
12 người <span class="math inline">\((4\ \text{sinh viên thạc sĩ} + 8\
\text{sinh viên đại học})\)</span> được phân bổ vào các nhóm 2,3,4:</p>
<p><span class="math display">\[12!\]</span></p>
<p><span class="math display">\[\overline{(4!)^{3}}\]</span></p>
<p>Vì vậy cho một nhóm cố định:</p>
<p><span class="math display">\[N_{{n o~g r a d~i n~t h a t~g r o u
p}}=\binom{12}{4}\frac{12!}{(4!)^{3}}.\]</span></p>
<p>Theo nguyên lý bao hàm - loại trừ cho 4 nhóm, số cách phân bổ có ít
nhất một nhóm trống là sinh viên thạc sĩ là</p>
<p><span
class="math display">\[\begin{align*}N_{\geq1}&amp;=4\binom{12}{4}\frac{12!}{(4!)^{3}}-6\binom{12}{4}\binom{8}{4}\frac{8!}{(4!)^{2}}\\&amp;\quad+4\binom{12}{4}\binom{8}{4}\binom{4}{4}\frac{4!}{4!}-1\cdot\binom{12}{4}\binom{8}{4}\binom{4}{4}\binom{0}{0}\\&amp;=4\binom{12}{4}\frac{12!}{(4!)^{3}}-6\binom{12}{4}\binom{8}{4}\frac{8!}{(4!)^{2}}+4\binom{12}{4}\binom{8}{4}.\end{align*}\]</span></p>
<p>Do đó xác suất mong muốn là</p>
<p><span class="math display">\[P=~1-\frac{N_{\geq1}}{N_{{t o t a
l}}}~=~1-\frac{4{\binom{12}{4}}\frac{12!}{(4!)^{3}}-6{\binom{12}{4}}\binom{8}{4}\frac{8!}{(4!)^{2}}+4{\binom{12}{4}}\binom{8}{4}}{\frac{16!}{(4!)^{4}}}.\]</span></p>
<p>Tính các giai thừa cho kết quả:</p>
<p><span class="math display">\[P\approx0.263\mathrm{~(a b o u
t~26.3\%).}\]</span></p>
<h3 id="tóm-tắt">6. Tóm tắt</h3>
<p>Xác suất có điều kiện lượng hóa cách mà khả năng xảy ra của một sự
kiện thay đổi khi chúng ta biết rằng một sự kiện khác đã xảy ra. Công
thức cốt lõi <span class="math inline">\(P(A \mid B) = \frac{P(A \cap
B)}{P(B)}\)</span> cùng với quy tắc nhân và tính độc lập tạo thành nền
tảng cho việc giải quyết một loạt các bài toán từ những tình huống đơn
giản như rút bài đến những tình huống phức tạp hơn như phân nhóm như đã
minh họa ở trên.</p>
');
INSERT INTO lessons (title, description, link, type, difficulty, content) VALUES ('Công Thức Xác Suất Toàn Phần và Định Lý Bayes (Lớp 12)', 'Công thức xác suất toàn phần và định lý Bayes.', '', 'article', '12', '<h1 id="công-thức-xác-suất-tổng-và-định-lý-bayes">Công thức Xác suất
Tổng và Định lý Bayes</h1>
<h3 id="ký-hiệu-cơ-bản">1. Ký hiệu Cơ bản</h3>
<p>Cho <span
class="math inline">\((\Omega,\mathcal{F},\mathbb{P})\)</span> là một
không gian xác suất. Với các sự kiện <span
class="math inline">\(A,B\subseteq\Omega\)</span> ta viết:</p>
<p>• <span class="math inline">\(\mathbb{P}(A)\)</span> xác suất của
A;</p>
<p>• <span class="math inline">\(\mathbb{P}(A \mid B) =
\frac{\mathbb{P}(A \cap B)}{\mathbb{P}(B)}\)</span> xác suất có điều
kiện của <span class="math inline">\(A\)</span> cho <span
class="math inline">\(B\)</span> (với điều kiện <span
class="math inline">\(\mathbb{P}(B) &gt; 0\)</span> );</p>
<p>• <span class="math inline">\(A^{c}\)</span> bù của <span
class="math inline">\(A\)</span> ( <span
class="math inline">\(\mathbb{P}(A^{c})=1-\mathbb{P}(A))\)</span> ;</p>
<ul>
<li>Một tập hợp <span class="math inline">\(\{A_1, A_2, \ldots,
A_n\}\)</span> là một phân hoạch của <span
class="math inline">\(\Omega\)</span> nếu các <span
class="math inline">\(A_i\)</span> đôi một rời nhau và <span
class="math inline">\(\bigcup_{i=1}^n A_i = \Omega\)</span> .</li>
</ul>
<h3 id="định-lý-xác-suất-tổng">2. Định lý Xác suất Tổng</h3>
<p>Nếu <span class="math inline">\(\{A_1, A_2, \ldots, A_n\}\)</span> là
một phân hoạch của <span class="math inline">\(\Omega\)</span> , thì với
mọi sự kiện <span class="math inline">\(B\)</span></p>
<p><span
class="math display">\[\mathbb{P}(B)=\sum_{i=1}^{n}\mathbb{P}(B\mid
A_{i})\mathbb{P}(A_{i}).\]</span></p>
<p>Nói cách khác: xác suất của <span class="math inline">\(B\)</span> là
trung bình có trọng số của các xác suất có điều kiện <span
class="math inline">\(\mathbb{P}(B \mid A_i)\)</span> , trọng số là các
xác suất của các sự kiện phân hoạch.</p>
<h3 id="trường-hợp-đơn-giản-hai-trường-hợp">2.1 Trường hợp đơn giản hai
trường hợp</h3>
<p>Khi phân hoạch gồm một sự kiện A và bù của nó <span
class="math inline">\(A^{c}\)</span> ,</p>
<p><span class="math display">\[\mathbb{P}(B)=\mathbb{P}(B\mid
A)\mathbb{P}(A)+\mathbb{P}(B\mid A^{c})\mathbb{P}(A^{c}).\]</span></p>
<h3 id="ví-dụ">2.2 Ví dụ</h3>
<p>Giả sử một nhà máy có hai máy:</p>
<ul>
<li><p>Máy 1 sản xuất 70% các sản phẩm và có tỷ lệ lỗi 2%;</p></li>
<li><p>Máy 2 sản xuất 30% các sản phẩm và có tỷ lệ lỗi 3%.</p></li>
</ul>
<p>Gọi D là sự kiện một sản phẩm được chọn ngẫu nhiên là lỗi. Sử dụng
(2):</p>
<p><span
class="math display">\[\mathbb{P}(D)=0.7\cdot0.02+0.3\cdot0.03=0.023.\]</span></p>
<p>Vậy 2.3% tổng số sản phẩm là lỗi.</p>
<h3 id="định-lý-bayes">3. Định lý Bayes</h3>
<p>Bắt đầu từ định nghĩa xác suất có điều kiện,</p>
<p><span class="math display">\[\mathbb{P}(A_{i}\mid
B)=\frac{\mathbb{P}(B\mid
A_{i})\mathbb{P}(A_{i})}{\mathbb{P}(B)}.\]</span></p>
<p>Nếu ta thay thế biểu thức cho <span
class="math inline">\(\mathbb{P}(B)\)</span> từ định lý xác suất toàn
phần (1), ta thu được công thức Bayes:</p>
<p><span class="math display">\[\boxed{\mathbb{P}(A_{i}\mid
B)=\frac{\mathbb{P}(B\mid
A_{i})\mathbb{P}(A_{i})}{\displaystyle\sum_{j=1}^{n}\mathbb{P}(B\mid
A_{j})\mathbb{P}(A_{j})}.}\]</span></p>
<h3 id="phiên-bản-hai-trường-hợp">3.1 Phiên bản hai trường hợp</h3>
<p>Với một phân hoạch <span class="math inline">\(\{A, A^{c}\}\)</span>
,</p>
<p><span class="math display">\[\mathbb{P}(A\mid
B)=\frac{\mathbb{P}(B\mid A)\mathbb{P}(A)}{\mathbb{P}(B\mid
A)\mathbb{P}(A)+\mathbb{P}(B\mid A^{c})\mathbb{P}(A^{c})}.\]</span></p>
<h3 id="ví-dụ-1">3.2 Ví dụ</h3>
<p>Tiếp tục ví dụ nhà máy, hãy tìm xác suất một sản phẩm lỗi đến từ Máy
1.</p>
<p><span class="math display">\[\mathbb{P}(\mathrm{Máy~1}\mid
D)=\frac{0.7\cdot0.02}{0.7\cdot0.02+0.3\cdot0.03}=\frac{0.014}{0.023}\approx0.6087.\]</span></p>
<p>Vậy khoảng 60.9% các sản phẩm lỗi được sản xuất bởi Máy 1.</p>
<h3 id="ví-dụ-có-giải">4. Ví dụ có giải</h3>
<h2 id="ví-dụ-1-bệnh-cây-trồng">Ví dụ 1 (Bệnh cây trồng)</h2>
<p>Một cánh đồng chứa 60% ngô và 40% đậu nành. Xác suất một cây ngô bị
bệnh là 0.15; đối với cây đậu nành là 0.10.</p>
<p>• Xác suất tổng thể của một cây bị bệnh:</p>
<p><span class="math display">\[\mathbb{P}(bị
bệnh)=0.6\cdot0.15+0.4\cdot0.10=0.13.\]</span></p>
<ul>
<li>Xác suất một cây bị bệnh là ngô:</li>
</ul>
<p><span class="math display">\[\mathbb{P}(\operatorname{c o r
n}\mid\mathrm{bị
bệnh})=\frac{0.6\cdot0.15}{0.13}\approx0.6923.\]</span></p>
<h2 id="ví-dụ-2-kiểm-tra-y-tế">Ví dụ 2 (Kiểm tra y tế)</h2>
<p>Một bệnh có tần suất 0.1 (tức là <span
class="math inline">\(\mathbb{P}(D) = 0.1\)</span> ). Một xét nghiệm
dương tính với xác suất 0.98 nếu người đó thực sự mắc bệnh <span
class="math inline">\((\mathbb{P}(T^{+} | D) = 0.98)\)</span> và với xác
suất 0.02 nếu người đó khỏe mạnh <span
class="math inline">\((\mathbb{P}(T^{+} | D^{c}) = 0.02)\)</span> .</p>
<p>• Xác suất của một xét nghiệm dương tính:</p>
<p><span
class="math display">\[\mathbb{P}(T^{+})=0.98\cdot0.1+0.02\cdot0.9=0.098+0.018=0.116.\]</span></p>
<ul>
<li>Xác suất người đó thực sự mắc bệnh nếu xét nghiệm dương tính:</li>
</ul>
<p><span class="math display">\[\mathbb{P}(D\mid
T^{+})=\frac{0.98\cdot0.1}{0.116}\approx0.8448.\]</span></p>
<h3 id="bài-tập-thực-hành">5. Bài tập thực hành</h3>
<p>Bài toán 1 Trong một thành phố, 30% cư dân sử dụng phương tiện công
cộng, 70% sử dụng xe riêng. Trong số người sử dụng phương tiện công
cộng, 5% bị trễ giờ làm; trong số người sử dụng xe riêng, 12% bị trễ.
(a) Xác suất tổng thể để một cư dân được chọn ngẫu nhiên bị trễ giờ làm
là bao nhiêu? (b) Nếu một cư dân bị trễ, xác suất họ sử dụng phương tiện
công cộng là bao nhiêu?</p>
<p>Bài toán 2 Một hộp chứa ba loại đồng xu có thiên lệch: Đồng xu A cho
mặt ngửa với xác suất 0.2 (40% các đồng xu), Đồng xu B cho mặt ngửa với
xác suất 0.5 (35% các đồng xu), Đồng xu C cho mặt ngửa với xác suất 0.8
(25% các đồng xu). Một đồng xu được chọn ngẫu nhiên và tung một lần, cho
ra mặt ngửa. Tìm xác suất đồng xu được chọn là Đồng xu C.</p>
<p>Bài toán 3 Một xét nghiệm chẩn đoán cho một tình trạng hiếm có độ
nhạy 0.95 (xác suất kết quả dương tính khi tình trạng hiện diện) và độ
đặc hiệu 0.90 (xác suất kết quả âm tính khi tình trạng vắng mặt). Tình
trạng xảy ra ở 0.2% dân số. Tính xác suất một người thực sự mắc tình
trạng nếu kết quả xét nghiệm dương tính.</p>
<h3 id="các-giải-pháp-cho-bài-tập-thực-hành">6. Các Giải Pháp Cho Bài
Tập Thực Hành</h3>
<h2 id="giải-pháp-cho-bài-toán-1">Giải Pháp Cho Bài Toán 1</h2>
<p>Gọi <span class="math inline">\(L\)</span> là sự kiện trễ giờ làm
việc, <span class="math inline">\(P\)</span> là sự kiện sử dụng phương
tiện công cộng, và <span class="math inline">\(C\)</span> là sự kiện sử
dụng xe hơi. Chúng ta có <span
class="math inline">\(\mathbb{P}(P)=0.3\)</span> , <span
class="math inline">\(\mathbb{P}(C)=0.7\)</span> , <span
class="math inline">\(\mathbb{P}(L\mid P)=0.05\)</span> , <span
class="math inline">\(\mathbb{P}(L\mid C)=0.12\)</span> .</p>
<ol type="a">
<li>Xác suất tổng:</li>
</ol>
<p><span class="math display">\[\mathbb{P}(L)=\mathbb{P}(L\mid
P)\mathbb{P}(P)+\mathbb{P}(L\mid
C)\mathbb{P}(C)=0.05\cdot0.3+0.12\cdot0.7=0.015+0.084=0.099.\]</span></p>
<p>Do đó 9.9% dân số trễ giờ.</p>
<ol start="2" type="a">
<li>Định lý Bayes:</li>
</ol>
<p><span class="math display">\[\mathbb{P}(P\mid
L)=\frac{\mathbb{P}(L\mid
P)\mathbb{P}(P)}{\mathbb{P}(L)}=\frac{0.05\cdot0.3}{0.099}=\frac{0.015}{0.099}\approx0.1515.\]</span></p>
<p>Vì vậy khoảng 15.2% những người trễ giờ sử dụng phương tiện công
cộng.</p>
<h2 id="giải-pháp-cho-bài-toán-2">Giải Pháp Cho Bài Toán 2</h2>
<p>Gọi H là sự kiện mặt ngửa xuất hiện. Gọi A, B, C là các sự kiện chọn
được đồng tiền loại A, B, C tương ứng. Cho biết:</p>
<p><span
class="math display">\[\mathbb{P}(A)=0.4,\;\mathbb{P}(B)=0.35,\;\mathbb{P}(C)=0.25,\]</span></p>
<p><span class="math display">\[\mathbb{P}(H\mid
A)=0.2,\;\mathbb{P}(H\mid B)=0.5,\;\mathbb{P}(H\mid C)=0.8.\]</span></p>
<p>Xác suất tổng của mặt ngửa:</p>
<p><span
class="math display">\[\mathbb{P}(H)=0.2\cdot0.4+0.5\cdot0.35+0.8\cdot0.25=0.08+0.175+0.20=0.455.\]</span></p>
<p>Xác suất đồng tiền là C cho biết mặt ngửa:</p>
<p><span class="math display">\[\mathbb{P}(C\mid
H)=\frac{\mathbb{P}(H\mid
C)\mathbb{P}(C)}{\mathbb{P}(H)}=\frac{0.8\cdot0.25}{0.455}=\frac{0.20}{0.455}\approx0.4396.\]</span></p>
<p>Do đó có khoảng 44% khả năng đồng tiền được chọn là loại C.</p>
<h2 id="giải-pháp-cho-bài-toán-3">Giải Pháp Cho Bài Toán 3</h2>
<p>Định nghĩa:</p>
<p>• D: người có điều kiện; <span class="math inline">\(\mathbb{P}(D) =
0.002\)</span> .</p>
<p>• <span class="math inline">\(T^{+}\)</span> : kết quả kiểm tra là
dương.</p>
<p><span class="math display">\[\mathbb{P}(T^{+}\mid
D)=0.95\quad(\mathrm{s e n s i t i v i t y}),\]</span></p>
<p><span class="math display">\[\mathbb{P}(T^{+}\mid D^{c})=1-\mathrm{s
p e c i f i c i t y}=1-0.90=0.10.\]</span></p>
<p>Tổng xác suất của một kết quả dương tính:</p>
<p><span
class="math display">\[\mathbb{P}(T^{+})=0.95\cdot0.002+0.10\cdot0.998=0.0019+0.0998=0.1017.\]</span></p>
<p>Xác suất có điều kiện được mắc bệnh khi kết quả xét nghiệm dương
tính:</p>
<p><span class="math display">\[\mathbb{P}(D\mid
T^{+})=\frac{0.95\cdot0.002}{0.1017}=\frac{0.0019}{0.1017}\approx0.0187.\]</span></p>
<p>Vì vậy, ngay cả khi có kết quả dương tính, chỉ khoảng 1.9% số người
thực sự mắc bệnh, điều này minh họa tác động của tỷ lệ mắc bệnh
thấp.</p>
<h3 id="tóm-tắt-các-công-thức-chính">7. Tóm tắt các công thức chính</h3>
<p>• Định lý xác suất toàn phần (chia thành các phần <span
class="math inline">\(\{A_{i}\}\)</span> ):</p>
<p><span
class="math display">\[\left|\mathbb{P}(B)=\sum_{i}\mathbb{P}(B\mid
A_{i})\mathbb{P}(A_{i})\right|.\]</span></p>
<p>• Định lý Bayes:</p>
<p><span class="math display">\[\left|\mathbb{P}(A_{i}\mid
B)=\frac{\mathbb{P}(B\mid
A_{i})\mathbb{P}(A_{i})}{\sum_{j}\mathbb{P}(B\mid
A_{j})\mathbb{P}(A_{j})}\right|\]</span></p>
<p>• Trường hợp hai sự kiện (với phần bù):</p>
<p><span class="math display">\[\mathbb{P}(B)=\mathbb{P}(B\mid
A)\mathbb{P}(A)+\mathbb{P}(B\mid A^{c})\mathbb{P}(A^{c}),\]</span></p>
<p><span class="math display">\[\mathbb{P}(A\mid
B)=\frac{\mathbb{P}(B\mid A)\mathbb{P}(A)}{\mathbb{P}(B\mid
A)\mathbb{P}(A)+\mathbb{P}(B\mid A^{c})\mathbb{P}(A^{c})}.\]</span></p>
');