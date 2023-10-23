# realsense_ros2_foxy
realsense ros2 foxy 

--
### include on this packages
git clone https://github.com/IntelRealSense/librealsense.git -b ros2debian


git clone https://github.com/IntelRealSense/realsense-ros.git -b ros2-legacy


colcon build
. install/setup.bash

ros2 launch realsense2_camera rs_launch.py enable_pointcloud:=true device_type:=d455


![Screenshot from 2023-10-23 22-13-32](https://github.com/Carpediem324/realsense_ros2_foxy/assets/101110020/ad3eea47-7142-48e1-9348-ba122a4a30f2)
