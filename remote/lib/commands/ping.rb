define_method(:ping) do
  Settings.nodes.map do |node|
    sleep 1
    Thread.new do
      puts ssh_exec(node.ip, "echo 'PONG from VM #{node.ip}'")
    end
  end
  .each{ |thread| thread.join }
end
