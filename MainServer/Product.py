import re

from Crawler import Crawler

class Product():
    SAMPLE = ['e291a0', 'e291a1', 'e291a2', 'e291a3', 'e291a4',
              'e291a5', 'e291a6', 'e291a7', 'e291a8', 'e291a9']
    EXTRA = ['성상', '납', '카드뮴', '수은', '대장균', '붕해', '헥산', '비소', '세균', '메탄올']
    MAIN_CONTENT = [
        '진세노사이드 Rg1, Rb1 및 Rg3 의 합', '루테인', 'EPA+DHA', '비타민 C',
        '비타민D', '비타민B2', '비타민B1', '비타민B6', '비타민A', '망간',
        '판토텐산', '셀레늄', '아연', '나이아신', '비타민E', '지아잔틴',
        '루테인', '비타민C', 'EPA와DHA의 합', '총 모나콜린 K', '프로바이오틱스 수',
        '락추로스', '셀렌'
    ]

    def __init__(self):
        self.productCode = ''
        self.productName = ''
        self.componyName = ''
        self.functionally = []
        self.contents = []
        self.extra = []
        self.marks = []
        self.image = ''

    def setProduct(self, productCode, productName, componyName, functionally, contents):
        self.productCode = str(productCode[0])
        self.productName = str(productName[0])
        self.componyName = str(componyName[0])
        self.functionally = self.formattingFunctionally(str(functionally[0]))
        self.contents, self.extra = self.formattingContents(str(contents))
        # self.contents = str(contents)
        self.image = Crawler.getNetImage(self.productName)

    def formattingFunctionally(self, functionally, debug=False):
        temp = []
        functionally = functionally.replace('\r', '')

        if '\n' in functionally:
            temp = functionally.split('\n')

        else:
            for sample in Product.SAMPLE:
                sampleString = bytes.fromhex(sample).decode('utf-8')
                if debug:
                    print(f'[Sample String]: {sampleString}')

                if sampleString in functionally:
                    splitData = functionally.split(sampleString)

                    temp.append(splitData[0])
                    temp = [v for v in temp if v]
                    if debug:
                        print(f'[Split Data]: {splitData}')
                        print(f'[temp]: {temp}')

                    if len(splitData) > 1:
                        functionally = splitData[1]
                else:
                    if debug:
                        print(f"[{sampleString}]은 [{functionally}] 에 없습니다.")

        for v in temp:
            if len(v) < 1:
                temp.remove(v)

        return temp

    def formattingContents(self, contents):
        temp = []
        extra = []
        result = []

        check = False

        if '\n' in contents:
            temp = contents.split('\n')

        while len(temp) > 0:
            content = temp.pop()
            check = False

            for x in Product.MAIN_CONTENT:
                if x in content:
                    result.append(content)
                    check = True
                    break

            if check == False:
                extra.append(content)

        return result, extra


"""
①면역력 증진②피로개선③혈소판 응집 억제를 통한 혈액흐름에 도움④기억력 개선⑤항산화에 도움을 줄 수 있음
"""
