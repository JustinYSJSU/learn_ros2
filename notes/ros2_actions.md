# ROS 2 - Action

### Creating Action Interface
----------------------
- Create interface for the action server / client
- Defines what data is being exchanged
    - Create new  `/action` folder
    - Create new `.action` file
    Ex:
    ```
    # Goal
    geometry_msgs/Point goal_point
    ---
    # Action / Result
    float32 elapsed_time
    ---
    # Feedback
    float32 distance_to_point
    ```

### Create Action Service Node
```
#!/usr/bin/env python3
import math
import rclpy
from rclpy.node import Node
from rclpy.action import ActionServer
from project_one.action import Navigate
from geometry_msgs.msg import Point

DISTANCE_THRESHOLD = 0.125
class NavigateActionServer(Node):
    def __init__(self):
        super().__init__("action_server_node")
        self._action_server = ActionServer(self, Navigate, "navigate", self.navigate_callback) # node, action, topic name, callback function # Action service object type
        self.sub = self.create_subscription(Point, "robot_position", self.update_robot_position, 1) # subscribe to position topic, and update as data is generated
        self.robot_current_position = None

    def navigate(self, goal_handle):
        print("Goal Received")
        start_time = self.get_clock().now().to_msg().sec
        # goal_handle is the request from Navigate action
        robot_goal_point = [goal_handle.request.goal_point.x,
                            goal_handle.request.goal_point.y,
                            goal_handle.request.goal_point.z]
        print(f"Goal Point: {str(robot_goal_point)}")
    
        while self.robot_current_position == None:
            print("Current robot position is not detected")
            rclpy.spin_once(self, timeout_sec=3)
        distance_to_goal = math.dist(self.robot_current_position, robot_goal_point)
        feedback_msg = Navigate.Feedback()

        while distance_to_goal > DISTANCE_THRESHOLD:
            distance_to_goal = math.dist(self.robot_current_position, robot_goal_point)
            feedback_msg.distance_to_point = distance_to_goal
            goal_handle.publish_feedback(feedback_msg) 
            rclpy.spin_once(timeout_sec=1)
        
        # goal reached
        goal_handle.succeeded()
        result = Navigate.Result()
        result.elapsed_time = float(self.get_clock().now().to_msg().sec - start_time)

        return result

    def update_robot_position(self, point):
        robot_current_position = [
            point.x, point.y, point.z
        ]

def main():
    rclpy.init()
    
    action_server_node = NavigateActionServer()

    try:
        while rclpy.ok():    
            rclpy.spin_once(action_server_node)
    except KeyboardInterrupt:
        print("Terminating node...")
        action_server_node._action_server.destroy()
        action_server_node.destroy_node()

if __name__ == '__main__':
    main()
```

### Create Action Client Node

```
#!/usr/bin/env python3
import math
import rclpy
from rclpy.node import Node
from rclpy.action import ActionClient
from project_one.action import Navigate
from geometry_msgs.msg import Point

DISTANCE_THRESHOLD = 0.125
class NavigateActionClient(Node):
    def __init__(self):
        super().__init__("action_server_client")
        self._action_client = ActionClient(self, Navigate, 'navigate')
    
    def send_goal(self, x, y, z):
        goal_msg = Navigate.Goal()
        goal_msg.goal_point.x = float(x)
        goal_msg.goal_point.y = float(y)
        goal_msg.goal_point.z = float(z)
        
        self._action_client.wait_for_server()
        self._send_goal_future = self._action_client.send_goal_async(goal_msg, self.feedback_callback)
        self._send_goal_future.add_done_callback(self.goal_response_callback)

    def feedback_callback(self, feedback_msg):
        feedback = feedback_msg.feedback
        print(f"feedback: {str(feedback_msg.distance_to_point)}")
    
    def goal_response_callback(self, future):
        # result of the request being accepeted or rejected initially
        goal_handle = future.result() # result of an object being processed

        if not goal_handle.accepted:
            print("Goal accepted")
            return None
        
        self._get_result_future = goal_handle.get_result_async()
        self._get_result_future.add_done_callback(self.get_result_callback)
    
    def get_result_callback(self, future):
        # actual result of the action
        result = future.result().result
        print(f"Elapsed time: {str(result.elapsed_time)} seconds")
        rclpy.shutdown()

def main():
    rclpy.init()
    
    action_client_node = NavigateActionClient()
    print("Action Client Running")

    try:
        x = input("Enter x: ")
        y = input("Enter y: ")
        z = input("Enter z: ")

        action_client_node.send_goal(x, y, z)
        rclpy.spin(action_client_node)
    except KeyboardInterrupt:
        print("Terminating node...")
        action_client_node.destroy_node()

if __name__ == '__main__':
    main()
```