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

One notable database of protein domain models is Pfam . Pfam and the HMMER software suite have been developed in parallel, providing comprehensive resources for protein families based on seed alignments.



### Structure of a Profile HMM

A Profile HMM is structured to mirror the columns of an MSA, with three main states for each column:

1. **Match States (M):** Represent conserved positions in the alignment, corresponding to columns with similar residues or nucleotides across multiple sequences. Match states store probabilities for each possible amino acid or nucleotide at that position, reflecting the distribution observed in the MSA.

2. **Insertion States (I):** Account for potential insertions between columns, capturing variability by allowing additional residues or nucleotides to be added. These states store probabilities for each possible amino acid or nucleotide to be inserted.

3. **Deletion States (D):** Represent positions where sequences may lack a corresponding residue or nucleotide, resulting in a gap in the alignment. Deletion states enable the model to handle varying lengths in sequences.

### Transition Probabilities

In addition to these states, Profile HMMs include transition probabilities between states, reflecting the likelihood of moving from one state to another. For example, a transition might occur from a match state to an insertion state, or from a match state directly to another match state. These transition probabilities reflect the patterns observed in the MSA and help the model capture sequence variability.

### Applications

Profile HMMs offer several key applications in bioinformatics:

1. **Sequence Alignment:** By comparing a new sequence to a profile HMM, we can identify which regions of the sequence correspond to conserved regions in the MSA, helping to align the new sequence with known homologs.

2. **Domain Detection:** Profile HMMs can identify and characterize functional domains in proteins by matching sequence segments to domain profiles.

3. **Sequence Classification:** By comparing a sequence to various profile HMMs, we can classify it into families or groups, aiding in the identification of evolutionary relationships.

### Conclusion

Profile HMMs provide a sophisticated way to model and analyze sequence alignments, capturing both conserved regions and sequence variability. They extend the capabilities of MSAs, allowing for deeper insights into sequence structures, functions, and relationships.

### Profile HMM Diagram

```{figure} ./img/phmm.png
:name: fig-profileHMM
:align: left
:width: 100%

A state diagram of a profile HMM with 4 match states.
```
