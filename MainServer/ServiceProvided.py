import pandas as pd
import json

from nutrient import *
from Product import *


class ServiceProvided:
    def __init__(self):
        pass

    @staticmethod
    def convertInformation(data: tuple, only=False):
        if only:
            dataFrame = pd.DataFrame([data])

            product = Product()

            if dataFrame.loc[0] is None:
                return ''
            
            productCode = dataFrame.loc[0]['PRDLST_REPORT_NO'],
            productName = dataFrame.loc[0]['PRDLST_NM'],
            componyName = dataFrame.loc[0]['BSSH_NM'],
            functionally = dataFrame.loc[0]['PRIMARY_FNCLTY'],
            contents = dataFrame.loc[0]['STDR_STND']

            product.setProduct(
                productCode=productCode,
                productName=productName,
                componyName=componyName,
                functionally=functionally,
                contents=contents,
            );

            json_string = ServiceProvided.convertJsonData(product, only=only)

        else:
            dataFrame = pd.DataFrame(data)

            productList = []

            if dataFrame is None:
                return []

            for i in range(len(dataFrame)):
                product = Product()

                if dataFrame.loc[i] is None:
                    continue
                
                productCode = dataFrame.loc[i]['PRDLST_REPORT_NO'],
                productName = dataFrame.loc[i]['PRDLST_NM'],
                componyName = dataFrame.loc[i]['BSSH_NM'],
                functionally = dataFrame.loc[i]['PRIMARY_FNCLTY'],
                contents = dataFrame.loc[i]['STDR_STND']

                product.setProduct(
                    productCode=productCode,
                    productName=productName,
                    componyName=componyName,
                    functionally=functionally,
                    contents=contents,
                );

                productList.append(product)


                json_string = ServiceProvided.convertJsonData(productList, only=only)

        return json_string

    @staticmethod
    def convertJsonData(data, only=False):
        json_string = ''
        
        if only:
            json_string = json.dumps(
                data.__dict__,
                ensure_ascii=False,
            )
        else:
            json_string = json.dumps(
                [product.__dict__ for product in data],
                ensure_ascii=False,
            )

        return json_string

"""
if __name__ == "__main__":
    nutrient = Nutrient()
    nutrient.connectDatabase()
    nutrient.createCursor()
    result = nutrient.getProductsInfo('비타민')

    data = ServiceProvided.convertInformation(data=result)
"""