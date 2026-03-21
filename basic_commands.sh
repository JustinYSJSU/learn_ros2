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