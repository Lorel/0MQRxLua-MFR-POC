require 'colorize'

module WithSymbol
  refine Symbol do
    def with(*args, &block)
      ->(caller, *rest) { caller.send(self, *rest, *args, &block) }
    end
  end
end

using WithSymbol

# commands
define_method(:commands) do
  {
    help: {
      command: :notice,
      description: "Print this usage notice"
    },
    version: {
      command: :version,
      description: "Print used version of Swarm"
    },
    ping: {
      command: :ping,
      description: "Check if connexions for each VM are well configured"
    },
    init: {
      command: :init_nodes,
      description: "Initialize nodes by getting repository"
    },
    create: {
      command: :create_cluster,
      description: "Create cluster"
    },
    network: {
      command: :create_network,
      description: "Create Docker overlay network"
    },
    hostnames: {
      command: :set_hostnames,
      description: "Set node hostnames"
    },
    config_docker: {
      command: :config_docker,
      description: "Upgrade Docker with the last release, and configure"
    },
    pull: {
      command: :git_pull,
      description: "Pull git repository on the branch given as argument (default `master`)"
    }
  }
end

commands.values.map(&:[].with(:command)).each do |command|
  file = "commands/#{command}"
  begin
    require_relative file
  rescue LoadError
    puts "WARN: file #{file}.rb not found".colorize(:red)
  end
end

define_method(:create_network) do
  puts "NOT IMPLEMENTED"
end





# handle ARGS
notice if ARGV.empty?
until ARGV.empty? do
  arg = ARGV.shift

  if commands[arg.to_sym]
    params = []
    while !ARGV.empty? && commands[ARGV[0].to_sym].nil? do
      params << ARGV.shift
    end

    send(commands[arg.to_sym][:command], *params)
  else
    puts "#{arg} is not a valid command\n\n".colorize(:red)
    notice
    break
  end
end