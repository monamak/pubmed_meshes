# _________________ get pmids in html

from bs4 import BeautifulSoup
import csv
import time
import requests
import pandas as pd
import requests
from bs4 import BeautifulSoup
# the link with the query: https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pmc&retmax=10&mindate=2015/01/01&maxdate=2021/12/31&term=claims||EHR||claim||administrative%20claims||electronic%20health%20records||electronic%20health%20record||EMR||electronic%20medical%20record||electronic%20medical%20records||real-world%20safety||real-world%20safety||real-world%20effectiveness||real-world%20effectiveness||RWE||RWD||real-world||real-world

import requests
from bs4 import BeautifulSoup as bs

def get_tag_from_url(url, tag='id'):
    soup = bs(requests.get(url).content, "html.parser")
    data_set = soup.find_all(tag)
    return data_set
  
mylist = get_tag_from_url('https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pmc&retmax=1500000&mindate=2015/01/01&maxdate=2021/12/31&term=claims||EHR||claim||administrative%20claims||electronic%20health%20records||electronic%20health%20record||EMR||electronic%20medical%20record||electronic%20medical%20records||real-world%20safety||real-world%20safety||real-world%20effectiveness||real-world%20effectiveness||RWE||RWD||real-world||real-world', tag='id')
mylist[:10]

import re
x = '<id>5659546</id>'
re.sub("[^0-9]", "", x)

mylist2 = [re.sub("[^0-9]", "", str(x)) for x in mylist]
mylist2[:10]

my_df = pd.DataFrame([mylist2])
my_df.head()
my_df.T.to_csv('C:/Users/Mona/Downloads/my_csv.csv', index=False, header=True)

