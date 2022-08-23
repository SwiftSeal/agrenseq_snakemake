library(ggplot2)

args = commandArgs(trailingOnly=TRUE)

agrenseq <- read.table(args[1], sep="\t")

p <- ggplot(data = agrenseq, aes(x = V2, y = V3, size = V4)) +
  geom_point() +
  xlab("Contig") +
  ylab("Association score") +
  labs(size="Kmers") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        panel.border = element_rect(color = "black", fill = NA),
        axis.line = element_line(colour = "black"),
        legend.key = element_blank())

ggsave(args[2], width = 5, height = 2)
