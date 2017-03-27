library(rvest)

archive1 <- read_html("https://web.archive.org/web/*/http://www.open.data.al/")

html_node(archive1, "#sparklineImgId") %>%
	html_attr("src") %>%
	stringr::str_split("_") %>%
	unlist()
