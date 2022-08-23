rule plot:
	input:
		"results/AgRenSeqResult.txt"
	output:
		"images/AgRenSeq_plot.png"
	log:
		"logs/plot/plot.log"
	conda:
		"../envs/plot.yaml"
	threads:
		1
	resources:
		mem_mb=1000,
		partition="short"
	shell:
		"Rscript --vanilla workflow/scripts/plot.R {input} {output} 2> {log}"
