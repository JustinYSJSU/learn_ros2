# change file to executable
chmod +x <file_name>

# create new ros2 package
ros2 pkg create <name> --build-type ament_cmake

# compile + source workspace (run in workspace directory)
colcon build
source install/setup.bash

# list all running nodes
ros2 node list

# list all running topics
ros2 topic list

# list messages from a certain topic
ros2 topic echo <name>

# list node parameters
ros2 param list

# list value of a specfic parameter
ros2 param get /<node> <param_name>

# view type + constraints of param
ros2 param describe /<node> <param_name>

# change / set param value
ros2 param set /<node> <param_name>

# run launch file (make sure scripts & launch file are executables)
ros2 launch <package_name> <launch_file.launch.py>
