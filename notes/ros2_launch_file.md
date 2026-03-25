# ROS 2 - Launch File

### Creating a Launch File
--------------------------
- A launch file is used to run multiple nodes, processes, etc from a single command.
- By using a launch file, you don't need to open a separate terminal for each node, etc.
- Configure in Python by:
    - Navigate to `src/<package_name>` directory
    - Create 'launch' folder: `mkdir launch`
    - Create a `.launch.py` file: `file_name.launch.py` (it's okay to have 2 file extensions)

### Writing a Launch File
-------------------------
- Ensure that all scripts and the launch file itself are of type executable: `chmod +x <file_name>`
- In `.launch.py` file, import:
```
from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import ExecuteProcess
```
- Then, declare `generate_launch_description` function:
```
def generate_launch_description():
    '''
    upon running,  will launch the specificed Node & execute the below cmd
    '''
    return LaunchDescription([
        Node(
            package="project_one",
            executable=("publisher.py"),
            name="rpm_pub_node"
        ), 
        ExecuteProcess(
            cmd=['ros2', 'topic', 'list'],
            output="screen"
        )
    ]
    )
```
- `LaunchDescription` object takes a list paramter with all the nodes, commands, etc to execute upon running

### Running a launch file
-------------------------
- Build pacakge, ensure all scripts & launch file are executables
- Navigate to pacakge, and run `ros2 launch <package_name> <launch_file.launch.py>`