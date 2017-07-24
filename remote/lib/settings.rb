require 'yaml'

class Settings
  def self.create_section(name, settings)
    self.class.instance_eval do
      define_method(name) do
        settings
      end

      settings.each do |key, value|
        next unless key.is_a? String

        self.send(name).define_singleton_method(key) do
          value.freeze
        end
      end
    end
  end

  begin
    @@settings = YAML::load_file('config.yml')
  rescue Exception => e
    raise "Something is wrong with your config.yml file: #{e.message}"
  end

  @@settings.each do |key, value|
    create_section(key, value || [])
  end

  # add methods for nodes
  self.nodes.each do |node|
    [:ip, :name, :role, :roles, :network_if, :type].each do |attribute|
      node.define_singleton_method(attribute) { node[attribute.to_s] }
    end
  end

  self.define_singleton_method(:manager) { self.cluster.manager }
  self.define_singleton_method(:manager_docker_port) { self.cluster.manager_docker_port }
  self.define_singleton_method(:node_docker_port) { self.cluster.node_docker_port }
  self.define_singleton_method(:manager_localhost) { "localhost:#{manager_docker_port}" }
  self.define_singleton_method(:node_localhost) { "localhost:#{node_docker_port}" }
  self.define_singleton_method(:consul_ip) { self.cluster.consul_ip }
  self.define_singleton_method(:consul_port) { self.cluster.consul_port }
  self.define_singleton_method(:network_name) { self.cluster.network_name }
  # self.define_singleton_method(:nodes) { self.nodes }
end
