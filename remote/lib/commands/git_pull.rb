define_method(:git_pull) do |branch = 'master'|
  commands = [
    "cd #{Settings.poc.working_dir}/#{Settings.poc.project_name}",
    "git fetch",
    "git checkout #{branch}",
    "git pull",
    "cd #{Settings.poc.working_dir}/#{Settings.poc.project_name}/#{Settings.poc.experiment_path}/test",
    "cp -f ../data-stream.lua data-stream.lua",
    "cp -f ../map-csv-to-event.lua map-csv-to-event.lua",
    "cp -f ../filter-event.lua filter-event.lua",
    "cp -f ../reduce-events.lua reduce-events.lua",
    "cp -f ../print-results.lua print-results.lua",
    "cp -f ../router.lua router.lua",
    "cp -f ../sgx-map-csv-to-event.lua sgx-map-csv-to-event.lua"
  ]

  Node.all.push(Node.manager).map do |node|
    sleep rand(2)
    Thread.new do
      ssh_exec(node.ip, commands)
    end
  end
  .each{ |thread| thread.join }
end
