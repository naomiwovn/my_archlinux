FROM archlinux

# COPY read_image.py /app/read_image.py
# COPY data /app/data

RUN pacman -Syu --noconfirm && \
    pacman -S --needed base-devel --noconfirm  && \
    pacman -S git curl sudo go python wget --noconfirm

# makepkg requires non-root user AND requires a password for sudoers
# Make new user and remove password requirements
RUN useradd -m -G wheel iwovn 
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /home/iwovn
RUN git clone https://aur.archlinux.org/yay.git
RUN chown iwovn yay && pwd && ls -al

USER iwovn 
RUN cd yay && makepkg -i -A --noconfirm
RUN yay -Syu

# RUN git clone https://github.com/cooperative-computing-lab/cctools cctools-source && \
#     cd cctools-source && \
#     ./configure && \
#     make && \
#     make install

# RUN export PATH=~/cctools/bin:$PATH
# RUN export PYTHONPATH=~/cctools/lib/$(python -c 'from sys import version_info; print("python{}.{}".format(version_info.major, version_info.minor))')/site-packages:${PYTHONPATH}

RUN yay -S tesseract-git --noconfirm
RUN yay -S tesseract-data-eng --noconfirm

RUN sudo pacman -S python-opencv --noconfirm
RUN sudo pacman -S python-pytesseract --noconfirm

# RUN yay -S tesseract-ocr-git --noconfirm

# RUN wget https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata -O /usr/share/tessdata/eng.traineddata 2> /dev/null

# WORKDIR /app
# CMD ["python","read_image.py"]