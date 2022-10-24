import cv2
import pytesseract

from PIL import Image

pytesseract.pytesseract.tesseract_cmd = R'C:\Program Files\Tesseract-OCR\tesseract'


def roi(img, startDx, startDy, endDx, endDy):
    output = img[int(startDy):int(endDy), int(startDx):int(endDx)]

    output = cv2.cvtColor(output, cv2.COLOR_BGR2RGB)

    resultText = pytesseract.image_to_string(output)
    
    return resultText
