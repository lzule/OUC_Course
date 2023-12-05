import tkinter as tk


def hello():
    global var1
    var1.set("hello")


main_window = tk.Tk()  # 创建实例化对象
main_window.title('This is main window!')
main_window.geometry("640x480")


var1 = tk.StringVar()
var1.set('Init')
label1 = tk.Label(main_window, textvariable=var1, bg="blue", font=('Arial', 12), width=10, height=1, fg='white')

button1 = tk.Button(main_window, text="hello", bg='white', font=("Arial", 12), width=10, height=10, command=hello)


label1.pack()
button1.pack()
main_window.mainloop()
