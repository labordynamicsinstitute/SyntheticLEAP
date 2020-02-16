# Graph the confidentiality measure
# Lars Vilhuber
# 2020-02-15


source(here::here("programs","Post","config.R"),echo=TRUE)

library(ggplot2)
library(stringi)
library(RColorBrewer)

test <- TRUE

if ( test ) { 
  display.brewer.all()
  display.brewer.pal(n=4, name="Paired")
  brewer.pal(n=4,name="Paired")
}

subfile <- "private"

readconf <- function(subfile,countryin,sectorin) {
mytable <- read.csv(file.path(tabledir,
                               paste0("Observed_firm_births_given_synthetic_births_",subfile,".tex")),
                     sep="&",col.names = c("Synthetic","Actual","Minimum","Average","max"),
                     header = FALSE) %>%
  mutate(Maximum = as.numeric(str_replace_all(max,"\\\\","")),
         country = countryin,
         sector = sectorin) %>%
  select(-max)
  return(mytable)
}


conf.can.private <- readconf("private","Canada","Private")
conf.can.manuf   <- readconf("manufacturing","Canada","Manufacturing")
conf.ger         <- readconf("GsynLBD","Germany","Universe")

conf.table <- bind_rows(conf.can.private,conf.can.manuf,conf.ger) %>%
  pivot_longer(cols=c("Minimum","Average","Maximum"),names_to = c("Statistic"),values_to = c("Value"))  %>%
  group_by(country) 

# Now describe graphically the results - standardized
#   geom_line(yintercept=0, lty=2, lwd=1, colour="grey50") +
#   

conf.table %>%
  mutate(Year = Synthetic - min(Synthetic)) %>%
  filter(sector != "Manufacturing") %>%
  filter(Statistic != "Minimum") %>%
  ggplot(aes(Year, Value,color=Statistic,linetype=Statistic)) +
  geom_line() +
  facet_grid(rows=vars(country),) +
  #scale_color_brewer(palette = "Paired",direction = -1) +
  scale_color_manual(values = c("#1F78B4", "#33A02C")) +
  scale_shape_manual(values=c(16,17,15,18))+
  theme_bw() +
  theme(legend.title = element_blank(),legend.position = "bottom") + 
  labs(x = element_blank(),y=element_blank()) -> fig.conf.both
ggsave(file.path(figuredir,"fig_conf_both.png"),plot = fig.conf.both,width = 6,units="in",height = 3)
