# create /src dir

# create package within /src
ros2 pkg create <name> --build-type ament_cmake

# create /scripts
    # also include __init__.py

# edit package.xml & CMakeList.txt to include all dependencies
    # in CMakeList.txt: 
    ament_python_install_package(scripts) # point to where __init__.py exists

# do script work

# make scripts executable
chmod +x name.py

# build + source
colcon build
source install/setup.bash

# verify package is built
ros2 pkg list

# verify executables in package
ros2 pkg executables pkg_name
