FROM arch-x11-i3

RUN pacman -S --noconfirm \
      firefox \
      chromium \
      keepass \
      docker \
      zsh; \
    echo 'user   ALL = NOPASSWD: ALL' >> /etc/sudoers; \
    su user -c 'cd; git clone https://aur.archlinux.org/pikaur.git'; \
    su user -c 'cd; cdpikaur; makepkg --noconfirm -si'; \
    pushd /home/user/j4-dmenu-desktop; \
    pacman --noconfirm -Upikaur-*; \
    popd; \
    rm -rfpikaur/; \
    sed -i '/^user/d' /etc/sudoers; \
    rm -rf /var/cache/pacman/pkg/*
    
# user
ARG user=user
ARG passwd=user
ARG uid=1000
RUN useradd ${user} -u $uid -p $passwd -m -G adm,audio,video,docker -s /bin/bash

USER $user
WORKDIR /home/$user
RUN ln -s /xinitrc .xinitrc
