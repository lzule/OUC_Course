# 《走进经济学》
### 文件说明
+ Google.zip 压缩文件里存放能够直接使用的实例化浏览器
+ fenlei.py 文件用来对获取的总文件进行进一步的数据提取
+ taobao.py 文件用来对淘宝平台的数据进行爬虫，并将文件以csv形式保存在本地
+ 淘宝游戏本.csv 当时爬取得到的数据
+ data___1.xlsx 对爬取数据进行二次整理得到的统计文件
+ requirements.txt Python运行环境依赖
### 使用说明
1. 安装依赖

    pip install -r requirements.txt
2. 获取Google.zip文件

    链接：https://pan.baidu.com/s/1SkatFmiDnwSbbV2H4GtCCg?pwd=ee4t 
    提取码：ee4t

3. 运行代码

    + python taobao.py  运行代码后需要在终端输入搜索商品名称
    + python fenlei.py  运行代码后会直接生成一个.xlsx文件，内部含多个sheet，存储不同品牌的信息与汇总后的统计信息

### 注意⚠
代码中部分内容需要根据用户使用进行略微修改