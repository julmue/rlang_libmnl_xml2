library(here)
library(xml2)


pg <- read_xml(here("data/ZMHO_02_20171012_101730.xml"))

recs <- xml_find_all(pg, "//Value")

vals <- trimws(xml_text(recs))

labs <- trimws(xml_attr(recs, "label"))

cols <- xml_attr(xml_find_all(pg, "//data/variables/*[self::categoricalvariable or
                                                      self::realvariable]"), "name")
dat <- do.call(rbind, lapply(strsplit(vals, "\ +"),
                             function(x) {
                               data.frame(rbind(setNames(as.numeric(x),cols)))
                             }))

dat$area_name <- labs

# 

