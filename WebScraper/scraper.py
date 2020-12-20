from bs4 import BeautifulSoup
import requests
page = requests.get("https://en.wikipedia.org/wiki/Houseplant")
page

soup = BeautifulSoup(page.content, 'html.parser')

print(soup.prettify())