# ROS 2 - Services

### Creating Interface
----------------------
- Create interface for the service / client
- Defines what data is being exchanged
    - Create new  `/srv` folder
    - Create new `.srv` file
    Ex: 
    ```
    float32 degree # parameter
    ---
    string decision # response
    ```
- View all available interfaces with `ros2 interface list`

### Create Server Node
----------------------
```
#!/usr/bin/env python3
import rclpy
from rclpy.node import Node

from project_one.srv import RobotAngle

class RobotAngleServer(Node):
    def __init__(self):
        super().__init__("robot_angle_server_node") # name of the service node
        self.srv = self.create_service(RobotAngle, 'robot_angle', self.move_angle) # itnerface, service name, callback function
    
    def move_angle(self, request, response):
        print("Request received")
        print(f"Moving robot {request.degree} degrees.")
        response.decision = "Moved the robot." # set decision (name according to .srv file)
        
        return response
def main():
    rclpy.init()
    
    node = RobotAngleServer()

    print("Robot Angle is running...")

    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        print("Terminating node...")
        node.destroy_node()

if __name__ == '__main__':
    main()
```

### Create Client Node
----------------------
```
#!/usr/bin/env python3
import rclpy
from rclpy.node import Node

from project_one.srv import RobotAngle

class RobotAngleClient(Node):
    def __init__(self):
        super().__init__("robot_angle_client_node")
        self.client = self.create_client(RobotAngle, 'robot_angle') # interface, service name (as defined in the server node class)
        self.req = RobotAngle.Request() # creating a request object
    
    def send_angle(self, angle):
        self.req.degree = float(angle) # define parameter values (named as in .srv file)
        self.client.wait_for_service() # waiting for service
        self.future = self.client.call_async(self.req) # wait until response 
        rclpy.spin_until_future_complete(self, self.future)

        self.result = self.future.result()
        return self.result

def main():
    rclpy.init()
    
    node = RobotAngleClient()

    print("RobotAngle is running...")

    try:
        user_input = input("Enter an angle: ")
        result = node.send_angle(user_input)
        print("Service returned: " + result.decision)
    except KeyboardInterrupt:
        print("Terminating node...")
        node.destroy_node()

if __name__ == '__main__':
    main()
```

### Running Client & Server
---------------------------
- Client: `ros2 run <package_name> client_file.py`
- Server: `ros2 run <package_name> server_file.py`
