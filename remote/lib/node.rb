require_relative 'settings'

class Node
  attr_accessor :ip, :name, :roles

  def initialize(ip:, name:, roles:)
    @ip = ip
    @name = name
    @roles = roles
  end

  @@nodes = Settings.nodes.map do |node|
    self.new(ip: node.ip, name: node.name, roles: [node.role || node.roles].flatten.map(&:to_sym))
  end

  def self.all
    @@nodes
  end

  def self.roles(*roles)
    puts roles.inspect
    @@nodes.reject { |n| (n.roles & roles.map(&:to_sym)).empty? }
  end
end
