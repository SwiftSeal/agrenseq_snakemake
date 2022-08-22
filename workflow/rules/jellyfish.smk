rule jellyfish:
        input:
                get_reads
        output:
                jf=temp("results/jellyfish/{sample}.jf"),
		dump="results/jellyfish/{sample}.dump"
        threads:
                4
        resources:
                mem_mb=16000,
                partition="short"
        conda:
                "../envs/jellyfish.yaml"
        shell:
                """
		zcat {input} | jellyfish count /dev/fd/0 -C -m 51 -s 1G -t 4 -o {output.jf} 
		jellyfish dump -L 10 -ct {output.jf} > {output.dump}
		"""
