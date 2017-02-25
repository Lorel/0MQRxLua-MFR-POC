define_method(:config_docker) do
  Settings.nodes.map do |node|
    Thread.new do
      sleep rand(2)
      node_commands = [
        # 'sudo apt-get update',
        # 'sudo apt-get install -qy linux-headers-generic docker-engine',
        "sudo sed -i \"/ExecStart.*/c\\ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:#{Settings.node_docker_port} -H unix:///var/run/docker.sock --bip 172.27.0.1/16 --cluster-store=consul://#{Settings.consul_ip}:#{Settings.consul_port} --cluster-advertise=ens3:#{Settings.node_docker_port} --label type=\\\"#{node.role}\\\"\" /lib/systemd/system/docker.service",
        'sudo systemctl daemon-reload',
        'sudo rm /etc/docker/key.json',
        'sudo service docker restart'
      ]
      puts ssh_exec(node.ip, node_commands)
    end
  end
  .each{ |thread| thread.join }
end
