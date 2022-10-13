

from posixpath import split
from tokenize import String


class Product():
    SAMPLE = ['e291a0', 'e291a1', 'e291a2', 'e291a3', 'e291a4',
              'e291a5', 'e291a6', 'e291a7', 'e291a8', 'e291a9']

    def __init__(self):
        self.productCode = ''
        self.productName = ''
        self.componyName = ''
        self.functionally = ''
        self.contents = ''

    def setProduct(self, productCode, productName, componyName, functionally, contents):
        self.productCode = str(productCode[0])
        self.productName = str(productName[0])
        self.componyName = str(componyName[0])
        self.functionally = self.formattingFunctionally(str(functionally[0]))
        self.contents = str(contents)

        self.formattingContents(str(contents))

        # print(f'[str(functionally[0])]: {str(functionally[0])}')

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

        if '\n' in contents:
            temp = contents.split('\n')

        print(temp)


"""
①면역력 증진②피로개선③혈소판 응집 억제를 통한 혈액흐름에 도움④기억력 개선⑤항산화에 도움을 줄 수 있음
"""
