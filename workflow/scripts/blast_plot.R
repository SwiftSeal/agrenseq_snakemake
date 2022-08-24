library(dplyr)
library(ggplot2)

args = commandArgs(trailingOnly = TRUE)

sizes <- read.table(args[1], sep = "\t") # chromosome sizes

bins = data.frame(chromosome=character(), x=integer()) # initialise bins

binsize = 1000000 # size of bins, it's in the name :-)

for(row in 1:nrow(sizes)){
  # welcome to hell!
  blast <- read.table(args[2], sep = "\t") # read in blast result
  x = seq(0, sizes$V2[row] + binsize, by = binsize) # make vector of bins for chromosome size
  blast <- blast[blast$V2 == sizes$V1[row], ] # filter blast by chromosome
  blast <- blast %>% mutate(bin = cut(V9, breaks = x, labels = FALSE)) # Create col 'bin' with bin ints
  x = data.frame(x) # turn bin vect into df?!?!
  x$n = 0 # initialise bin vals
  x$chromosome = sizes$V1[row] # give this chromsome a name
  for(i in blast$bin) {
    x[i, "n"] = x[i, "n"] + 1 # iterate through blast, enumerate n by bin int instance
  } 
  bins = rbind(bins, x) # slap x on the end of growing df
  rm(x) # tidy up for next loop
  rm(blast)
  # (I hate R)
}

bins$x = bins$x/1000000

p <- ggplot(bins, aes(x = x, y = n, col = chromosome)) +
  facet_grid(~chromosome, scales = "free_x", space = "free_x") +
  geom_ribbon(aes(ymin = 0, ymax = n, fill = chromosome)) +
  theme(panel.grid.minor = element_line(colour="white"),
        panel.grid.major = element_line(colour="white"),
        panel.background = element_rect(fill="white"),
        panel.spacing = unit(c(0.2),"cm"),
        legend.position="none",
        strip.background = element_blank(),
        strip.text.x = element_text(size = 10, hjust = 0.5),
        axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black"),
        axis.text.x = element_text(colour="grey20",size=8)) +
  scale_y_continuous(paste("R genes per", binsize/1000, "kb"), expand = c(0,0)) +
  scale_x_continuous(name="Physical location (Mb)")

ggsave(args[3], p, units="cm", width = 36, height = 12)
