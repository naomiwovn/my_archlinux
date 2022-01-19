FROM archlinux

COPY data/* /workspaces/my-archlinux/data

RUN pacman -Syu --noconfirm && \
    pacman -S --needed base-devel --noconfirm  && \
    pacman -S git curl sudo go python --noconfirm

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

RUN git clone https://github.com/cooperative-computing-lab/cctools cctools-source && \
    cd cctools-source && \
    ./configure && \
    make && \
    make install

RUN export PATH=~/cctools/bin:$PATH
RUN export PYTHONPATH=~/cctools/lib/$(python -c 'from sys import version_info; print("python{}.{}".format(version_info.major, version_info.minor))')/site-packages:${PYTHONPATH}

RUN sudo pacman -S python-opencv --noconfirm
RUN sudo pacman -S python-pytesseract --noconfirm

WORKDIR /workspaces/my-archlinux