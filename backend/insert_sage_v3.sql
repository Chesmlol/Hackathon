-- 20 bai SageMath, statement dang OJ truyen thong (INPUT/OUTPUT + bang Sample I/O)
-- Giu nguyen starter_code/judge_harness da test tu ban truoc; chi doi statement.
-- INSERT OR REPLACE theo id nen chay lai an toan.
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_multiset_no_adj', 'Multiset Permutations, No Equal Letters Adjacent', 100, '', '<p>A word contains a copies of A, b copies of B, and c copies of C. Count the distinct permutations of the word in which no two equal letters are adjacent.</p><h3>Input</h3><p>One line with three integers a, b, c — the counts of letters A, B, and C.</p><h3>Output</h3><p>The number of distinct permutations of the multiset with no two equal letters adjacent.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>2 1 1</td><td>6</td></tr></table><p>Implement the function <code>count_no_adjacent(a, b, c)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def count_no_adjacent(a, b, c):
    # Write your solution here
    pass
', '__testcases = [
    (2, 1, 1),
    (3, 2, 1),
    (2, 2, 2),
    (4, 3, 2),
    (5, 4, 3),
]
__expected = [''6'', ''10'', ''30'', ''79'', ''588'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(count_no_adjacent(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_circular_arrangements', 'Circular Arrangements (up to Rotation)', 100, '', '<p>Given n distinct objects, count the distinct circular arrangements, where arrangements differing only by rotation are considered the same.</p><h3>Input</h3><p>One line with the integer n — the number of distinct objects.</p><h3>Output</h3><p>The number of circular arrangements up to rotation.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>7</td><td>720</td></tr></table><p>Implement the function <code>circular_arrangements(n)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def circular_arrangements(n):
    # Write your solution here
    pass
', '__testcases = [
    (7,),
    (8,),
    (10,),
    (12,),
    (15,),
]
__expected = [''720'', ''5040'', ''362880'', ''39916800'', ''87178291200'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(circular_arrangements(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_circular_not_adjacent', 'Circular Arrangements with a Forbidden Adjacency', 100, '', '<p>Given n distinct objects arranged on a circle (up to rotation), count the circular arrangements in which two particular distinguished objects are NOT adjacent.</p><h3>Input</h3><p>One line with the integer n (n ≥ 2).</p><h3>Output</h3><p>The number of circular arrangements (up to rotation) in which the two distinguished objects are not adjacent.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>6</td><td>72</td></tr></table><p>Implement the function <code>circular_not_adjacent(n)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def circular_not_adjacent(n):
    # Write your solution here
    pass
', '__testcases = [
    (6,),
    (7,),
    (9,),
    (10,),
    (12,),
]
__expected = [''72'', ''480'', ''30240'', ''282240'', ''32659200'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(circular_not_adjacent(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_multinomial_coeff', 'Multinomial Coefficient from an Expansion', 100, '', '<p>Find the coefficient of x^a y^b z^c in the expansion of (x+y+z)^n, where a+b+c = n.</p><h3>Input</h3><p>One line with four integers n, a, b, c, where a + b + c = n.</p><h3>Output</h3><p>The coefficient of x^a y^b z^c in the expansion of (x+y+z)^n.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>8 3 2 3</td><td>560</td></tr></table><p>Implement the function <code>multinomial_coeff(n, a, b, c)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def multinomial_coeff(n, a, b, c):
    # Write your solution here
    pass
', '__testcases = [
    (8, 3, 2, 3),
    (10, 4, 3, 3),
    (12, 5, 4, 3),
    (15, 5, 4, 6),
    (20, 8, 6, 6),
]
__expected = [''560'', ''4200'', ''27720'', ''630630'', ''116396280'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(multinomial_coeff(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_bounded_stars_bars', 'Bounded Stars and Bars', 100, '', '<p>Count the nonnegative integer solutions to x1 + x2 + ... + xk = n subject to xi <= bounds[i] for every i.</p><h3>Input</h3><p>The first line has the integer n. The second line has the bounds u1 u2 ... uk, space-separated.</p><h3>Output</h3><p>The number of nonnegative integer solutions to x1 + ... + xk = n with xi ≤ ui.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>7
2 3 4</td><td>6</td></tr></table><p>Implement the function <code>bounded_compositions(n, bounds)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def bounded_compositions(n, bounds):
    # Write your solution here
    pass
', '__testcases = [
    (7, [2, 3, 4]),
    (10, [3, 4, 5, 6]),
    (12, [4, 4, 4]),
    (8, [2, 2, 2, 2]),
    (15, [5, 5, 5, 5]),
]
__expected = [''6'', ''96'', ''1'', ''1'', ''56'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(bounded_compositions(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_surjections', 'Counting Surjections', 100, '', '<p>How many surjective (onto) functions are there from an n-element set to a k-element set?</p><h3>Input</h3><p>One line with two integers n and k.</p><h3>Output</h3><p>The number of surjective functions from an n-element set to a k-element set.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>8 4</td><td>40824</td></tr></table><p>Implement the function <code>surjections(n, k)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def surjections(n, k):
    # Write your solution here
    pass
', '__testcases = [
    (8, 4),
    (10, 5),
    (9, 3),
    (12, 4),
    (15, 5),
]
__expected = [''40824'', ''5103000'', ''18150'', ''14676024'', ''25292030400'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(surjections(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_set_partitions_k_blocks', 'Set Partitions into Exactly k Blocks', 100, '', '<p>Count the ways to partition an n-element set into exactly k nonempty, unlabeled subsets (a Stirling number of the second kind).</p><h3>Input</h3><p>One line with two integers n and k.</p><h3>Output</h3><p>The number of ways to partition an n-element set into exactly k nonempty unlabeled subsets.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>9 3</td><td>3025</td></tr></table><p>Implement the function <code>set_partitions_exact(n, k)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def set_partitions_exact(n, k):
    # Write your solution here
    pass
', '__testcases = [
    (9, 3),
    (10, 4),
    (12, 4),
    (15, 5),
    (18, 6),
]
__expected = [''3025'', ''34105'', ''611501'', ''210766920'', ''110687251039'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(set_partitions_exact(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_bell_number', 'Bell Numbers', 100, '', '<p>Compute the Bell number Bn: the number of ways to partition an n-element set into any number of nonempty, unlabeled subsets.</p><h3>Input</h3><p>One line with the integer n.</p><h3>Output</h3><p>The Bell number Bn.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>8</td><td>4140</td></tr></table><p>Implement the function <code>bell_number_sage(n)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def bell_number_sage(n):
    # Write your solution here
    pass
', '__testcases = [
    (8,),
    (10,),
    (12,),
    (15,),
    (18,),
]
__expected = [''4140'', ''115975'', ''4213597'', ''1382958545'', ''682076806159'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(bell_number_sage(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_gaussian_binomial', 'Gaussian Binomial Coefficients', 100, '', '<p>Compute the number of k-dimensional subspaces of F_q^n (the Gaussian binomial coefficient).</p><h3>Input</h3><p>One line with three integers q, n, k.</p><h3>Output</h3><p>The Gaussian binomial coefficient (n choose k)_q.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>2 6 3</td><td>1395</td></tr></table><p>Implement the function <code>gaussian_binomial(q, n, k)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def gaussian_binomial(q, n, k):
    # Write your solution here
    pass
', '__testcases = [
    (2, 6, 3),
    (2, 8, 4),
    (3, 6, 2),
    (3, 8, 4),
    (5, 6, 3),
]
__expected = [''1395'', ''200787'', ''11011'', ''75913222'', ''2558556'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(gaussian_binomial(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_derangements_r_fixed', 'Permutations with Exactly r Fixed Points', 100, '', '<p>Count the permutations of {1,...,n} that have exactly r fixed points.</p><h3>Input</h3><p>One line with two integers n and r.</p><h3>Output</h3><p>The number of permutations of {1,...,n} with exactly r fixed points.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>7 2</td><td>924</td></tr></table><p>Implement the function <code>permutations_with_r_fixed(n, r)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def permutations_with_r_fixed(n, r):
    # Write your solution here
    pass
', '__testcases = [
    (7, 2),
    (8, 3),
    (10, 3),
    (12, 4),
    (15, 5),
]
__expected = [''924'', ''2464'', ''222480'', ''7342335'', ''4008887883'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(permutations_with_r_fixed(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_poisson_binomial', 'Poisson-Binomial: Exact Probability of k Successes', 100, '', '<p>Given independent Bernoulli trials with success probabilities ps, compute the exact probability of exactly k successes, as a reduced fraction.</p><h3>Input</h3><p>The first line has the probabilities p1 p2 ... pn as fractions, space-separated. The second line has the integer k.</p><h3>Output</h3><p>The exact probability of exactly k successes, as a reduced fraction.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>1/2 1/3 1/4
2</td><td>1/4</td></tr></table><p>Implement the function <code>poisson_binomial_exact(ps, k)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def poisson_binomial_exact(ps, k):
    # Write your solution here
    pass
', '__testcases = [
    ([1/2, 1/3, 1/4], 2),
    ([1/2, 1/3, 1/4, 1/5, 1/6], 2),
    ([1/2, 1/3, 1/4, 1/5, 1/6, 1/7], 3),
    ([1/2, 1/3, 1/4, 1/5, 1/6, 1/7, 1/8, 1/9], 4),
    ([1/2, 1/3, 1/4, 1/5, 1/6, 1/7, 1/8, 1/9, 1/10, 1/11], 5),
]
__expected = [''1/4'', ''5/16'', ''7/48'', ''1069/17280'', ''781/34560'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(poisson_binomial_exact(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_forced_nonempty_boxes', 'Onto Functions with Forced Nonempty Boxes', 100, '', '<p>Distribute n distinct balls into k distinct boxes so that every box ends up nonempty, with the first t boxes additionally required to be nonempty.</p><h3>Input</h3><p>One line with three integers n, k, t.</p><h3>Output</h3><p>The number of ways to distribute n distinct balls into k distinct boxes so every box is nonempty.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>6 4 2</td><td>1560</td></tr></table><p>Implement the function <code>onto_with_forced_boxes(n, k, t)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def onto_with_forced_boxes(n, k, t):
    # Write your solution here
    pass
', '__testcases = [
    (6, 4, 2),
    (8, 5, 3),
    (10, 5, 5),
    (12, 6, 3),
    (15, 7, 4),
]
__expected = [''1560'', ''126000'', ''5103000'', ''953029440'', ''2060056318320'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(onto_with_forced_boxes(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_mixed_gen_func_coeff', 'Coefficient from a Mixed Generating Function', 100, '', '<p>Find the coefficient of x^a y^b in (1 + x + x^2)^m * (1+y)^n.</p><h3>Input</h3><p>One line with four integers m, n, a, b.</p><h3>Output</h3><p>The coefficient of x^a y^b in (1+x+x^2)^m (1+y)^n.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>4 5 3 2</td><td>160</td></tr></table><p>Implement the function <code>mixed_coeff(m, n, a, b)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def mixed_coeff(m, n, a, b):
    # Write your solution here
    pass
', '__testcases = [
    (4, 5, 3, 2),
    (5, 6, 4, 2),
    (6, 8, 5, 3),
    (8, 9, 5, 4),
    (10, 10, 6, 5),
]
__expected = [''160'', ''675'', ''7056'', ''63504'', ''718200'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(mixed_coeff(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_ordered_bell', 'Ordered Bell (Fubini) Numbers', 100, '', '<p>Count the number of ordered set partitions of an n-element set (the ordered Bell / Fubini number).</p><h3>Input</h3><p>One line with the integer n.</p><h3>Output</h3><p>The ordered Bell (Fubini) number for n.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>5</td><td>541</td></tr></table><p>Implement the function <code>ordered_bell(n)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def ordered_bell(n):
    # Write your solution here
    pass
', '__testcases = [
    (5,),
    (6,),
    (8,),
    (10,),
    (12,),
]
__expected = [''541'', ''4683'', ''545835'', ''102247563'', ''28091567595'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(ordered_bell(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_exactly_r_distinct', 'Exactly r Distinct Values Among n Draws', 100, '', '<p>An urn contains m labeled colors. Draw n balls independently with replacement. Count the sequences in which exactly r distinct colors appear.</p><h3>Input</h3><p>One line with three integers m, n, r.</p><h3>Output</h3><p>The number of length-n sequences drawn from m colors with exactly r distinct colors appearing.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>4 5 3</td><td>600</td></tr></table><p>Implement the function <code>exactly_r_distinct(m, n, r)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def exactly_r_distinct(m, n, r):
    # Write your solution here
    pass
', '__testcases = [
    (4, 5, 3),
    (5, 8, 4),
    (8, 10, 5),
    (10, 12, 6),
    (12, 15, 7),
]
__expected = [''600'', ''204120'', ''285768000'', ''200136182400'', ''1631564604109440'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(exactly_r_distinct(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_restricted_compositions', 'Restricted Compositions via Generating Functions', 100, '', '<p>Count the integer solutions to x1 + ... + xk = n where each xi must belong to a prescribed finite set (sets[i]).</p><h3>Input</h3><p>The first line has the integer k (number of variables). Each of the next k lines lists the allowed values for that variable, space-separated. The final line has the integer n.</p><h3>Output</h3><p>The number of integer solutions to x1+...+xk=n with each xi restricted to its given set.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>3
0 1
1 2
0 2
3</td><td>2</td></tr></table><p>Implement the function <code>restricted_compositions(sets, n)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def restricted_compositions(sets, n):
    # Write your solution here
    pass
', '__testcases = [
    ([[0, 1], [1, 2], [0, 2]], 3),
    ([[0, 1], [1, 2], [0, 2], [0, 1, 2]], 5),
    ([[0, 1, 2], [0, 1, 2], [0, 1, 2], [0, 1, 2]], 7),
    ([[0, 1, 2], [0, 1, 2], [0, 1, 2], [0, 1, 2], [0, 1, 2]], 8),
    ([[0, 1, 2], [0, 1, 2], [0, 1, 2], [0, 1, 2], [0, 1, 2], [0, 1, 2]], 10),
]
__expected = [''2'', ''5'', ''4'', ''15'', ''21'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(restricted_compositions(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_perms_c_cycles', 'Permutations with a Given Number of Cycles', 100, '', '<p>Count the permutations of n elements that have exactly c cycles (an unsigned Stirling number of the first kind).</p><h3>Input</h3><p>One line with two integers n and c.</p><h3>Output</h3><p>The number of permutations of n elements with exactly c cycles.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>6 2</td><td>274</td></tr></table><p>Implement the function <code>permutations_with_c_cycles(n, c)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def permutations_with_c_cycles(n, c):
    # Write your solution here
    pass
', '__testcases = [
    (6, 2),
    (8, 3),
    (10, 4),
    (12, 5),
    (15, 6),
]
__expected = [''274'', ''13132'', ''723680'', ''45995730'', ''56663366760'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(permutations_with_c_cycles(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_binomial_tail', 'Binomial Tail Probability (Symbolic)', 100, '', '<p>Let X ~ Binomial(n, p). Compute Pr[X >= k] exactly as a reduced fraction.</p><h3>Input</h3><p>One line with n, p (as a fraction), and k.</p><h3>Output</h3><p>Pr[X ≥ k] for X ~ Binomial(n, p), as a reduced fraction.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>5 1/2 3</td><td>1/2</td></tr></table><p>Implement the function <code>binom_tail(n, p, k)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def binom_tail(n, p, k):
    # Write your solution here
    pass
', '__testcases = [
    (5, 1/2, 3),
    (8, 1/2, 4),
    (10, 1/2, 6),
    (12, 1/3, 5),
    (15, 2/5, 8),
]
__expected = [''1/2'', ''163/256'', ''193/512'', ''65275/177147'', ''6503393024/30517578125'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(binom_tail(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_binary_necklaces', 'Binary Necklaces (Burnside''s Lemma)', 100, '', '<p>Count the binary necklaces of length n up to rotation (Burnside''s lemma).</p><h3>Input</h3><p>One line with the integer n.</p><h3>Output</h3><p>The number of binary necklaces of length n up to rotation.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>8</td><td>36</td></tr></table><p>Implement the function <code>binary_necklaces(n)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def binary_necklaces(n):
    # Write your solution here
    pass
', '__testcases = [
    (8,),
    (10,),
    (12,),
    (16,),
    (20,),
]
__expected = [''36'', ''108'', ''352'', ''4116'', ''52488'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(binary_necklaces(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');
INSERT OR REPLACE INTO initial_misions (id, title, xp, answer, statement, type, test_input, starter_code, judge_harness) VALUES ('sage_necklaces_k_black', 'Binary Necklaces with a Fixed Number of Black Beads', 100, '', '<p>Count the binary necklaces of length n with exactly k black beads, up to rotation.</p><h3>Input</h3><p>One line with two integers n and k.</p><h3>Output</h3><p>The number of binary necklaces of length n with exactly k black beads.</p><table class="io-sample-table"><tr><th>Sample Input</th><th>Sample Output</th></tr><tr><td>10 3</td><td>12</td></tr></table><p>Implement the function <code>binary_necklaces_with_k_black(n, k)</code> below to compute this. Your code will be run, then this function will be called on 5 hidden testcases; each correct result is worth 20 points (100 points total).</p>', 'code', '', 'def binary_necklaces_with_k_black(n, k):
    # Write your solution here
    pass
', '__testcases = [
    (10, 3),
    (12, 4),
    (15, 5),
    (18, 6),
    (20, 8),
]
__expected = [''12'', ''43'', ''201'', ''1038'', ''6310'']
__score = 0
for __i, __args in enumerate(__testcases):
    try:
        __r = str(binary_necklaces_with_k_black(*__args))
    except Exception as __e:
        __r = ''ERROR: '' + str(__e)
    __ok = (__r == __expected[__i])
    if __ok:
        __score += 20
    print(''Test '' + str(__i+1) + '': '' + (''PASS'' if __ok else ''FAIL''))
print(''JUDGE_SCORE='' + str(__score))');