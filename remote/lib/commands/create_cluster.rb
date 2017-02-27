define_method(:create_cluster) do |create = false|
  strategy = Settings.swarm.strategy

  if create
    puts "Create new Swarm cluster with strategy #{strategy.colorize(:red)}"
  else
    puts "Add nodes to Swarm cluster"
  end

  threads = Node.all.map do |node|
    Thread.new do
      sleep rand(2)

      node_commands = [
        docker[:rm].call(Settings.node_localhost, '-f', 'swarm-node'),
        'sudo rm /etc/docker/key.json',
        'sudo service docker restart'
      ]

      puts ssh_exec(node.ip, node_commands)
    end
  end

  create && threads << Thread.new do
    manager_commands = [
      docker[:rm].call(localhost, '-f', 'swarm-manager'),
      # docker[:rm].call(Settings.node_localhost, '-f', 'swarm-node'),
      'sudo rm /etc/docker/key.json',
      'sudo service docker restart'
    ]
    puts ssh_exec(Node.manager.ip, manager_commands) if create
  end

  threads.each{ |thread| thread.join }

  if create
    puts "Create Consul key-value store"

    consul_create = [
      docker[:rm].call(localhost, '-f', 'consul'),
      docker[:run].call(localhost, "-d -p #{Settings.consul_port}:8500 -h consul --name consul", 'progrium/consul', '-server -bootstrap')
    ]

    puts ssh_exec(Settings.consul_ip, consul_create)
    sleep 10
  end

  Node.all.map do |node|
    sleep rand(2)

    Thread.new do
      node_commands = [
        swarm[:join].call(node.ip)
      ]
      puts ssh_exec(node.ip, node_commands)
    end
  end
  .each{ |thread| thread.join }

  # manager_commands = [
  #   swarm[:manage].call(Node.manager.ip, Settings.manager_docker_port, strategy),
  #   swarm[:join].call(Node.manager.ip)
  # ]
  manager_commands = [
    swarm[:manage].call(Node.manager.ip, Settings.manager_docker_port, strategy)
  ]
  puts ssh_exec(Node.manager.ip, manager_commands) if create

  manager_commands = [
    swarm[:list].call(),
    docker[:info].call(Settings.manager_localhost)
  ]
  puts ssh_exec(Node.manager.ip, manager_commands)
end
