rule matrix:
	input:
		matrix="results/output_matrix.txt",
		phenotype="phenotype.txt",
		nlr="nlr.txt",
		assembly="assembly.fasta"
	output:
		"results/AgRenSeqResult.txt"
	log:
		"logs/jellyfish/run_association.log"
	threads:
		1
	resources:
		mem_mb=1600,
		partition="short"
	conda:
		"../envs/agrenseq.yaml"
	shell:
		"java -jar workflow/scripts/AgRenSeq_RunAssociation.jar -i {input.matrix} -n {input.nlr} -p {input.phenotype} -a {input.assembly}-o {output} 2> {log}"
