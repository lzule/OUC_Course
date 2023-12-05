import tkinter as tk
from tkinter import PhotoImage

def on_check():
    print("Checkbutton被点击了！")

root = tk.Tk()
root.title('This is main window!')
root.geometry("200x600")
checkbutton1 = tk.Checkbutton(root, text="点击我1", command=None)
checkbutton2 = tk.Checkbutton(root, text="点击我2", command=None)
checkbutton3 = tk.Checkbutton(root, text="点击我3", command=None)


# l = tk.Label(root,bg='green',width=25,
#              text="empty")
# l.pack()

# def print_selection(v):
#     l.config(text="you have selected" + v)

sc = tk.Scale(root,label='try me',from_=0,to=270,
              orient=tk.HORIZONTAL,length=180,
              showvalue=0,tickinterval=50,resolution=0.1,
              command=None)

sk = tk.Scale(root,label='try me1',from_=0,to=90,
              orient=tk.VERTICAL,length=180,
              showvalue=0,tickinterval=10,resolution=0.1,
              command=None)
sc.set(135)

button1 = tk.Button(root, text="hello", bg='white', font=("Arial", 12), width=7, height=1, command=None)


# checkbutton.pack()
# check_icon = PhotoImage(data=)
# checkbutton.config(borderwidth=100, highlightthickness=2)
checkbutton1.place(x=70, y=20)
checkbutton2.place(x=70, y=70)
checkbutton3.place(x=70, y=120)
button1.place(x=65, y=170)
sc.place(x=0, y=190)
sk.place(x=70, y=270)
root.mainloop()
