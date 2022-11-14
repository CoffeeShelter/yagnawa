import os
import re

class Product():
    SAMPLE = ['e291a0', 'e291a1', 'e291a2', 'e291a3', 'e291a4',
              'e291a5', 'e291a6', 'e291a7', 'e291a8', 'e291a9']
    EXTRA = ['성상', '납', '카드뮴', '수은', '대장균', '붕해', '헥산', '비소', '세균', '메탄올']
    MAIN_CONTENT = [
        '진세노사이드', '루테인', 'EPA+DHA', '비타민 C',
        '비타민D', '비타민B2', '비타민B1', '비타민B6', '비타민A', '망간',
        '판토텐산', '셀레늄', '아연', '나이아신', '비타민E', '지아잔틴',
        '루테인', '비타민C', 'EPA', '모나콜린', '프로바이오틱스',
        '락추로스', '셀렌', 'DHA', '비타민', '지방족',
    ]
    RE = '[0-9]+[.,0-9]*[a-zA-Z\sα-]*\/[\s]*[0-9]+[.,0-9]*[a-zA-Z\s]*'

    def __init__(self):
        self.productCode = ''
        self.productName = ''
        self.componyName = ''
        self.functionally = []
        self.contents = []
        self.extra = []
        self.containContents = []
        self.marks = []
        self.image = ''
        self.recommended_products = []  # 추천 제품

        self.values = []    # 함량 수치
        self.totals = []    # 최대 함량 수치

    def setProduct(self, productCode, productName, componyName, functionally, contents):
        self.productCode = str(productCode[0])
        self.productName = str(productName[0])
        self.componyName = str(componyName[0])
        self.functionally = self.formattingFunctionally(str(functionally[0]))
        self.contents, self.extra, self.containContents, self.values, self.totals = self.formattingContents(
            str(contents))
        # self.contents = str(contents)
        if (os.path.isfile(f"./products_image/{self.productCode}.jpg")):
            self.image = f"http://211.59.155.207:8000/products_image/{self.productCode}.jpg"

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
        containContents = []
        values = []
        totals = []
        result = []

        check = False

        p = re.compile(Product.RE)

        if '\n' in contents:
            temp = contents.split('\n')

        while len(temp) > 0:
            content = temp.pop()
            check = False

            for x in Product.MAIN_CONTENT:
                if x in content:
                
                    regexResultList = p.findall(content)
                    if len(regexResultList) > 0:
                        regexResultString = regexResultList[0]
                        regexResultString.replace(' ', '')

                        splitData = regexResultString.split('/')
                        if len(splitData) == 2:
                            value = splitData[0]
                            total = splitData[1]

                            values.append(value)
                            totals.append(total)

                            print(f'{x}의 함량: {value} , 총: {total}')
                            result.append(content)
                            containContents.append(x)
                            check = True

                    break

            if check == False:
                extra.append(content)

        

        return result, extra, containContents, values, totals


"""
①면역력 증진②피로개선③혈소판 응집 억제를 통한 혈액흐름에 도움④기억력 개선⑤항산화에 도움을 줄 수 있음
"""
