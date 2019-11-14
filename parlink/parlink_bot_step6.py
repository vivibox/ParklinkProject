from flask import Flask, request, abort
import requests
import configparser
import urllib3
from bs4 import BeautifulSoup
from initialization import Initialization

import jieba
import jieba.analyse

'''import linebot sdk'''
from linebot import (
    LineBotApi, WebhookHandler
)
from linebot.exceptions import (
    InvalidSignatureError
)

from linebot.models import *
urllib3.disable_warnings()
# initial Line Api Handler and Webhook.
_initialization = Initialization()
handler = _initialization.handler
line_bot_api = _initialization.line_bot_api

website_config = configparser.ConfigParser()
#讀取檔案 CrawlingSites.ini
website_config.read("CrawlingSites.ini")
# 選擇讀取檔案位置
websites = website_config['TARGET_URL']
#ReStart_Counter = 0

app = Flask(__name__)

"""
Define Fixed Reply
"""
REPLY_OK = "OK"
REPLY_FAIL = "SYSTEM_FAIL"

# jieba 檔案調整 ###########################################################
jieba.add_word('停車場')
jieba.add_word('在哪裡')



# TEXT WORDS 讀取###########################################################
#### 最新資訊 ####
CARNEWS_TXT_KEYWORDS = []
with open("carnewswords.txt", "r", encoding="utf-8") as f:
    lines = f.readlines()
    for word in lines:
        CARNEWS_TXT_KEYWORDS.append(word.replace('\n', ''))
#### 停車場位置 #####
CARLOCATION_TXT_KEYWORDS = []
with open("carlocation.txt", "r", encoding="utf-8") as f:
    lines = f.readlines()
    for word in lines:
        CARLOCATION_TXT_KEYWORDS.append(word.replace('\n', ''))
#### 空位查詢 #####
VACANCY_TXT_KEYWORDS = []
with open("carvacancy.txt", "r", encoding="utf-8") as f:
    lines = f.readlines()
    for word in lines:
        VACANCY_TXT_KEYWORDS.append(word.replace('\n', ''))
#### 停放位置查詢 #####
PARKING_TXT_KEYWORDS = []
with open("carparking.txt", "r", encoding="utf-8") as f:
    lines = f.readlines()
    for word in lines:
        PARKING_TXT_KEYWORDS.append(word.replace('\n', ''))

#########################################################################
@app.route("/callback", methods=['POST'])
def callback():
    signature = request.headers['X-Line-Signature']
    body = request.get_data(as_text=True)
    app.logger.info("Request body: " + body)
    try:
        handler.handle(body, signature)
    except InvalidSignatureError:
        abort(400)
    return REPLY_OK

@app.route('/')
def hello_world():
    return "Hello,這是我的檢索型Line Bot 第二版！"


#處理文字事件
@handler.add(MessageEvent, message=TextMessage)
def handle_text_message(event):
    #actual_event_txt = event.message.text
    #response_to_user_id = 傳送訊息的使用者ID
    response_to_user_id = event.source.user_id
    type_of_event = str(type(event))
    #########################################################
    ######## 分詞切割比對 ###################
    keywords = jieba.analyse.extract_tags(event.message.text)
    user_message = None 
    ALL_TXT_KEYWORDS = CARNEWS_TXT_KEYWORDS + CARLOCATION_TXT_KEYWORDS + VACANCY_TXT_KEYWORDS +PARKING_TXT_KEYWORDS
    for word in range(len(keywords)):
        if keywords[word] in ALL_TXT_KEYWORDS:
            user_message = keywords[word] 

    #### 最新資訊 #####
    # if user_message in CARNEWS_TXT_KEYWORDS:
    #     content = retrieveTechNews()  # get apple realtime news.
    #     # the line below cannot response to individual
    #     line_bot_api.reply_message(event.reply_token,TextSendMessage(text=content))
    #     return 0

    ##### 地點查詢 ######
    if user_message in CARLOCATION_TXT_KEYWORDS :
        line_bot_api.reply_message(event.reply_token,TextSendMessage("台北:大安區\n桃園:龜山"))
        return 0

    ##### 車位查詢 ######
    if user_message in VACANCY_TXT_KEYWORDS:
        line_bot_api.reply_message(event.reply_token,TextSendMessage("台北:有30個普通車位+身心障礙專用車位2個\n桃園:仍有17個普通車位+身心障礙專用車位2個"))
        return 0

    ##### 停放位置查詢 ######
    if user_message in PARKING_TXT_KEYWORDS:
        line_bot_api.reply_message(event.reply_token,TextSendMessage("暫未開放"))
        return 0

    ##########################################################
    ######## Second Section of IF Statements:for button menu #########
    if event.message.text == '選單' or event.message.text == 'services':
        buttons_template = TemplateSendMessage(
            alt_text='服務選單',
            template=ButtonsTemplate(
                title='服務類型',
                text='請選擇',
                thumbnail_image_url='https://i.imgur.com/z67bYl4.png',
                ###前二種類型都為單純爬取資訊。第三、第四種，需要二輪的對話。閒聊服務，以Grammar為主的聊天實作。
                actions=[
                    # MessageTemplateAction(
                    #     label='最新資訊',
                    #     text='最新資訊'
                    # ),
                    MessageTemplateAction(
                        label='空位查詢',
                        text='空位查詢'
                    ),
                    MessageTemplateAction(
                        label='地點查詢',
                        text='地點查詢'
                    ),
                    MessageTemplateAction(
                        label='停放位置查詢(請輸入車號)',
                        text='停放位置查詢'
                    )
                ]
            )
        )
        print("response id is {}".format(response_to_user_id))
        line_bot_api.reply_message(event.reply_token, buttons_template)
        return 0
    #############################################################################
    else:
        #_content = "Debug_Info:"+actual_event_txt + "##" + type_of_event#retrieveAppleNews()
        content = (event.message.text)+"?我不太清楚這個意思\n 請您再簡單完整的描述您的問題，我會盡力回答 \n 也可以輸入[選單]來看看常用的選項喔!"
        line_bot_api.reply_message(
            event.reply_token, TextSendMessage(text=content))
    
        return 0
    
################ Start OF Content Generation Functions ###############
def retrieveTechNews():
    #target_url = websites['CarNews']
    print('Starting get Tech News Data ...')
    rs = requests.session()
    res = rs.get(websites['CarNews'], verify=False)
    #res.encoding = 'utf-8'
    soup = BeautifulSoup(res.text, 'html.parser')
    content = ""
    for index, data in enumerate(soup.select('form article div.container div.main_box div.page_content p')):
        if index == 5:
            return content
        title = data.text
        link = data['href']
        content += '{}\n{}\n\n'.format(title, link)
    return content

################ End OF Content Generation Functions #################

'''
@handler.add(MessageEvent, message=TextMessage)
def handle_message(event):
  handler.line_bot_api.reply_message(event.reply_token, TextSendMessage(text=event.message.text))
'''
if __name__ == "__main__":
    #global ReStart_Counter
    #ReStart_Counter += 1
    # print("ReStarting Count:{}".format(ReStart_Counter))
    app.run()