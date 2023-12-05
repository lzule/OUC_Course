import tkinter as tk


def hello():
    global var1, listbox1
    var1.set(listbox1.get(listbox1.curselection()))


main_window = tk.Tk()  # 创建实例化对象
main_window.title('This is main window!')
main_window.geometry("640x480")


var1 = tk.StringVar()
var1.set('Init')
label1 = tk.Label(main_window, textvariable=var1, bg="blue", font=('Arial', 12), width=10, height=1, fg='white')

button1 = tk.Button(main_window, text="hello", bg='white', font=("Arial", 12), width=10, height=1, command=hello)

lb1_var1 = tk.StringVar()
lb1_var1.set(('11', '22', '33', '44'))
listbox1 = tk.Listbox(main_window, listvariable=lb1_var1)
listbox1.insert(1, "aaa")
listbox1.insert('end', 'bbb')

label1.pack()
button1.pack()
listbox1.pack()
main_window.mainloop()
