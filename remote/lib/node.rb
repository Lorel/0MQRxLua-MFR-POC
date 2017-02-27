require_relative 'settings'

class Node
  attr_accessor :ip, :name, :roles, :type

  def initialize(ip:, name:, roles:)
    @ip = ip
    @name = name
    @roles = roles
    @type = roles.first
  end

  @@nodes = Settings.nodes.map do |node|
    self.new(ip: node.ip, name: node.name, roles: [node.role || node.roles].flatten.map(&:to_sym))
  end

  def self.all
    @@nodes
  end

  def self.with_roles(*roles)
    @@nodes.reject { |n| (n.roles & roles.map(&:to_sym)).empty? }
  end

  def self.without_roles(*roles)
    @@nodes.select { |n| (n.roles & roles.map(&:to_sym)).empty? }
  end

  def self.manager
    self.new(ip: Settings.manager, name: 'manager', roles: [:manager])
  end

  def sgx?
    @roles.include?(:sgx)
  end
end
