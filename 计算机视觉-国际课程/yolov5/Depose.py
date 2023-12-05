import tkinter as tk
import tkinter.filedialog as filedialog
from PIL import Image, ImageTk
import os
import cv2
import numpy as np
import torch

from ultralytics.utils.plotting import Annotator, colors

from models.common import DetectMultiBackend
from utils.dataloaders import LoadImages
from utils.general import (Profile, check_img_size, cv2,
                           non_max_suppression, scale_boxes)
from utils.torch_utils import select_device, smart_inference_mode


# global variable
ori_img = Image.new('RGB', (640, 480))
fin_img = Image.new('RGB', (640, 480))
backups_img = Image.new('RGB', (640, 480))
main_window = tk.Tk()  # 创建实例化对象
main_window.title('This is main window!')
main_window.geometry("1536x1080")
width, height = 640, 480
var_flip = tk.IntVar()
tx, ty = 0, 0
save_file_type = tk.StringVar()
save_file_type.set((".jpg", ".png"))
# detect model config
device = select_device("cuda:0")
model = DetectMultiBackend('best.pt', device=device, dnn=False, data='data/coco128.yaml', fp16=False)
model.warmup(imgsz=(1, 3, 640, 480))  # warmup
conf_thres = 0.25
iou_thres = 0.45
max_det = 1

name_list = ['50 Cent',
             'Aaron Hernandez',
             'Aaron Rodgers',
             'Abhishek Bachchan',
             'Adam Levine',
             'Adam Sandler',
             'Adrian Gonzalez',
             'Adrian Peterson',
             'Aishwarya Rai',
             'Ajay Devgan',
             'Akshay Kumar',
             'Al Pacino',
             'Albert Pujol',
             'Alex Fergusson',
             'Alex Morgan',
             'Alex Rodriguez',
             'Alexis Sanchez',
             'Alicia Keys',
             'Allen Iverson',
             'Allyson Felix',
             'Alvaro Uribe',
             'Alyson Hannigan',
             'Alyssa Milano',
             'Amanda Seyfried',
             'Amar Stoudemire',
             'Amber Heard',
             'Amir Khan',
             'Amitabh Bachchan'
             ]

def show_ori_img():
    global ori_img
    img_show = Image.fromarray(cv2.cvtColor(ori_img, cv2.COLOR_BGR2RGB))
    render = ImageTk.PhotoImage(img_show)
    img = tk.Label(main_window, image=render)
    img.image = render
    img.place(x=20, y=200)



def show_fin_img():
    global fin_img
    img_show = Image.fromarray(cv2.cvtColor(fin_img, cv2.COLOR_BGR2RGB))
    render = ImageTk.PhotoImage(img_show)
    img = tk.Label(main_window, image=render)
    img.image = render
    img.place(x=876, y=200)

# 实现在本地电脑选择图片
def get_img():
    img_path = filedialog.askopenfilename(title='选择图片')

    global ori_img, fin_img, width, height, backups_img
    ori_img = cv2.resize(cv2.imread(img_path), (width, height))
    fin_img = ori_img
    backups_img = ori_img
    show_ori_img()
    show_fin_img()


def save_img():
    global save_file_type, fin_img
    save_path = filedialog.asksaveasfilename(title='选择保存路径', defaultextension='.jpg', filetypes=[("Image Files", "*.jpg"), ("All Files", "*.*")])
    cv2.imwrite(save_path, fin_img)


def detect_img():
    global fin_img, model, conf_thres, iou_thres, max_det, name_list
    im = cv2.cvtColor(fin_img, cv2.COLOR_BGR2RGB).transpose(2, 0, 1)
    im0s = fin_img
    names = name_list
    # names = model.names
    im = torch.from_numpy(im).to(model.device)
    im = im.float()
    im /= 255  # 0 - 255 to 0.0 - 1.0
    if len(im.shape) == 3:
        im = im[None]  # expand for batch dim

    # Inference
    pred = model(im, augment=False, visualize=False)

    # NMS
    pred = non_max_suppression(pred, conf_thres, iou_thres, None, False, max_det=max_det)

    # Process predictions
    im0 = im0s.copy()
    annotator = Annotator(im0, line_width=3, example=str(names))
    for i, det in enumerate(pred):  # per image
        if len(det):
            # Rescale boxes from img_size to im0 size
            det[:, :4] = scale_boxes(im.shape[2:], det[:, :4], im0.shape).round()

            # Write results
            for *xyxy, conf, cls in reversed(det):
                if True:  # Add bbox to image
                    c = int(cls)  # integer class
                    label = (f'{names[c]} {conf:.2f}')
                    annotator.box_label(xyxy, label, color=colors(c, True))

        # Stream results
        fin_img = annotator.result()
        show_fin_img()


def rotate_img():
    def inter_depose(angle):
        global ori_img, fin_img, width, height
        rotate_matrix = cv2.getRotationMatrix2D(center=(320, 240), angle=float(angle), scale=1)
        fin_img = cv2.warpAffine(src=ori_img, M=rotate_matrix, dsize=(width, height))
        show_fin_img()

    global main_window
    angle_sc = tk.Scale(main_window, label='angel_set', from_=0, to=360,
                  orient=tk.HORIZONTAL, length=200,
                  showvalue=True, tickinterval=90, resolution=0.1,
                  command=inter_depose)
    angle_sc.set(0)
    angle_sc.pack()


def update_img():
    # is_sign_up = tk.messagebox.askyesno(title='Insure the choice', message='Are you sure you want to update images to ori img')
    # if is_sign_up:
    global ori_img, fin_img, width, height
    ori_img = fin_img
    show_ori_img()

def init_img():
    global ori_img, fin_img, width, height, backups_img
    ori_img = backups_img
    fin_img = backups_img
    show_ori_img()
    show_fin_img()

def flip_img():
    def inter_depose():
        global ori_img, fin_img, width, height, var_flip
        fin_img = cv2.flip(ori_img, flipCode=var_flip.get())
        show_fin_img()

    global main_window
    r1 = tk.Radiobutton(main_window, text='垂直镜像反转', variable=var_flip, value=0, command=inter_depose)
    r1.pack()

    r2 = tk.Radiobutton(main_window, text='水平镜像翻转', variable=var_flip, value=1, command=inter_depose)
    r2.pack()

    r3 = tk.Radiobutton(main_window, text='俩方向都翻转', variable=var_flip, value=-1, command=inter_depose)
    r3.pack()


def translate_img():
    def level_inter_depose(delta):
        global ori_img, fin_img, width, height, tx, ty
        tx = delta
        translation_matrix = np.array([
            [1, 0, tx],
            [0, 1, ty]
        ], dtype=np.float32)
        fin_img = cv2.warpAffine(src=ori_img, M=translation_matrix, dsize=(width, height))
        show_fin_img()

    def vertical_inter_depose(delta):
        global ori_img, fin_img, width, height, tx, ty
        ty = delta
        translation_matrix = np.array([
            [1, 0, tx],
            [0, 1, ty]
        ], dtype=np.float32)
        fin_img = cv2.warpAffine(src=ori_img, M=translation_matrix, dsize=(width, height))
        show_fin_img()

    global main_window
    level_sc = tk.Scale(main_window, label='level_set', from_=0, to=640,
                  orient=tk.HORIZONTAL, length=200,
                  showvalue=True, tickinterval=90, resolution=0.1,
                  command=level_inter_depose)
    vertical_sc = tk.Scale(main_window, label='vertical_set', from_=0, to=480,
                        orient=tk.VERTICAL, length=200,
                        showvalue=True, tickinterval=90, resolution=0.1,
                        command=vertical_inter_depose)
    level_sc.set(0)
    vertical_sc.set(0)
    level_sc.pack()
    vertical_sc.pack()


if __name__ == "__main__":
    ori_label = tk.Label(main_window, text="Original Photo")
    ori_label.place(x=300, y=170)

    fin_label = tk.Label(main_window, text="Deposed Photo")
    fin_label.place(x=1136, y=170)

    get_button = tk.Button(main_window, text="get_img", bg='white', font=("Arial", 12), width=10, height=1, command=get_img)
    save_button = tk.Button(main_window, text="save_img", bg='white', font=("Arial", 12), width=10, height=1, command=save_img)


    detect_botton = tk.Button(main_window, text="detect", bg='white', font=("Arial", 12), width=10, height=1, command=detect_img)

    rotate_botton = tk.Button(main_window, text="rotate", bg='white', font=("Arial", 12), width=10, height=1, command=rotate_img)
    flip_botton = tk.Button(main_window, text="flip", bg='white', font=("Arial", 12), width=10, height=1, command=flip_img)
    translation_botton = tk.Button(main_window, text="translation", bg='white', font=("Arial", 12), width=10, height=1, command=translate_img)

    update_botton = tk.Button(main_window, text="update", bg='white', font=("Arial", 12), width=10, height=1, command=update_img)
    init_botton = tk.Button(main_window, text="init", bg='white', font=("Arial", 12), width=10, height=1, command=init_img)

    get_button.pack()
    save_button.pack()
    rotate_botton.pack()
    translation_botton.pack()
    flip_botton.pack()
    update_botton.pack()
    detect_botton.pack()
    init_botton.pack()
    main_window.mainloop()
    print(1)