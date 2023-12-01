import pandas as pd
import csv
'''
对获取的csv文件进行进一步地数据提取, 用来分析比较

'''
# 首先以只读方式打开csv文件
f = open('淘宝游戏本.csv', "r",encoding='utf-8',newline='')
reader = csv.reader(f)
# 商品销量排名,商品名称,价格,购买量,店铺名称,商品详情页，创建表头
华硕=pd.DataFrame({
                   '商品销量排名': [],
                   '商品名称': [],
                   '价格': [],
                   '购买量': [],
                   '店铺名称': [],
                   '商品详情页': [],})
戴尔 = 华硕
联想 = 华硕
惠普 = 华硕
机械革命 = 华硕
机械师 = 华硕
七彩虹 = 华硕
神舟 = 华硕
rog = 华硕
Acer = 华硕
其它 = 华硕
# 采用字典方式来存储对应品牌sheet，便于遍历更新
brand = {"华硕": 华硕, 
         "戴尔": 戴尔,
         "联想": 联想,
         "惠普": 惠普,
         "机械革命": 机械革命, 
         "机械师": 机械师,
         "七彩虹": 七彩虹,
         "神舟": 神舟,
         "ROG": rog,
         "Acer": Acer
        }
# 商品销量排名,商品名称,价格,购买量,店铺名称,商品详情页，对所有品牌的数据进行统计汇总
汇总 = [
    ['总销量',       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ['平均价格',     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ['总销售额',     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ['top10品牌数',  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ['top100品牌数', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ['平均售卖价格',  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
]
# 开始按行读取csv文件
for id, info in enumerate(reader):
    jud = False
    if id == 0:  # 由于第一行是表头，故跳过
        continue
    for key, value in brand.items():  # 遍历字典，并存储对应数据
        if key in info[1]:
            brand[key] = brand[key]._append(pd.DataFrame([info], columns=brand[key].columns))
            jud = True
    if jud is False:
        其它 = 其它._append(pd.DataFrame([info], columns=其它.columns))

#创建一个xlsx文件
writer = pd.ExcelWriter('data.xlsx', engine='openpyxl')
# 将数据集分别写入到Sheet中
for key, value in brand.items():
    value.to_excel(writer, sheet_name=key, index=False)
# 遍历每一个sheet，对每一个品牌进行数据统计
for i, key in enumerate(brand.keys()):
    num = 0
    for index,row in brand[key].iterrows():
        num += 1
        if int(row['商品销量排名']) < 11:
            汇总[3][i + 1] += 1
        if int(row['商品销量排名']) < 101:
            汇总[4][i + 1] += 1
        汇总[0][i + 1] += int(row['购买量'])
        汇总[1][i + 1] += float(row['价格'])
        汇总[2][i + 1] += int(row['购买量']) * float(row['价格'])
    # print(key)
    # print(汇总[1][i + 1], num)
    汇总[1][i + 1] = 汇总[1][i + 1] / num
    # print(汇总[1][i + 1])
    汇总[5][i + 1] = 汇总[2][i + 1] / 汇总[0][i + 1]

num = 0
for index,row in 其它.iterrows():
    # if index == 0:
    #     continue
    num += 1
    if int(row['商品销量排名']) < 11:
        汇总[3][-1] += 1
    if int(row['商品销量排名']) < 101:
        汇总[4][-1] += 1
    汇总[0][-1] += int(row['购买量'])
    汇总[1][-1] += float(row['价格'])
    汇总[2][-1] += int(row['购买量']) * float(row['价格'])
# print(汇总[1][-1])
# print(num)
汇总[1][-1] = 汇总[1][-1] / num
# print(汇总[1][-1])
汇总[5][-1] = 汇总[2][-1] / 汇总[0][-1]
# print(汇总[1][-1])
# 创建表头
huizong = {"类型": [],
         "华硕": [], 
         "戴尔": [],
         "联想": [],
         "惠普": [],
         "机械革命": [],
         "机械师": [],
         "七彩虹": [],
         "神舟": [],
         "ROG": [],
         "Acer": [],
         "其它": [], 
        }
oth = pd.DataFrame(huizong, index=[0])  # 创建新的sheet来保存所有汇总数据
oth = oth._append(pd.DataFrame(汇总, columns=oth.columns))
# 将其它、汇总数据分别写入到xlsx中
其它.to_excel(writer, sheet_name='其它', index=False)
oth.to_excel(writer, sheet_name='汇总统计', index=False)
# 保存文件
writer.close()