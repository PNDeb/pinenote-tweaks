#!/usr/bin/env python
"""TKinter-based GUI to set the PineNote offscreen content

Note: This app uses the pinenote-dbus-service to actually talk to the kernel

We use:
    tk-html
    python3-markdown

"""
from tkinter import *
from tkinter import ttk


root = Tk()
frm = ttk.Frame(root, padding=10)
frm.grid()
ttk.Label(frm, text="Hello World!").grid(column=0, row=0)
ttk.Button(frm, text="Quit", command=root.destroy).grid(column=1, row=0)
root.mainloop()
