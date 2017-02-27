define_method(:test_cluster) do
  puts 'List cluster nodes:'.colorize(:blue)

  manager_commands = [
    swarm[:list].call(),
    docker[:info].call(Settings.manager_localhost)
  ]
  puts ssh_exec(Node.manager.ip, manager_commands)

  Node.all.each do |node|
    run_hello_world_command = docker[:run].call(Settings.manager_localhost, "-it --rm -e constraint:node==#{node.name}", 'hello-world')

    puts "Run hello-world on node #{node.name}:".colorize(:blue)
    puts ssh_exec(Node.manager.ip, run_hello_world_command, pty: true)
  end
end
