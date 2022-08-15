import pandas as pd
from nutrient import Nutrient


class ServiceProvided:
    def __init__(self):
        pass

    @staticmethod
    def convertInformation(data: tuple) -> pd.DataFrame:
        dataFrame = pd.DataFrame([data])
        return dataFrame


if __name__ == "__main__":
    nutrient = Nutrient()
    nutrient.connectDatabase()
    nutrient.createCursor()
    result = nutrient.getProductInfo('2018001205620')\

    data = ServiceProvided.convertInformation(data=result)
    data
