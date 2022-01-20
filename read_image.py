import cv2
import pytesseract
import sys
'''
Prints text from image 
'''

args = sys.argv

if len(sys.argv) < 2:
    print("Usage: python read_image.py <image>")

image_path = str(args[1])
img=cv2.imread(image_path)

text=pytesseract.image_to_string(img)
print(text.strip())