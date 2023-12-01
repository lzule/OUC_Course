from selenium import webdriver
import time
import csv
from selenium.webdriver.common.keys import Keys

# 实现翻页操作
def drop_down(driver):
    for x in range(1, 12, 2):
        time.sleep(1)
        j = x / 9
        js = 'document.documentElement.scrollTop = document.documentElement.scrollHeight * %f' % j
        driver.execute_script(js)
        # driver.implicitly_wait(10)

chrome_path = r'C:\Program Files\Google\Chrome\Application\chromedriver.exe' # 当前仓库Google\Chrome\Application\chromedriver.exe的路径
driver = webdriver.Chrome(chrome_path)

driver.get('http://www.taobao.com')  # 打开淘宝网页
search_name = input('请输入商品名称：')  # 手动输入要搜索的商品名称
# 等待一段时间，进行手动登录
driver.find_element_by_css_selector('body > div.screen-outer.clearfix > div.main > div.main-inner.clearfix > div.col-right > div.tbh-user.J_Module > div > div.member-ft > div.member-logout.J_UserMemberLogout > a.btn-login.ml1.tb-bg.weight').click()      
# 找到扫码位置
time.sleep(15)    # （15秒用于手动扫码登录，按自己手速调节，扫码后记得更新第一个标签页）

f = open('淘宝' + search_name + '.csv', mode='w', encoding='utf-8-sig', newline='')  # 创建csv文件，保存数据
csv_writer = csv.DictWriter(f, fieldnames=[  # 将要保存的的数据
    '商品销量排名',
    '商品名称',
    '价格',
    '购买量',
    '店铺名称',
    '商品详情页'
])
csv_writer.writeheader()  # 写入表头

# 进入商品页面，并自动在搜索框中输入商品名称
driver.find_element_by_css_selector('#q').send_keys(search_name)
# 点击搜索按钮
driver.find_element_by_css_selector('#J_TSearchForm > div.search-button > button').click()
# 点击销量排序
driver.find_element_by_css_selector('.next-input.next-small input').send_keys(4000)  # 选择价位在4000元以上
driver.find_element_by_xpath('//*[@id="sortBarWrap"]/div[1]/div[1]/div/div[1]/div/div/div/ul/li[2]/div').click() # 双击“按销售量排序”
time.sleep(2)
driver.find_element_by_xpath('//*[@id="sortBarWrap"]/div[1]/div[1]/div/div[1]/div/div/div/ul/li[2]/div').click()
# 等待网页相应
driver.implicitly_wait(10)
# 记录商品数量
g_num = 0

for page in range(15):  # 搜索前15页数据
    # 下滑浏览器，是商品信息全部暴露出来
    drop_down(driver)
    # 获取商品数据信息
    goods = driver.find_elements_by_css_selector('.Card--doubleCardWrapper--L2XFE73, .Card--doubleCardWrapperMall--uPmo5Bz, .Card--doubleCardWrapperNone--N8KMGpq')
    # 迭代商品信息
    for good in goods:
        name = good.find_element_by_css_selector('.Title--title--jCOPvpf').text
        commit = good.find_element_by_css_selector('.Price--procity--_7Vt3mX, .Price--realSales--FhTZc7U').text
        price = good.find_element_by_css_selector('.Price--price--pI3tZGJ, .Price--priceFloat--h2RR0RK, .Price--priceInt--ZlsSi_M').text + good.find_element_by_css_selector('.Price--price--pI3tZGJ, .Price--priceFloat--h2RR0RK').text
        if float(price) < 3499:  # 防止价格低于3499的商品混入数据
            continue
        shop_name = good.find_element_by_css_selector('.ShopInfo--shopName--rg6mGmy').text
        href = good.get_attribute('href')
        g_num += 1
        good_dit = {
            "商品销量排名": g_num,
            "商品名称": name,
            "价格": price,
            "购买量": commit[:-4], # 只保存数字，如有问题也可直接保存commit
            "店铺名称": shop_name,
            "商品详情页": href
        }
        csv_writer.writerow(good_dit)  # 写入csv文件
        # print(href)
        # print(g_num)
        if g_num == 100:  # 只保存前100商品
            break
    # 点击下一页，进行翻页操作
    next_btn = driver.find_element_by_css_selector('#root > div > div:nth-child(3) > div.PageContent--contentWrap--mep7AEm > div.LeftLay--leftWrap--xBQipVc > div.LeftLay--leftContent--AMmPNfB > div.Pagination--pgWrap--kfPsaVv > div > div > button.next-btn.next-medium.next-btn-normal.next-pagination-item.next-next')
    next_btn.send_keys("\n")
    driver.implicitly_wait(10)  # 等待网页相应
    if g_num == 100:  # 只保存前100商品
            break
driver.quit()  # 关闭浏览器
f.close()  # 关闭文件
print(g_num)  # 输出当前采集的数据数量