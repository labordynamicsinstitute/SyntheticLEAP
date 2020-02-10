# Compute J_kt, for fun
# Lars Vilhuber
# 2020-02-09


source(here::here("programs","Post","config.R"),echo=TRUE)

library(stringi)
library(RColorBrewer)

test <- FALSE

graph_regs_wide <- readRDS(file.path(datadir,paste0("graph_regs_wide",".Rds")))

# Compute upper and lower bound of intervals (approximate)
graph_regs_wide %>%
  mutate(Lstar = estimate - 1.96*stderr,
         Ustar = estimate + 1.96*stderr,
         Lconf = conf_estimate - 1.96*conf_stderr,
         Uconf = conf_estimate + 1.96*conf_stderr,
         Uover = pmin(Ustar,Uconf),
         Lover = pmax(Lstar,Lconf),
         norm_estimate = (estimate - conf_estimate),
         std_estimate = abs(norm_estimate )/ conf_stderr,
         model_name = stri_join(model, sector,sep=", "),
         sector_country = stri_join(country, sector, sep=", "),
         Jkt = 0.5*( ( Uover - Lover)/(Uconf - Lconf) + (Uover - Lover)/(Ustar - Lstar))) -> graph_regs_jkt
         
mysave(graph_regs_jkt)

# summarize it
graph_regs_jkt %>%
  group_by(name) %>%
  summarize(mean_jkt = mean(Jkt,na.rm=TRUE),
            median_jkt = median(Jkt,na.rm=TRUE),
            max_jkt=max(Jkt,na.rm=TRUE)) %>%
  filter(!is.na(mean_jkt)) -> graph_regs_jkt_summary
mysave(graph_regs_jkt_summary)

graph_regs_jkt_summary

  
# Graph the standardized coefficients

graph_regs_jkt %>%
  filter(name %in% c("AR(1) Coefficient","Ln Pay")) %>%
  filter(sector != "Private") %>%
  ggplot(aes(model, Jkt)) + 
  coord_flip() +
  geom_hline(yintercept=0, lty=2, lwd=1, colour="grey50") +
  geom_point(aes(color=as.factor(name),shape=as.factor(name)),size=2) +
  scale_color_manual(values = brewer.pal(n = 4,name="Paired")) +
  scale_shape_manual(values=c(16,17,15,18))+
  theme_bw() + 
  theme(legend.title = element_blank()) + labs(x = element_blank(),y="Standardized estimate") +
  facet_grid(. ~ sector_country) -> fig.estimates5
ggsave(file.path(figuredir,"fig.estimates5.png"),plot = fig.estimates5,width = 8,units="in",height = 2)

# output the table

library(stargazer)

stargazer(graph_regs_jkt_summary,summary=FALSE,
          title = "Summary of Confidence Interval Overlaps",
          label = "tab:jkm",
          rownames=FALSE,out=file.path(tabledir,"table_jkm.tex"))



