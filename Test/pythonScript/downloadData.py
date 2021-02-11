#! python3
import os
import requests
source = requests.get('https://data.cdc.gov/api/views/hk9y-quqm/rows.csv?accessType=DOWNLOAD')
source.raise_for_status()
os.chdir(r'C:\Users\Ruslan\Desktop\Revature_training\day22_Git_demo\CovidData')
covidFile=open('CovidFile.csv','wb')
for chunk in source.iter_content(100000):
	covidFile.write(chunk)
covidFile.close()
