## Archlinux with tesseract and opencv

This is a test environment for running makeflow workflows. It builds an archlinux image with python, opencv, tesseract, and cctools. 

read_image.py: Reads image in /data called user.png and outputs text recognition from that image to a file called output.txt


Build image
```
docker build -t tesseract .
```

Run image
```
docker run -it tesseract
```

I've included a makeflow jx file to run the image recognition to output the results to a file called output.txt

To run the makeflow job execute the following from the interactive archlinux container:
```
makeflow --jx scanner.jx 
```
This can be done either from /workspaces/my-archlinux to output to the devenvironment directory or from /app since I copied the local files to /app in the Dockerfile. The test image should also be here in under /app/data/user.png.

My current setup uses a vscode dev container which I can populate with new image files while having the container open. Output files get sent to the directory where the devcontainer was created.

