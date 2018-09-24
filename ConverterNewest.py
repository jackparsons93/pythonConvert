import tkinter as tk
from tkinter import filedialog
import ffmpeg
import os
from moviepy.editor import *

class App(tk.Tk):

    def __init__(self):
        tk.Tk.__init__(self) # create window
        self.notPaid = True
        self.filename = "" # variable to store filename
        self.dirname="/Users/chriswilson"
        tk.Button(self, text="Choose Output Path", command=self.browsedir).pack()
        tk.Button(self, text='Browse', command=self.openfile).pack()
        tk.Button(self, text='Print filename', command=self.printfile).pack()
        self.spinbox = tk.Spinbox(self, values=(".wmv", ".mp4",".avi", ".mpeg", ".flv" , ".mov"))
        self.spinbox.pack(pady=10)
        tk.Button(self, text='CONVERT TO SELECTED VIDEO TYPE', command=self.convert).pack()
        tk.Button(self, text='Clear Selected Files', command=self.clearFiles).pack()
        
        tk.Button(self, text='Enter Validation code', command=self.validator).pack()
        self.valid=tk.Label(self, text="you are not Validated ")
        self.valid.pack()
        
        self.entry=tk.Entry(self)
        self.entry.pack()
        self.entry.focus_set()
        self.mainloop()

    def printspinbox(self):
        print(self.spinbox.get())

    def clearFiles(self):
        self.filename=[]
        
        self.l.destroy()

    def validator(self):
        if self.entry.get()=="launchcode" :
            print("Validated")
            self.notPaid=False
            self.valid.destroy()
            self.valid=tk.Label(self, text="you are validated")
            self.valid.pack()



    def browsedir(self):
        
        self.dirname = filedialog.askdirectory()
        print(self.dirname)
        #print(self.filename[0].split("/")[-1])



    def openfile(self):
        self.filename = filedialog.askopenfilenames(title="Open file")
        for file in self.filename:
            self.l=tk.Label(self, text=file.split("/")[-1])
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
            clip = VideoFileClip(file)
            if self.notPaid:
                logo = (ImageClip("overlay.png")
                    .set_duration(clip.duration)
                    .resize(height=500) # if you need to resize...
                    .margin(right=8, top=8, opacity=0) # (optional) logo-border padding
                    .set_pos(("right","top")))
                final = CompositeVideoClip([clip, logo])
            else:
                final=clip

            
            final.write_videofile( self.dirname+ "/"  + file.split("/")[-1]+self.spinbox.get(), codec="libvpx")

if __name__ == '__main__':
    App()
