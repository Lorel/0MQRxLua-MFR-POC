define_method(:ping) do
  Node.all.map do |node|
    sleep rand(2)
    Thread.new do
      puts ssh_exec(node.ip, "echo 'PONG from VM #{node.ip}'")
    end
  end
  .each{ |thread| thread.join }
end
