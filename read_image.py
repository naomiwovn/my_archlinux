import cv2
import pytesseract

img=cv2.imread('data/user.png')

text=pytesseract.image_to_string(img)
print(text)