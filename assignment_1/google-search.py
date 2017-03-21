import csv
import os.path
from google import google
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

countries = list([])
with open('./data/countriesoftheworld.csv', 'rb') as countriesoftheworld:
    countrylist = csv.reader(countriesoftheworld)
    for row in countrylist:
        countries.append(row[0])

countries.pop(0)

num_page = 1
for country in countries:
    output_file = './data/google_search_results/'+country+'.csv'
    if not(os.path.exists(output_file)):
        search_results = google.search("Open data "+country, num_page)
        if len(search_results) > 0:
            search_results_list = [[str(country),
              str(search_results[x].name),
              str(search_results[x].link),
              str(search_results[x].description)]
              for x in range(0,len(search_results))]
            with open(output_file, 'wb') as output_csv:
                writer = csv.writer(output_csv)
                writer.writerows(search_results_list)
