# The present and future status of open government data

The report is in the .pdf file in the main folder. I know I should do a makefile, but for now, in order to recreate it:

1. Run `google-search.py` (good luck not getting blocked by Google)
2. Cure the results into `data/dataportals.csv` indicating the result number that correspond to the portal
3. Run `scarp-wayback-machine.R`
4. Run `process_scrapping_results.R`
5. Knit `open_data_history.Rmd`

Fernando