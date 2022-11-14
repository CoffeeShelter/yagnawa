import cv2
import pytesseract

from PIL import Image

pytesseract.pytesseract.tesseract_cmd = R'C:\Program Files\Tesseract-OCR\tesseract'


def roi(img, startDx, startDy, endDx, endDy):
    output = img
    output = cv2.rotate(img, cv2.ROTATE_90_COUNTERCLOCKWISE)
    output = output[int(startDy):int(endDy), int(startDx):int(endDx)]

    # output = cv2.cvtColor(output, cv2.COLOR_BGR2RGB)

    cv2.imwrite('uploads/result.png', output)

    resultText = pytesseract.image_to_string(output, lang='eng')
    print(f'[OCR 결과]: {resultText}')

    return resultText
