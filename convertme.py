import ffmpeg
stream = ffmpeg.input('input.mp4')
#stream = ffmpeg.hflip(stream)
stream = ffmpeg.output(stream, 'output.wmv')
ffmpeg.run(stream)