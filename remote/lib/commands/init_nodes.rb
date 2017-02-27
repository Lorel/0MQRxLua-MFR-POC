define_method(:init_nodes) do
  commands = [
    "rm -rfv #{Settings.poc.working_dir}",
    "ssh-keyscan -H github.com >> ~/.ssh/known_hosts",
    "ssh -T git@github.com",
    "mkdir -p #{Settings.poc.working_dir}",
    "cd #{Settings.poc.working_dir}",
    "git clone #{Settings.poc.remote_repo} #{Settings.poc.project_name}",
    "ls -al",
    "cd #{Settings.poc.working_dir}/#{Settings.poc.project_name}/#{Settings.poc.experiment_path}/test",
    "cp -f ../data-stream.lua data-stream.lua",
    "cp -f ../map-csv-to-event.lua map-csv-to-event.lua",
    "cp -f ../filter-event.lua filter-event.lua",
    "cp -f ../reduce-events.lua reduce-events.lua",
    "cp -f ../print-results.lua print-results.lua",
    "cp -f ../router.lua router.lua",
    "hostname"
  ]

  Node.all.map do |node|
    sleep rand(2)
    Thread.new do
      puts ssh_exec(node.ip, commands)
    end
  end
  .each{ |thread| thread.join }

  data_files = {
    data1: '2005',
    data2: '2006',
    data3: '2007',
    data4: '2008'
  }

  data_files.map do |data,file|
    Node.with_roles(data).map do |node|
      commands = [
        'cd /home/ubuntu/zmqrxlua/zmqrxlua-poc/experiment/test/data',
        "wget http://stat-computing.org/dataexpo/2009/#{file}.csv.bz2 && bzip2 -d #{file}.csv.bz2"
      ]

      Thread.new do
        puts ssh_exec(node.ip, commands.dup)
      end
    end
  end
  .flatten
  .each{ |thread| thread.join }
end
