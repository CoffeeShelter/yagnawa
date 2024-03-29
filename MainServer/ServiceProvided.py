import pandas as pd
import json

from Nutrient import *
from Product import Product


class ServiceProvided:
    def __init__(self):
        pass

    @staticmethod
    def convertInformation(data: tuple, only=False):
        json_string = ''

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
            )
            if len(product.containContents) > 0:
                nutrient = Nutrient()
                result = nutrient.getRecoProducts(product.containContents[0])
                result = ServiceProvided.convertInformation(
                    data=result, only=False)
                product.recommended_products = result

            # json_string = ServiceProvided.convertJsonData(product, only=only)

            return product.__dict__

        else:
            dataFrame = pd.DataFrame(data)

            productList = []

            if dataFrame is None:
                return []

            for i in range(len(dataFrame)):
                if i > 10:
                    break

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
                )

                productList.append(product.__dict__)

            return productList

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
