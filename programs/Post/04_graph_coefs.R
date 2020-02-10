# Make coefficient table a bit wider, and graph
# Lars Vilhuber
# 2020-02-09


source(here::here("programs","Post","config.R"),echo=TRUE)

library(ggplot2)
#library(arm) # for coefplot
library(stringi)
library(RColorBrewer)

# Set test to TRUE for testing (no saving)

test <- FALSE

all_reg_coeffs <- readRDS(file.path(datadir,paste0("all_reg_coeffs",".Rds")))

graph_regs <- all_reg_coeffs %>%
  pivot_wider(names_from = "type",values_from = "value",values_fn = list(value = as.numeric))

# Not working too well
# coefplot(graph_regs$estimate,graph_regs$stderr,varnames=graph_regs$name)

if ( test ) { 
  display.brewer.all()
  display.brewer.pal(n=4, name="Paired")
  brewer.pal(n=4,name="Paired")
}
# normalize by the confidential value
normalize <- graph_regs %>% filter(synthetic == FALSE) %>% 
  dplyr::select(-synthetic) %>%
  dplyr::rename(conf_estimate = estimate,conf_stderr = stderr)
graph_regs %>%
  left_join(normalize) -> tmp_graph_regs

# Two variants
# - Normalized, for graphing
tmp_graph_regs %>%
  mutate(norm_estimate = (estimate - conf_estimate),
         std_estimate = abs(norm_estimate )/ conf_stderr) %>%
  mutate(model_name = stri_join(model, sector,sep=", "),
         sector_country = stri_join(country, sector, sep=", ")) %>%
  dplyr::select(-conf_stderr) %>%
  mutate(synth = if_else(synthetic,"Synthetic","Confidential"))   -> graph_regs_normalized

# - Wide, for table
tmp_graph_regs %>%
  filter(synthetic == TRUE) -> graph_regs_wide
mysave(graph_regs_wide)

# Now describe graphically the results
graph_regs_normalized %>%
  filter(name=="AR(1) Coefficient") %>%
  ggplot(aes(model, norm_estimate)) + 
  coord_flip() +
  geom_hline(yintercept=0, lty=2, lwd=1, colour="grey50") +
  geom_errorbar(aes(ymin=norm_estimate - 1.96*stderr, ymax=norm_estimate + 1.96*stderr), 
                lwd=1, colour="#1F78B4", width=0) +
  geom_errorbar(aes(ymin=norm_estimate - stderr, ymax=norm_estimate + stderr), 
                lwd=2.5, colour="#B2DF8A", width=0) +
  geom_point(aes(color=as.factor(synth),shape=as.factor(synth)),size=2) +
  scale_color_manual(values = c("#B2DF8A","#1F78B4")) +
  scale_shape_manual(values=c(16,17,15,18))+
  theme_bw() + 
  theme(legend.title = element_blank()) + labs(x = element_blank(),y="Normalized estimate") +
  facet_grid(. ~ sector_country)  -> fig.estimates1
ggsave(file.path(figuredir,"fig.estimates1.png"),plot = fig.estimates1,width = 8,units="in",height = 2)


# Now describe graphically the results - ALTERNATe
graph_regs_normalized %>%
  filter(name=="AR(1) Coefficient") %>%
  ggplot(aes(model, norm_estimate)) + 
  coord_flip() +
  geom_hline(yintercept=0, lty=2, lwd=1, colour="grey50") +
  geom_point(aes(color=as.factor(synth),shape=as.factor(synth)),size=2) +
  scale_color_manual(values = c("#B2DF8A","#1F78B4")) +
  scale_shape_manual(values=c(16,17,15,18))+
  theme_bw() + 
  theme(legend.title = element_blank()) + labs(x = element_blank(),y="Normalized estimate") +
  facet_grid(. ~ sector_country)  -> fig.estimates2
ggsave(file.path(figuredir,"fig.estimates2.png"),plot = fig.estimates2,width = 8,units="in",height = 2)


# Now describe graphically the results - ALTERNATe
graph_regs_normalized %>%
  filter(name %in% c("AR(1) Coefficient","Ln Pay")) %>%
  filter(synthetic == TRUE) %>%
  ggplot(aes(model, norm_estimate)) + 
  coord_flip() +
  geom_hline(yintercept=0, lty=2, lwd=1, colour="grey50") +
  geom_point(aes(color=as.factor(name),shape=as.factor(name)),size=2) +
  scale_color_manual(values = brewer.pal(n = 4,name="Paired")) +
  scale_shape_manual(values=c(16,17,15,18))+
  theme_bw() + 
  theme(legend.title = element_blank()) + labs(x = element_blank(),y="Normalized estimate") +
  facet_grid(. ~ sector_country)  -> fig.estimates3
ggsave(file.path(figuredir,"fig.estimates3.png"),plot = fig.estimates3,width = 8,units="in",height = 2)

# Now describe graphically the results - standardized
graph_regs_normalized %>%
  filter(name %in% c("AR(1) Coefficient","Ln Pay")) %>%
  filter(sector != "Private") %>%
  filter(synthetic == TRUE) %>%
  ggplot(aes(model, std_estimate)) + 
  coord_flip() +
  geom_hline(yintercept=0, lty=2, lwd=1, colour="grey50") +
  geom_point(aes(color=as.factor(name),shape=as.factor(name)),size=2) +
  scale_color_manual(values = brewer.pal(n = 4,name="Paired")) +
  scale_shape_manual(values=c(16,17,15,18))+
  theme_bw() + 
  theme(legend.title = element_blank()) + labs(x = element_blank(),y="Standardized estimate") +
  facet_grid(. ~ sector_country)  -> fig.estimates4
ggsave(file.path(figuredir,"fig.estimates4.png"),plot = fig.estimates4,width = 8,units="in",height = 2)

