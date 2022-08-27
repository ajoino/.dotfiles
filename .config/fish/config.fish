if status is-interactive
    # Commands to run in interactive sessions can go here
end

bass source /opt/ros/noetic/setup.bash
if test -e ./devel/setup.bash
  bass source ./devel/setup.bash
end
