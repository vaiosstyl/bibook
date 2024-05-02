# Multiple Sequence Alignments

## Intoduction 
While pairwise alignments enable comparisons between two sequences, many biological analyses require a more comprehensive approach: the alignment of multiple sequences simultaneously. Multiple sequence alignments (MSAs) offer a holistic view of sequence similarities and differences, illuminating functional and evolutionary relationships across diverse genomes and proteomes.

### Exponential Time Complexity

In principle one can use dynamic programming to form MSAs. We can archive such systems using the same priciples as for the pairwise alignments, but just expanding the dynamic programming matrix into a tensor of the same dimension as the number of sequences.  However, a major drawback is its exponential time complexity.  Aligning $T$ sequences each of length $N$ can result in a time complexity of $O(N^T)$, making it impractical for datasets with more than a few sequences.

### Iterative Approaches as a Practical Alternative

Given the inefficiencies of dynamic programming for MSAs, bioinformaticians have turned to heuristics that mimic the behaviour of full dynamic programming. Particularly iterative approaches, such as progressive alignment . These methods simplify the alignment process by breaking it down into manageable steps. Progressive alignment, for instance, first generates a guide tree based on pairwise similarities, then iteratively aligns sequences according to the tree's order. This reduces the computational burden and allows for the processing of large datasets in a reasonable time frame.

## Progressive Alignments

While dynamic programming offers an optimal solution for pairwise alignments, its inefficiency for MSAs necessitates a balance between accuracy and computational efficiency. Iterative and heuristic methods like progressive alignment and consistency-based algorithms strike this balance, providing near-optimal solutions in significantly less time.

A key method for constructing MSAs is progressive alignment, a stepwise approach that builds upon pairwise alignments to create a broader, more nuanced comparison. The progressive alignment method begins by generating a distance matrix, which quantifies the pairwise similarity between all sequences in the dataset. From this matrix, a guide tree is constructed, representing the evolutionary relationships inferred from the sequence similarities.

Progressive alignment then follows this guide tree, iteratively aligning sequences in order of their proximity on the tree. This process begins with the closest pair of sequences, which are aligned directly. Subsequent sequences are added progressively, with each new sequence being aligned to the growing consensus. This stepwise process creates an alignment that reflects both sequence similarities and evolutionary relationships.

The progressive alignment method offers several advantages. It efficiently handles large datasets, making it well-suited for genomics and proteomics research. By utilizing an evolutionary framework, it provides deeper insights into the conserved and divergent features of sequences, aiding in the identification of functionally important regions and evolutionary patterns.

In this chapter, we delve into the mechanics of progressive alignment, exploring its implementation and applications in bioinformatics. By understanding this approach, we gain valuable insights into the biological relationships and evolutionary trajectories that shape our world.

### Progressive Alignment Steps

PThe process builds alignments in a stepwise manner, starting with the most similar sequences and gradually incorporating others. Here's a detailed look at how to create a progressive alignment. Lests assume you start with $T$ sequences, $C=\{A_1, \ldots, A_T\}$.

1. Compute Pairwise Alignments: Initially, calculate all pairwise alignments between each pair of sequences in $C$ using a suitable algorithm such as Needleman-Wunsch or Smith-Waterman. This provides a matrix of scores or distances that indicate how similar or different each pair of sequences is.

2. Use the pairwise distances to identify the two sequences in $C$, $A_i$ and  $A_j$ that are closest (those with the highest similarity score or lowest distance), and form a alignment of those two sequences.  Remove $A_i$ and $A_j$ from $C$. We call the alignment of those two sequences $B$.

3. Add $B$ to $C$. Set the distance from $B$ to each of the other sequences in $C$ to the average of their distance from $A_i$ and $A_j$.

4. If there are more sequences than one in $C$, then go to step 2.

### Progressive Alignment Steps


::::{grid} 2 2 4 4
:class-container: text-center
:gutter: 1

:::{grid-item-card}
Input sequences
```none
IAMAPEPTIDE  
IAMPEPTIDE
IAMPEPPED
IAMAPEPPERD
```
These are the sequences we want to align.
:::

:::{grid-item-card}
Seq1 and Seq2
```none
IAMAPEPTIDE
IAM-PEPTIDE
```
We form a pairwise alignment of those two most similar sequences.
We then pool the resulting sequences with the other two sequences.
:::

:::{grid-item-card}
Seq3 and Seq4.
```none
IAM-PEPPE-D
IAMAPEPPERD
```
These sequence were the most similar among remaining ones.
:::

:::{grid-item-card}
(Seq1,Seq2) and (Seq3,Seq4).
```none
IAMAPEPTID-E
IAM-PEPTID-E
IAM-PEPP-E-D
IAMAPEPP-ERD
```
There are two generalized sequences left. We align those two, and we are then done.
:::
::::
