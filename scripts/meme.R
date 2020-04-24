## Credit https://github.com/ashten28/my_ggplots/tree/master/guy_checking_out_a_girl_meme

# load libraries
library(readr)
library(dplyr)
library(forcats)
library(ggplot2)
library(patchwork)

# read in data - manually created
data <-
  read_csv("../data/meme.csv") %>% 
  mutate(
    paint = fct_relevel(paint, c("black", "brown", "beige", "white", "black_2", "grey_2",  "red", "blue_2", "beige_3", "blue", "beige_2", "grey"))
    
  )

# start ggplot
p1 <- 
  ggplot(data) +
  # using geom_bar, so didnt cheat (though using geom_tile was much easier)
  geom_bar(
    mapping = aes(x = x, fill = paint),
    width = 1
  ) +
  # set colours for bars
  scale_fill_manual(
    values = c("#24211a", "#593326","#e4a095", "#ffffff", "#24211a", "#93a9b6", "#fa0107", "#0b59b3", "#e4a095", "#0b59b3", "#e4a095","#93a9b6")
  ) +
  # make grid squares
  coord_equal() +
  # coord_polar() +
  # add themes
  theme_bw() +
  theme(
    legend.position = "none",
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.text  = element_blank(),
    panel.grid = element_blank()
  )

# customized legend - create data to be plotted to look like a legend (not recommended)
legend_data <-
  data.frame(
    x = 0,
    y = c(4, 6, 8, 10, 12),
    label = c("Learning a new\npackage without\nrealworld application", "", "Me", "", "Doing useful\ndata analysis")
  )

# start ggplot for custom legend
p2 <- 
  ggplot(
    data = legend_data,
    mapping = aes(x = x, y = y)
  ) +
  # using geom_tile to create filled boxes
  geom_tile(
    mapping = aes( fill = label),
    width = 0.4, height = 0.4,
  ) + 
  # using geom_text to place text beside tiles
  geom_text(
    mapping = aes(label = label),
    size = 6,
    nudge_x = 0.4,
    nudge_y = 0,
    hjust = 0,
    vjust = 0.5
  ) + 
  scale_fill_manual(
    values = c("#ffffff", "#93a9b6", "#fa0107", "#0b59b3")
  ) +
  # setting scales to look better/ coord_fixed to make plot narrower
  scale_x_continuous(limits = c(-0.5,7)) +
  scale_y_continuous(limits = c(1, 15)) +
  coord_fixed(ratio = 0.8) +
  # add themes
  theme_void() +
  theme(
    legend.position = "none"
  )

# using patchwork to combine main plot and custom legend
p <- p1 + p2
p
