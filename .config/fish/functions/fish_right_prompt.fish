function fish_right_prompt
  set_color $fish_color_autosuggestion 2> /dev/null; or set_color CCC
  date "+%H:%M:%S"
  set_color normal
end
