library(magrittr)

country_history <- "./data/wayback_portal_history/" %>%
	list.files(full.names = T) %>%
	plyr::ldply(function(x){
		country <- basename(x) %>% tools::file_path_sans_ext()
		data.frame(Country = country, 
							 history = readLines(x, n = 1))
	})

country_history %<>%
	plyr::ddply("Country", function(x){
		lines <- x$history %>%
			stringr::str_split("_") %>% unlist()
		lines <- lines[grepl("\\:", lines)]
		snaps <- lines %>%
			stringr::str_split(":") %>%
			plyr::ldply(function(y){
				data.frame(year = as.numeric(y[1]),
									 month = 1:12, 
									 snapshots = unlist(stringr::str_split(y[3], ""))) %>%
					dplyr::mutate(snapshots = as.numeric(as.character(snapshots)))
			})
		start <- snaps[which.min(snaps$snapshots == 0), ]
		paste(start$year, start$month, 1, sep = "-") %>% as.Date()
	})


data_portals <- read.csv("./data/dataportals.csv") %>%
	plyr::ddply("Country", function(x) {
		country_results <- "./data/google_search_results/" %>%
			paste0(x$Country[1], ".csv") %>%
			read.csv(header = F)
		country_results[x$Position, ]
	}) %>%
	dplyr::select(-V1) %>%
	dplyr::rename(name = V2,
								address = V3, 
								description = V4)

data_portals %>%
	dplyr::left_join(country_history) %>% 
	# if it's not in wayback machine assume is new
	dplyr::mutate(V1	= dplyr::if_else(is.na(V1), as.Date("2017-01-01"), V1)) %>% 
	dplyr::rename(start_date = V1) %>%
	dplyr::right_join(read.csv("./data/dataportals.csv")) %>% 
	write.csv("./data/open_data_history.csv", row.names = F)
