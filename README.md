### Archlinux with tesseract and opencv

Test: Reads image in /data called user.png and outputs text from that image

Build image
```
docker build -t tesseract .
```

Run image
```
docker run -it tesseract
```

Run Container from Docker Hub
```
docker run -it naomiwovn/my-archlinux:tesseract
```

