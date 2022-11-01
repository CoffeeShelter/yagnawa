from itertools import product
from time import time
import requests
from bs4 import BeautifulSoup

from selenium import webdriver
import time

class Crawler:
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"
    }
    def __init__(self):
        pass

    @staticmethod
    def getNetImage(productName):
        query = productName.replace(' ', '+')
        res = requests.get(f'https://browse.gmarket.co.kr/search?keyword={query}', headers=Crawler.headers)
        soup = BeautifulSoup(res.content, 'html.parser')

        net_image = soup.select('div.box__item-container > div.box__image > a')

        if len(net_image) > 0:
            link = net_image[0]['href']
            res = requests.get(link, headers=Crawler.headers)
            soup = BeautifulSoup(res.content, 'html.parser')

            # net_image = soup.select('#container > div.item-topinfowrap > div.thumb-gallery > div.box__viewer-container > ul.viewer > li > a > img')
            net_image = soup.select('div.box__viewer-container > ul > li.on > a > img')

            if len(net_image) > 0:
                imgLink = net_image[0]['src']

                return imgLink
        
        return ''

if __name__ == '__main__':
    str = Crawler.getNetImage('농협 6년근 고려 100년 홍삼정스틱 천')
    print(str)