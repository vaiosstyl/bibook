# Profile Hidden Markov Models

## Overview

Profile Hidden Markov Models (HMMs) are statistical models designed to capture the variability and patterns found in multiple sequence alignments (MSAs). They offer a robust way to model conserved regions, sequence motifs, and evolutionary variations, making them an essential tool in bioinformatics for sequence analysis and comparison.

## Profile HMMs as representations of MSAs

A multiple sequence alignment of a homologous family of protein domains reveals patterns of site-specific evolutionary conservation:

- **Conserved Residues:** Certain positions show high conservation, reflecting key functional or structural roles.
- **Substitution Patterns:** Some positions tolerate substitutions that conserve physiochemical properties like hydrophobicity, charge, or size.
- **Variable Positions:** Some positions exhibit near-neutral variability.
- **Insertions and Deletions:** Insertions and deletions are tolerated at some positions more than others.

A profile HMM is is a position-specific scoring model that describes which symbols are likely to be observed and how frequently insertions or deletions occur at each position (column) of a multiple sequence alignment.

- **Probabilistic Basis:** HMMs have a formal probabilistic basis, allowing the use of probability theory to set and interpret the large number of free parameters in a profile, including position-specific gap and insertion parameters.
- **Automatable Methods:** These methods are mathematically consistent and automatable, enabling the creation of libraries of hundreds of profile HMMs for large-scale genome analysis.

### Applications

Profile HMMs offer several key applications in bioinformatics:

1. **Sequence Alignment:** By comparing a new sequence to a profile HMM, we can identify which regions of the sequence correspond to conserved regions in the MSA, helping to align the new sequence with known homologs.

2. **Domain Detection:** Profile HMMs can identify and characterize functional domains in proteins by matching sequence segments to domain profiles.

3. **Sequence Classification:** By comparing a sequence to various profile HMMs, we can classify it into families or groups, aiding in the identification of evolutionary relationships.
One notable database of protein domain models is [Pfam](http://pfam.xfam.org/). Pfam and the HMMER software suite have been developed in parallel, providing comprehensive resources for protein families based on seed alignments.

### Structure of a Profile HMM

```{figure} ./img/phmm.png
:name: fig-profileHMM
:align: left
:width: 100%

A state diagram of a profile HMM with 4 match states.
```

A Profile HMM is structured to mirror the columns of an MSA, with three main states for each column:

1. **Match States (M):** Represent conserved positions in the alignment, corresponding to columns with similar residues or nucleotides across multiple sequences. Match states store probabilities for each possible amino acid or nucleotide at that position, reflecting the distribution observed in the MSA.

2. **Insertion States (I):** Account for potential insertions between columns, capturing variability by allowing additional residues or nucleotides to be added. These states store probabilities for each possible amino acid or nucleotide to be inserted.

3. **Deletion States (D):** Represent positions where sequences may lack a corresponding residue or nucleotide, resulting in a gap in the alignment. Deletion states enable the model to handle varying lengths in sequences.

### Emission Probabilities

Emission probabilities in a Profile HMM quantify the likelihood of observing a specific amino acid or nucleotide at each position in an alignment. These probabilities are stored within match, insertion states (delete staes are silent and dont emit sequence) and are derived from the frequencies of residues or nucleotides observed in the Multiple Sequence Alignment (MSA) used to construct the model. Mathematically, the emission probability $e_i(x)$ for observing residue $x$ at position $i$ in the alignment is calculated as:

$e_i(x) = \frac{{\text{{Count of residue }} x \text{{ at position }} i}}{{\text{{Total count of residues at position }} i}}$.

Here, $i$ represents the position in the alignment, and $x$ represents a specific amino acid or nucleotide. The count of residue $x$ at position $i$ is divided by the total count of residues at position $i$ to normalize the probability. Emission probabilities reflect the amino acid composition of each column in the MSA. Uneavenly distributed emission probabilities indicate positions that are more conserved, where a specific amino acid or nucleotide is frequently observed across sequences in the alignment. Conversely, evenly distributed emission probabilities suggest positions with more variability, where multiple residues or nucleotides may be present.

### Transition Probabilities

Transition probabilities in a Profile HMM govern the likelihood of transitioning between different states within the model. These probabilities capture the patterns of insertions, deletions, and matches observed in the MSA. Mathematically, the transition probability $t_{ij}$ from state $i$ to state $j$ is calculated as:

$t_{ij} = \frac{{\text{{Count of transitions from state }} i \text{{ to state }} j}}{{\text{{Total count of transitions from state }} i}}$

Here, $i$ and $j$ represent different states in the model, such as match, insertion, or deletion states. The count of transitions from state $i$ to state $j$ is divided by the total count of transitions originating from state $i$ to normalize the probability. Transition probabilities reflect the probabilities of insertions, deletions, and matches within the MSA. Higher transition probabilities between match states indicate regions of sequence conservation, where consecutive residues are more likely to align without gaps. Conversely, higher transition probabilities from match states to insertion or deletion states suggest regions with more variability, where insertions or deletions are common. By capturing these probabilities, Profile HMMs effectively model the indel patterns observed in the alignment.

## Sequence Alignment with Profile HMMs using Viterbi Algorithm

The Viterbi algorithm, adapted for Profile Hidden Markov Models (Profile HMMs), efficiently aligns sequences to the model. Here's a concise breakdown of the process:

### Overview:

Given a Profile HMM and a query sequence, the Viterbi algorithm identifies the most probable alignment between the sequence and the model. This alignment accounts for matches, insertions, and deletions.

#### Steps:

1. **Initialization:**
   - Initialize the first column of the Viterbi matrix with the emission probabilities for the first residue of the sequence in each match state.
   - The formula for initialization:
     $ V(1, M_i) = e_1(x) $

2. **Recursion:**
   - Iterate through each residue in the sequence, updating the Viterbi matrix based on transition and emission probabilities.
   - Update each cell in the Viterbi matrix using the following formula:
     $ V(i, M_j) = \max_k [V(i-1, M_k) \cdot t_{kj} \cdot e_i(x)] $  
     $ V(i, I_j) = \max_k [V(i-1, M_k) \cdot t_{kj} \cdot e_i(x)] $  
     $ V(i, D_j) = \max_k [V(i-1, D_k) \cdot t_{kj}] $

3. **Termination:**
   - Once the entire sequence has been processed, identify the highest probability in the last column of the Viterbi matrix. This represents the likelihood of the most probable path through the model.

4. **Backtracking:**
   - Trace back through the Viterbi matrix, starting from the cell with the highest probability in the last column. Record the path through the model that corresponds to this maximum probability.

5. **Alignment:**
   - Translate the identified path into an alignment between the query sequence and the Profile HMM, where match states represent aligned residues, insertion states represent gaps in the query sequence, and deletion states represent gaps in the model.
