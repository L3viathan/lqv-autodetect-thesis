library(ggplot2)
library(reshape2)
library(plyr)
levi <- read.csv("0.csv")
mevi <- read.csv("0,5.csv")
nevi <- read.csv("1.csv")

# Melting 4 columns to 2
levi <- melt(levi, id.vars = "threshold")
mevi <- melt(mevi, id.vars = "threshold")
nevi <- melt(nevi, id.vars = "threshold")
# Specifiying IDs per dataset
levi$category <- "Unigram"
mevi$category <- "Unigram+Bigram"
nevi$category <- "Bigram"
# Merging levi, mevi, nevi to lmnevi
lmevi  <- rbind(levi, mevi)
lmnevi <- rbind(lmevi, nevi)
# 3 plots for 3 things, selecting all the "thing" rows from the dataset for each plot
p <- ggplot(data = lmnevi[lmnevi$variable == "p", ], aes(x = threshold, y = value))
p <- p + geom_line(aes(colour = category))
p <- p + labs(x = "Threshold", y = "%", title = "Precision", colour = "")
ggsave(plot = p, filename = "p.png")
p <- ggplot(data = lmnevi[lmnevi$variable == "r", ], aes(x = threshold, y = value))
p <- p + geom_line(aes(colour = category))
p <- p + labs(x = "Threshold", y = "%", title = "Recall", colour = "")
ggsave(plot = p, filename = "r.png")
p <- ggplot(data = lmnevi[lmnevi$variable == "f", ], aes(x = threshold, y = value))
p <- p + geom_line(aes(colour = category))
p <- p + labs(x = "Threshold", y = "%", title = "F-Score", colour = "")
ggsave(plot = p, filename = "f.png")

p <- ggplot()
p <- p + geom_line(data = lmnevi[lmnevi$variable == "f", ], aes(x = threshold, y = value, colour = category), size = 1)
p <- p + geom_line(data = lmnevi[lmnevi$variable == "r", ], aes(x = threshold, y = value, colour = category))
p <- p + geom_line(data = lmnevi[lmnevi$variable == "p", ], aes(x = threshold, y = value, colour = category), linetype = 2)
p <- p + labs(x = "Threshold", y = "%", title = "Precision vs. Recall tradeoff", colour = "")
ggsave(plot = p, filename = "a.png")