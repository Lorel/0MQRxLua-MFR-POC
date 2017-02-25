define_method(:set_hostnames) do
  set_hostname = ->(name){
    [
      "sudo hostname #{name}",
      "sudo sed -i \"/127\\.0\\.1\\.1.*/c\\127.0.1.1\\t#{name}\" /etc/hosts",
      "sudo -- sh -c 'echo \"#{name}\" > /etc/hostname'"
    ]
  }

  ssh_exec(Settings.manager, set_hostname.call('manager'))
  Settings.nodes.each{ |node| ssh_exec(node.ip, set_hostname.call(node.name)) }
end
