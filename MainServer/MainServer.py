from flask import Flask, request, jsonify
from flask_cors import CORS

from nutrient import Nutrient
from Certified_Mark_Detection_Program import *
import base64
import os
import io
import tensorflow as tf
from PIL import Image

from werkzeug.utils import secure_filename

from ServiceProvided import *

import image_process

app = Flask(__name__)

UPLOAD_FOLDER = './uploads'

app = Flask(__name__)

CORS(app, resources={r'*': {'origins': '*'}})

#app.secret_key = "secret key"
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024

ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])


# Path to frozen detection graph. This is the actual model that is used for the object detection.
PATH_TO_FROZEN_GRAPH = './certified_mark_model/output_inference_graph_v1/frozen_inference_graph.pb'

# List of the strings that is used to add correct label for each box.
PATH_TO_LABELS = os.path.join(
    os.getcwd(), './certified_mark_model/label_map.pdtxt')

# 이미지 최대 크기
MAX_SIZE = 1400

# ## Load a (frozen) Tensorflow model into memory.
detection_graph = tf.Graph()
with detection_graph.as_default():
    od_graph_def = tf.GraphDef()
    with tf.gfile.GFile(PATH_TO_FROZEN_GRAPH, 'rb') as fid:
        serialized_graph = fid.read()
        od_graph_def.ParseFromString(serialized_graph)
        tf.import_graph_def(od_graph_def, name='')

nutrient = Nutrient()
nutrient.connectDatabase()
nutrient.createCursor()


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


@app.route('/products/<productName>', methods=['GET'])
def getProducts(productName):
    """
    건강기능식품 제품 목록 조회 함수
    요청 URL : /products/<제품 명>
    요청 메서드 : GET

    Args:
        productName (str): 제품 명

    Return:
        건강기능식품 제품 목록 Json형태로 반환

    """
    productName = productName.replace('%', '')
    productName = productName.replace('\'', '')
    productName = productName.replace('\n', '')

    result = nutrient.getProductsInfo(productName)
    result = ServiceProvided.convertInformation(result)

    response = jsonify(result)

    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Content-Type'] = '*/*'
    response.headers['charset'] = 'utf-8'

    response.status_code = 200

    return response


@app.route('/product/<productID>', methods=['GET'])
def getProduct(productID):
    """
    건강기능식품 제품 세부 정보 조회
    요청 URL : /product/<제품 코드>
    요청 메서드 : GET

    Args:
        productName (str): 제품 코드

    Return:
        건강기능식품 제품 세부 정보 Json형태로 반환
    """
    nutrient = Nutrient()
    nutrient.connectDatabase()
    nutrient.createCursor()

    result = nutrient.getProductInfo(productID)
    result = ServiceProvided.convertInformation(data=result, only=True)

    response = jsonify(result)

    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Content-Type'] = '*/*'
    response.headers['charset'] = 'utf-8'

    return response


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/image', methods=['POST'])
def getProductByImage():
    """
    건강기능식품 제품 세부 정보 조회
    요청 URL : /image
    요청 메서드 : POST

    Return:
        건강기능식품 제품 세부 정보 Json형태로 반환
    """
    marks = []
    details = []

    if 'files[]' not in request.files:
        resp = jsonify({'message': 'No file part in the request'})
        resp.status_code = 400
        return resp

    files = request.files.getlist('files[]')
    productName = request.form.get('productName')

    errors = {}
    success = False

    for file in files:
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            success = True

            image = Image.open(file).convert('RGB')

            image_np = load_image_into_numpy_array(image)

            width, height, channel = image_np.shape

            # 가로,세로 1400 이하로 전처리
            if width > 1400:
                image_np = cv2.resize(
                    image_np, (height, MAX_SIZE), interpolation=cv2.INTER_AREA)
            if height > 1400:
                image_np = cv2.resize(
                    image_np, (MAX_SIZE, width), interpolation=cv2.INTER_AREA)

            # 입력 이미지 전처리 ( 해상도 변경 ( 1400 x 1400 ))
            image_np = input_image_to_white_matrix(image_np, 1400, 1400)

            # 인증마크 탐지 결과 얻기
            output_dict = run_inference_for_single_image(
                image_np, detection_graph)
            result_image = getResultImage(image_np, output_dict)
            result_image = result_image[0:width, 0:height]

            if len(getClassName(output_dict)) > 0:
                marks = getClassName(output_dict)

            print({'mark': f'{marks}'})
        else:
            errors[file.filename] = 'File type is not allowed'
    if request.form.get('startDx') is not None:
        startDx = float(request.form.get('startDx'))
        startDy = float(request.form.get('startDy'))
        endDx = float(request.form.get('endDx'))
        endDy = float(request.form.get('endDy'))

        # 바운딩 박스 없을 때
        if startDx == startDy == endDx == endDy == 0.0:
            productName = ''

        else:
            productName = image_process.roi(
                img=image_np,
                startDx=startDx,
                startDy=startDy,
                endDx=endDx,
                endDy=endDy
            )
            productName = productName.replace('%', '')
            productName = productName.replace('\'', '')
            productName = productName.replace('\n', '')
            productName = productName.replace('\r', '')
            print(f'search product name : {productName}')

    else:
        productName = ''

    # TODO 변수 지울 것
    # productName = '유산균'

    if success and errors:
        errors['message'] = 'File(s) successfully uploaded'
        resp = jsonify(errors)
        resp.status_code = 500
        return resp

    if success:
        result = nutrient.getProductsInfo(productName)
        result = ServiceProvided.convertInformation(data=result, only=False)

        respDict = dict()
        respDict['status'] = 'SUCCESS'
        respDict['result'] = {
            'detected_name': productName,
            'mark': marks,
            'details': details,
            'products': result,
        }

        resp = jsonify(respDict)
        resp.status_code = 201
        return resp
    else:
        resp = jsonify(errors)
        resp.status_code = 500
        return resp


if __name__ == "__main__":
    app.run(
        host='0.0.0.0'
    )

# image = Image.open(filePath)
# image_np = load_image_into_numpy_array(image)
