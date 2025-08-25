# README

[中文](README-zh_CN.md) | English

1. Project Name: ros-noetic-jazzy-noble
2. Version: v1.0
3. State: Pre-Release
4. Author: Tung Chia-hui
5. Website: [https://github.com/tungchiahui](https://github.com/tungchiahui)
6. E-mail: tungchiahui@gmail.com
7. Organization: SDUT_EMIS_VinciRobot
8. Date: 2024-10-03
9. Future Features: 
    1. Find Error.

## 容器构建指令
```bash
sudo docker run -Pdit \
--gpus all \
--name=ROS_learn \
--privileged \
-e NVIDIA_DRIVER_CAPABILITIES=all \
-e DISPLAY=$DISPLAY \
-e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
-e QT_QPA_PLATFORM=wayland \
-v /home/yuanluochen:/home/yuanluochen \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
-v /run/user/$(id -u)/wayland-0:/run/user/1000/wayland-0:rw \
-v /dev/dri:/dev/dri \
--device=/dev/snd \
--device=/dev/dri/renderD128 \
--net=host \
--ipc=host \
-w /home/yuanluochen \
yuanluochen/machine-vision:1.0
```
