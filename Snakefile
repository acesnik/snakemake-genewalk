(CLUSTERS,) = glob_wildcards("{cluster}.txt")

rule all:
    input: expand("output/{cluster}/genewalk_results.csv", cluster=CLUSTERS)

rule genewalk:
    input: "{cluster}.txt"
    output: "output/{cluster}/genewalk_results.csv"
    log: "logs/{cluster}.log"
    benchmark: "output/{cluster}.benchmark"
    threads: 4
    shell:
        "genewalk --genes {wildcards.cluster}.txt "
        "--id_type hgnc_symbol --base_folder output --nproc {threads} "
        "--project {wildcards.cluster} &> {log}"
