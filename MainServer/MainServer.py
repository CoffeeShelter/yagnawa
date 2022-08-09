from flask import Flask, request, jsonify
from nutrient import Nutrient
"""
from Certified_Mark_Detection_Program import load_image_into_numpy_array, input_image_to_white_matrix, run_inference_for_single_image, getResultImage, getClassName
import base64
import os
import io
import tensorflow as tf
from PIL import Image
"""
import nutrient
import pandas as pd

app = Flask(__name__)
"""
# Path to frozen detection graph. This is the actual model that is used for the object detection.
PATH_TO_FROZEN_GRAPH = './certified_mark_model/output_inference_graph_v1/frozen_inference_graph.pb'

# List of the strings that is used to add correct label for each box.
PATH_TO_LABELS = os.path.join(os.getcwd(), './certified_mark_model/label_map.pdtxt')

# ## Load a (frozen) Tensorflow model into memory.
detection_graph = tf.Graph()
with detection_graph.as_default():
    od_graph_def = tf.GraphDef()
    with tf.gfile.GFile(PATH_TO_FROZEN_GRAPH, 'rb') as fid:
        serialized_graph = fid.read()
        od_graph_def.ParseFromString(serialized_graph)
        tf.import_graph_def(od_graph_def, name='')

@app.route('/detection/mark', methods=['POST'])
def detection_mark():
    data = request.get_json()
    imageData = data['image']['data']

    image = base64.b64decode(imageData)
    image = Image.open(io.BytesIO(image))
    image_np = load_image_into_numpy_array(image)

    width, height, channel = image_np.shape

    # 입력 이미지 전처리 ( 해상도 변경 ( 1400 x 1400 ))
    image_np = input_image_to_white_matrix(image_np, 1400, 1400)

    # 인증마크 탐지 결과 얻기
    output_dict = run_inference_for_single_image(image_np, detection_graph)
    result_image = getResultImage(image_np, output_dict)
    result_image = result_image[0:width, 0:height]

    return getClassName(output_dict)[0]
"""

"""
요청 URL : /products/<상품명>
요청 메서드 : GET
반환 : 상품 목록
"""


@app.route('/products/<productName>', methods=['GET'])
def getProducts(productName):
    nutrient = Nutrient()
    nutrient.connectDatabase()
    nutrient.createCursor()
    result = nutrient.getProductsInfo(productName)
    result = pd.DataFrame(result)

    result = result.to_json(orient='records')

    response = app.response_class(
        response=result,
        mimetype='application/json',
    )

    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Content-Type'] = 'application/json'
    response.headers['charset'] = 'utf-8'

    return response


"""
요청 URL : /product/<상품 코드>
요청 메서드 : GET
반환 : 단일 상품
"""


@app.route('/product/<productID>', methods=['GET'])
def getProduct(productID):
    nutrient = Nutrient()
    nutrient.connectDatabase()
    nutrient.createCursor()
    result = nutrient.getProductInfo(productID)

    # print(result)

    result = pd.DataFrame(result)

    result = result.to_json(orient='columns')

    response = app.response_class(
        response=result,
        mimetype='application/json',
    )

    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Content-Type'] = 'application/json'
    response.headers['charset'] = 'utf-8'

    return response


if __name__ == "__main__":
    app.run(
        host='0.0.0.0'
    )

# image = Image.open(filePath)
# image_np = load_image_into_numpy_array(image)
