# Swarm docker commands
def localhost
  'localhost:2375'
end

def swarm
  {
    create: ->{ docker[:run].call(localhost, '--rm', Settings.swarm.image, 'create') },
    # create_node: ->(node_name, cpu, type){ docker[:run].call(localhost, "-d -p #{Settings.node_docker_port}:2375 --privileged --name docker -h #{node_name} --restart=always --cpuset-cpus=\"1-#{cpu - 1}\" --memory 7G --memory-swap 0 -v /home/ubuntu/var-lib-docker:/var/lib/docker", Settings.swarm.host_image, "--bip 172.28.0.1/16 --label generation='#{type}'") },
    create_node: ->(node_name, cpu, type){ docker[:run].call(localhost, "-d -p #{Settings.node_docker_port}:2375 --privileged --name docker -h #{node_name} --restart=always --cpuset-cpus=\"1-#{cpu - 1}\" --memory 7G -v /home/ubuntu/var-lib-docker:/var/lib/docker", Settings.swarm.host_image, "--bip 172.28.0.1/16 --label generation='#{type}'") },
    version: ->{ docker[:run].call(localhost, '--rm', Settings.swarm.image, '--version') },
    list: ->(){ docker[:run].call(localhost, '--rm', Settings.swarm.image, "list consul://#{Settings.consul_ip}:#{Settings.consul_port}") },
    join: ->(node){ docker[:run].call(Settings.node_localhost, '-d -p 2380:2375 -e DEBUG=true --name=swarm-node', Settings.swarm.image, "join --advertise=#{ip(node)}:#{Settings.node_docker_port} consul://#{Settings.consul_ip}:#{Settings.consul_port}") },
    # manage: ->(manager, port, strategy){ docker[:run].call(localhost, "-d -p #{port}:2375 -e INFLUXDB_HOST=influxsrv -e INFLUXDB_PORT=8086 -e INFLUXDB_NAME=cadvisor -e INFLUXDB_USER=root -e INFLUXDB_PASS=root --link=\"InfluxSrv:influxsrv\" --name=swarm-manager", Settings.swarm.image, "manage --strategy #{strategy} token://#{cluster_id}") }
    manage: ->(manager, port, strategy){ docker[:run].call(localhost, "-d -p #{port}:2375 -e DEBUG=true --name=swarm-manager -h swarm", Settings.swarm.image, "manage --strategy #{strategy} --engine-failure-retry \"10\" -H :2375 --replication --advertise #{manager}:#{port} consul://#{Settings.consul_ip}:#{Settings.consul_port}") }
  }
end
