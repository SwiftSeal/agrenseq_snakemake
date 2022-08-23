# AgRenSeq Snakemake pipeline

AgRenSeq requires several intermediate steps - this pipeline consolidates this into a single process allowing the user to quickly adjust input files or parameters.
Currently, this pipeline uses the java AgRenSeq version, as the python GLM-approach is not usable.

## Setup

This pipeline uses conda to contain certain processes and ensure replicability across different systems.
The pipeline has been tested with a conda base environment with the following installations: 
```
Python 3.10.5
Cookiecutter 2.1.1
Snakemake 7.12.1
```

Other dependencies are handled via Snakemake.

## Usage

All inputs and parameters are handled in the config/ directory.
config.yaml currently takes two options, `read_scores` which contains the relative path of `read_scores.txt` to the base directory, and `assembly which contains the relative path to the `.fasta` file of contigs you wish to use as a reference.

`read_scores.txt` is a tab separated file with four columns, `sample R1 R2 score`.
Each row contains the name, *absolute path* to illumina .fastq.gz R1, R2, and phenotype score for each accession passed into the AgRenSeq pipeline.
This pipeline assumes reads have been trimmed and quality filtered. (will fix this soon)

Certain parameters specific to the crop diversity HPC SLURM system are hardcoded in the snakemake rules, these may need to be adjusted.

To run the full pipeline:

`snakemake --use-conda --profile /path/to/your/cluster/profile --jobs max_number_of_simultaneous_jobs`

the `--profile` should be created via cookiecutter with default options.

Results are contained with two directories, `images/` and `results/`.
In results, `AgRenSeqResult.txt` is the final output of AgRenSeq, `output.nlr.txt` is a list of contigs associated with nlr motifs, and `jellyfish/` cotains the `.dump` files for each accession in `read_scores.txt`.
`images/` will contain a basic plot of the AgRenSeq results`.

A `logs/` directory will be created and populated with logs of certain processes.
