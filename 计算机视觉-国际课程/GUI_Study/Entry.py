import tkinter as tk


def insert():
    global text1, entry1
    text1.insert('insert', entry1.get())


def put_end():
    global text1, entry1
    text1.insert('end', entry1.get())


main_window = tk.Tk()
main_window.title("This is main window!")
main_window.geometry("640x480")

# var1 = tk.StringVar()
# var1.set("Init")

text1 = tk.Text(main_window, height=1)

# label1 = tk.Label(main_window, textvariable=var1, bg='white', font=('Arial', 12), fg='blue', width=7, height=1)

button1 = tk.Button(main_window, text="insert", bg='white', font=('Arial', 12), width=7, height=1, command=insert)
button2 = tk.Button(main_window, text="putend", bg='white', font=('Arial', 12), width=7, height=1, command=put_end)

entry1 = tk.Entry(main_window, show=None)


# label1.pack()
button1.pack()
button2.pack()
entry1.pack()
text1.pack()
main_window.mainloop()