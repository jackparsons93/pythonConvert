import tkinter as tk
from tkinter import filedialog
import ffmpeg
import os

class App(tk.Tk):

    def __init__(self):
        tk.Tk.__init__(self) # create window

        self.filename = "" # variable to store filename
        

        tk.Button(self, text='Browse', command=self.openfile).pack()
        tk.Button(self, text='Print filename', command=self.printfile).pack()
        
        self.spinbox = tk.Spinbox(self, values=(".wmv", ".mp4",".avi", ".mpeg", ".flv" , ".mov"))
        self.spinbox.pack(pady=10)
        tk.Button(self, text='CONVERT TO SELECTED VIDEO TYPE', command=self.convert).pack()
       
        self.mainloop()

    def printspinbox(self):
        print(self.spinbox.get())

    def openfile(self):
        self.filename = filedialog.askopenfilenames(title="Open file")
        for file in self.filename:
            self.l=tk.Label(self, text=file)
            self.l.pack()
        

    def printfile(self):

        print(self.filename)
        if(os.name=="posix"):
            print(self.filename[0].split("/")[-1])
        else:
            print(self.filename[0].split("\\")[-1])
        #print(self.splitlist(self.filename))
    def convert(self):
        for file in self.filename:
            stream=ffmpeg.input(file)
            stream=stream.output(stream, file+self.spinbox.get())
            ffmpeg.run(stream)

if __name__ == '__main__':
    App()