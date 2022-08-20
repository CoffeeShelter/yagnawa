import pandas as pd
import json

from nutrient import *
from Product import *


class ServiceProvided:
    def __init__(self):
        pass

    @staticmethod
    def convertInformation(data: tuple):
        dataFrame = pd.DataFrame(data)
        productList = []

        if dataFrame is None:
            return []

        for i in range(len(dataFrame)):
            product = Product()

            if dataFrame.loc[i] is None:
                continue
            
            productName = dataFrame.loc[i]['PRDLST_NM'],
            componyName = dataFrame.loc[i]['BSSH_NM'],
            functionally = dataFrame.loc[i]['PRIMARY_FNCLTY'],
            contents = dataFrame.loc[i]['STDR_STND']

            product.setProduct(
                productName=productName,
                componyName=componyName,
                functionally=functionally,
                contents=contents,
            );

            productList.append(product)

        json_string = ServiceProvided.convertJsonData(productList)

        return json_string

    @staticmethod
    def convertJsonData(data):
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