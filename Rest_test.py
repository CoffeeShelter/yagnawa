import requests
import json

api_key  = "97f136f5a8004dc382ca"
serviceId = "I0030"
# serviceId = "C003"
dataType = "json"
startIdx = "1"
endIdx = "5"

api_url = "http://openapi.foodsafetykorea.go.kr/api/{}/{}/{}/{}/{}".format(api_key, serviceId, dataType, startIdx, endIdx)
print(api_url)

result = requests.get(api_url)

json_data = json.dumps(result.json(), indent=4, ensure_ascii=False)
json_object = json.loads(json_data)

# print(json_object['STDR_STND'][0])
# print(type(json_object))

data = json_object['I0030']
rows = data['row']

list_ = []
count = 0
for row in rows:
    count += 1
    if count != 3:
        continue
    temp = row['STDR_STND']
    list_ = temp.split('\n')
    break

print(len(list_))
print(list_[1])