#!/usr/bin/env python
# coding: utf-8

# # 인증마크 탐지 테스트
# 인증마크 탐지 테스트를 위한 소스코드

# # Imports

import numpy as np
import os
import six.moves.urllib as urllib
import sys
import tensorflow as tf
import cv2

from distutils.version import StrictVersion
from collections import defaultdict
from io import StringIO
from PIL import Image

import pathlib

# This is needed since the notebook is stored in the object_detection folder.
sys.path.append("..")
from object_detection.utils import ops as utils_ops

if StrictVersion(tf.__version__) < StrictVersion('1.9.0'):
    raise ImportError('Please upgrade your TensorFlow installation to v1.9.* or later!')

config = tf.ConfigProto()
config.gpu_options.allow_growth = True
session = tf.Session(config=config)


# ## Object detection imports
# Here are the imports from the object detection module.


from object_detection.utils import label_map_util

from object_detection.utils import visualization_utils as vis_util


# # Model preparation 

# ## 학습모델 및 lable_map 파일 준비
# "PATH_TO_FROZEN_GRAPH"에는 학습모델 경로 설정
# "PATH_TO_LABELS"에는 lable_map.pdtxt 파일 경로 설정


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


# ## Loading label map
# Label maps map indices to category names, so that when our convolution network predicts `5`, we know that this corresponds to `airplane`.  Here we use internal utility functions, but anything that returns a dictionary mapping integers to appropriate string labels would be fine


category_index = label_map_util.create_category_index_from_labelmap(PATH_TO_LABELS, use_display_name=True)


# ## Helper code
def load_image_into_numpy_array(image):
  (im_width, im_height) = image.size
  return np.array(image.getdata()).reshape(
      (im_height, im_width, 3)).astype(np.uint8)


# # Detection
# "PATH_TO_TEST_IMAGES_DIR"에는 테스트이미지가 있는 경로 설정
# "TEST_IMAGE_PATHS"에는 테스트 파일의 이름패턴을 지정 후 테스트 파일 번호의 범위를 지정 해주는 설정


def run_inference_for_single_image(image, graph):
    with graph.as_default():
        with tf.Session() as sess:
            # Get handles to input and output tensors
            ops = tf.get_default_graph().get_operations()
            all_tensor_names = {output.name for op in ops for output in op.outputs}
            tensor_dict = {}
            for key in [
              'num_detections', 'detection_boxes', 'detection_scores',
              'detection_classes', 'detection_masks'
            ]:
                tensor_name = key + ':0'
                if tensor_name in all_tensor_names:
                    tensor_dict[key] = tf.get_default_graph().get_tensor_by_name(tensor_name)

            if 'detection_masks' in tensor_dict:
                # The following processing is only for single image
                detection_boxes = tf.squeeze(tensor_dict['detection_boxes'], [0])
                detection_masks = tf.squeeze(tensor_dict['detection_masks'], [0])
                # Reframe is required to translate mask from box coordinates to image coordinates and fit the image size.
                real_num_detection = tf.cast(tensor_dict['num_detections'][0], tf.int32)
                detection_boxes = tf.slice(detection_boxes, [0, 0], [real_num_detection, -1])
                detection_masks = tf.slice(detection_masks, [0, 0, 0], [real_num_detection, -1, -1])
                detection_masks_reframed = utils_ops.reframe_box_masks_to_image_masks(
                    detection_masks, detection_boxes, image.shape[0], image.shape[1])
                detection_masks_reframed = tf.cast(
                    tf.greater(detection_masks_reframed, 0.5), tf.uint8)
                # Follow the convention by adding back the batch dimension
                tensor_dict['detection_masks'] = tf.expand_dims(
                    detection_masks_reframed, 0)
            image_tensor = tf.get_default_graph().get_tensor_by_name('image_tensor:0')

            # Run inference
            output_dict = sess.run(tensor_dict,
                                 feed_dict={image_tensor: np.expand_dims(image, 0)})

            # all outputs are float32 numpy arrays, so convert types as appropriate
            output_dict['num_detections'] = int(output_dict['num_detections'][0])
            output_dict['detection_classes'] = output_dict['detection_classes'][0].astype(np.uint8)
            output_dict['detection_boxes'] = output_dict['detection_boxes'][0]
            output_dict['detection_scores'] = output_dict['detection_scores'][0]
            if 'detection_masks' in output_dict:
                output_dict['detection_masks'] = output_dict['detection_masks'][0]
    return output_dict


# # 소스코드 수정해서 사용할 부분
# object detection 기능을 수행하는 부분


# 인증마크 탐지 결과 바운딩 박스 이미지를 반환
def getResultImage(image_np, output_dict):
    # Visualization of the results of a detection.
    vis_util.visualize_boxes_and_labels_on_image_array(
        image_np,
        output_dict['detection_boxes'],
        output_dict['detection_classes'],
        output_dict['detection_scores'],
        category_index,
        instance_masks=output_dict.get('detection_masks'),
        use_normalized_coordinates=True,
        line_thickness=5,
        min_score_thresh=.50,
        skip_scores=True)

    return image_np



# 인증마크 탐지 결과 딕셔너리에서 클래스 이름을 얻어옴
def getClassName(output_dict):
    num = 0
    for score in output_dict["detection_scores"]:
        if(score >= 0.5):
            num+=1;
            
    # 탐지된 인증마크 개수
    # print(num)
    
    classes = []
    for n in range(num):
        class_name = output_dict['detection_classes'][n]

        if(class_name == 1) :
            c_name = 'korCertifiMark (국내 건강기능식품)'
        elif(class_name == 2) :
            c_name = 'gmp (국내 GMP)'
        elif(class_name == 3) :
            c_name = 'usda (미국 유기농)'
        elif(class_name == 4) :
            c_name = 'usp (미국 USP)'
        elif(class_name == 5) :
            c_name = 'aco (호주 유기농)'
        
        if c_name in classes:
            continue
        else:
            classes.append(c_name)
    
    # 정렬 ( 오름차순 )
    classes.sort()
    
    return classes



# 탐지된 인증마크 개수를 얻어옴
def getCountMark(output_dict):
    num = 0
    for score in output_dict["detection_scores"]:
        if(score >= 0.5):
            num+=1;
    
    return num




def create_white_matrix(width, height):
    mat = None
    
    mat = np.ones((height, width, 3), dtype = "uint8") * 255
    
    return mat



def input_image_to_white_matrix(target, _width, _height, x=0, y=0):
    result_matrix = create_white_matrix(_width, _height)
    width, height, channel = target.shape
    
    if(width > _width or height > _height):
        return None
    
    result_matrix[x:x+width, y:y+height] = target
    
    return result_matrix

"""
filePath = "./aco_1_001.jpg"

image = Image.open(filePath)
image_np = load_image_into_numpy_array(image)

width, height, channel = image_np.shape

# 입력 이미지 전처리 ( 해상도 변경 ( 1400 x 1400 ))
image_np = input_image_to_white_matrix(image_np, 1400, 1400)

# 인증마크 탐지 결과 얻기
output_dict = run_inference_for_single_image(image_np, detection_graph)
result_image = getResultImage(image_np, output_dict)
result_image = result_image[0:width, 0:height]

result_image = cv2.cvtColor(result_image, cv2.COLOR_RGB2BGR)


print(f"탐지된 인증마크 개수 : {getCountMark(output_dict)}")
print(f"탐지된 인증마크 종류 : {getClassName(output_dict)}")
"""