library(rvest)
library(magrittr)

data_portals <- read.csv("./data/dataportals.csv")

data_portals %<>%
	plyr::ddply("Country", function(x) {
		country_results <- "./data/google_search_results/" %>%
			paste0(x$Country[1], ".csv") %>%
			read.csv(header = F)
		country_results[x$Position, ]
	})

for(i in 1:nrow(data_portals)){
	message("processing ", data_portals$Country[i])
	portal_file <-"./data/wayback_portal_history/" %>%
		paste0(data_portals$Country[i], ".txt")
	if(!file.exists(portal_file)){
		tryCatch({
			portal_history <- "https://web.archive.org/web/*/" %>%
				paste0(as.character(data_portals$V3[i])) %>%
				read_html() %>%
				html_node("#sparklineImgId") %>%
				html_attr("src")
			writeLines(portal_history, portal_file)
		}, error = function(e) return(NA))
		
		Sys.sleep(1)  # so that we don't get blocked
	}
}
