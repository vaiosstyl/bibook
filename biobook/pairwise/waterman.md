
# Smith-Waterman Algorithm: Local Alignment

## Background

Developed by Temple F. Smith and Michael S. Waterman in 1981, the Smith-Waterman algorithm is a cornerstone in computational biology for performing local sequence alignments. It was designed to identify regions of similarity within long sequences of DNA, RNA, or proteins, allowing for variability in length and composition.

## Principle

The Smith-Waterman algorithm employs dynamic programming to construct an alignment matrix that scores local alignments between two sequences. It initializes the matrix and fills it based on match, mismatch, and gap penalties, iteratively computing the highest possible score for any contiguous alignment segment.

## Implementation

The implementation of the Smith-Waterman algorithm involves initializing an alignment matrix with zeros, and then iteratively updating its cells based on the scores of adjacent cells and the scoring schema (match, mismatch, and gap penalties). Key considerations include the choice of scoring parameters and the method for traceback to reconstruct the optimal local alignment.

## Applications

The Smith-Waterman algorithm is crucial for various applications in genomic research, drug discovery, and evolutionary studies. It is particularly useful in situations where the most informative element is a portion of the available data, such as identifying conserved motifs within a larger genomic sequence or aligning sequences that include regions of high variation.

## The definitions of the problem, and the solution

Given two sequences $a_1,\ldots,a_N$ and $b_1,\ldots,b_M$, a scoring function $d(x,y)$, find a *local* alignment that gives an optimal (maximal) score.

The solution can be found by studying the dynamic programming matrix, $S$, of size $(N+1,M+1)$, by using the recursions defined in equations {eq}`sw-init` and {eq}`sw-recursion`.

```{math}
:label: sw-init

\begin{align*}
 S_{0,0} =& 0, \\
S_{i,0} =& 0 \textrm{for all}\ i, \\
S_{0,j} =& \textrm{for all}\ j 
\end{align*}
```

```{math}
:label: sw-recursion

S_{i,j}=\max
\begin{cases}
   0\\
   S_{i-1,j-1} & + d(a_i,b_j)\\
   S_{i-1,j} & + d(a_i,-)\\
   S_{i,j-1} & + d(-,b_j).
\end{cases}
```
