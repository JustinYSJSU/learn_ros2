# verify node + sysaction 
sudo systemctl status ros2-publisher.service
sudo systemctl status ros2-validator.service
ros2 node list
ros2 topic echo /imu_data

# restart sysaction
sudo systemctl start ros2-publisher.service
sudo systemctl start ros2-validator.service

# stop / start daemon
ros2 daemon stop
ros2 daemon start