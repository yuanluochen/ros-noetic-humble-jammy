# 使用Ubuntu 22.04作为基础镜像
FROM ubuntu:22.04

# 设置环境变量以防止交互安装
ENV DEBIAN_FRONTEND=noninteractive

# 替换为北京外国语大学的D镜像源
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirrors.bfsu.edu.cn/ubuntu/|g' /etc/apt/sources.list && \
    sed -i 's|http://security.ubuntu.com/ubuntu/|http://mirrors.bfsu.edu.cn/ubuntu/|g' /etc/apt/sources.list

# 更新包管理器，安装必要工具（locales, software-properties-common, curl, gnupg2）
RUN apt-get update && apt-get install -y \
    locales \
    software-properties-common \
    curl \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# 生成和设置en_US.UTF-8 locale
RUN locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# 设置环境变量以确保locale被正确使用
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8


# 添加universe存储库
RUN add-apt-repository universe

# 添加ROS 2的密钥和源
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] https://mirrors.bfsu.edu.cn/ros2/ubuntu jammy main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# 更新包管理器并安装ROS 2 Humble desktop
RUN apt-get update && apt-get install -y \
    ros-humble-desktop \
    ros-dev-tools \
    ros-humble-xacro \
    ros-humble-joint-state-publisher \
    ros-humble-joint-state-publisher-gui \
    ros-humble-ros-gz \
    ros-humble-diagnostic-updater \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    ros-humble-slam-toolbox \
    ros-humble-cartographer \
    ros-humble-cartographer-ros \
    ros-humble-asio-cmake-module \
    ros-humble-serial-driver \
    libpcap-dev \
    python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists/*

# 安装ROS1 Noetic
# 添加ROS for Noble的PPA
RUN add-apt-repository ppa:ros-for-jammy/noetic

# 更新包列表并安装ROS Noetic desktop full
RUN apt-get update && apt-get install -y \
    ros-noetic-desktop-full \
    && rm -rf /var/lib/apt/lists/*

# 添加自定义ROS环境切换到.bashrc
RUN echo 'function env_ros_noetic() { source /opt/ros/noetic/setup.bash; echo "ROS Noetic environment sourced."; }' >> /root/.bashrc \
    && echo 'function env_ros_humble() { source /opt/ros/humble/setup.bash; echo "ROS humble environment sourced."; }' >> /root/.bashrc

# 启用NVIDIA显卡支持（仅当使用NVIDIA显卡时）
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

# 设置QT的显示平台为xcb
# ENV QT_QPA_PLATFORM=xcb

# 启动时默认进入bash shell
CMD ["bash"]