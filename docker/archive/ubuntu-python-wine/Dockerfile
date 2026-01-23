FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV WINEDEBUG=fixme-all
ENV DISPLAY=""
ENV WINEDLLOVERRIDES="winemenubuilder.exe,drmingw.exe=d"

# Core dependencies + Ubuntu's native Wine
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y \
        wget ca-certificates \
        cabextract p7zip-full \
        python3 python3-pip \
        xvfb x11-apps \
        wine-stable winetricks \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Download installers
RUN wget https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe \
    && wget https://aka.ms/vs/17/release/vc_redist.x64.exe

# Install Python + VC++ Redist (headless)
RUN xvfb-run --auto-servernum \
    wine python-3.10.11-amd64.exe \
    /quiet InstallAllUsers=1 PrependPath=1 TargetDir="C:\\Python310" \
    && rm python-3.10.11-amd64.exe

RUN xvfb-run --auto-servernum \
    wine vc_redist.x64.exe /quiet /norestart \
    && rm vc_redist.x64.exe

# Install Python packages
ENV PATH="/root/.wine/drive_c/Python310:/root/.wine/drive_c/Python310/Scripts:${PATH}"
RUN winepython -m pip install --upgrade pip \
    && winepython -m pip install \
        pyinstaller==5.13.2 \
        pywin32==306 \
        pandas==1.5.3 \
        openpyxl==3.1.2

WORKDIR /src
VOLUME /src

CMD ["winepython", "-m", "PyInstaller", "--clean", "--onefile", "main.py"]
