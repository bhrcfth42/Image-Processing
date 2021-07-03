# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

from PIL import Image

import math

def rgb_to_hsv(r, g, b):
    r = float(r)
    g = float(g)
    b = float(b)
    high = max(r, g, b)
    low = min(r, g, b)
    h, s, v = high, high, high

    d = high - low
    s = 0 if high == 0 else d/high

    if high == low:
        h = 0.0
    else:
        h = {
            r: (g - b) / d + (6 if g < b else 0),
            g: (b - r) / d + 2,
            b: (r - g) / d + 4,
        }[high]
        h /= 6
    h=int(h)
    s=int(s)
    v=int(v)
    return h, s, v

def hsv_to_rgb(h, s, v):
    i = math.floor(h*6)
    f = h*6 - i
    p = v * (1-s)
    q = v * (1-f*s)
    t = v * (1-(1-f)*s)

    r, g, b = [
        (v, t, p),
        (q, v, p),
        (p, v, t),
        (p, q, v),
        (t, p, v),
        (v, p, q),
    ][int(i%6)]
    r=int(h)
    g=int(s)
    b=int(v)
    return r, g, b

"""
def rgbtohsv(r, g, b):
    r, g, b = r/255.0, g/255.0, b/255.0
    Cmax = max(r, g, b)
    Cmin = min(r, g, b)
    delta = Cmax - Cmin
    if delta == 0:
        h = 0
    elif Cmax == r:
        h = (60 * ((g-b)/delta)) % 360
    elif Cmax == g:
        h = (60 * ((b-r)/delta) + 2) % 360
    elif Cmax == b:
        h = (60 * ((r-g)/delta) + 4) % 360
    if Cmax == 0:
        s = 0
    else:
        s = delta/Cmax
    v = Cmax 
    h=int(h)
    s=int(s)
    v=int(v)
    return h, s, v
"""
image=Image.open("odevrenkli.bmp")
image_pix = image.load()
wdh=image.size[0]
hgh=image.size[1]

for i in range(wdh):
    for j in range(hgh):
        r, g, b = image.getpixel((i, j))
        h, s, v = rgb_to_hsv(r, g, b)
        image_pix[i,j] = (h, s, v)
        
"""image.save("hsv.bmp")"""
image.show()