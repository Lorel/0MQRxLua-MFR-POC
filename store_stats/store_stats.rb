#!/usr/bin/env ruby

require 'docker'

OUTPUT_DIR = "output/#{Time.now.strftime("%Y%m%d%H%M%S")}"
ERROR_LOGS = "#{OUTPUT_DIR}/errors.log"
DOCKER_URL = "tcp://0.0.0.0:2381"

# containers = {} # { 'id': 'name', ... }

Docker.url = DOCKER_URL

# def store_logs_from_containers(containers_hash)
#   containers_hash.map do |id,name|
#     store_logs_from_container(id, "#{OUTPUT_DIR}/stats-#{name}.json")
#   end
# end
#
# def running_containers_hash
#   Docker::Container.all.map do |c|
#     [c.id, c.info["Names"].first.split('/').last]
#   end.to_h
# end
#
# def new_containers_hash
#   running_containers_hash.reject do |k,v|
#     containers.keys.include? k
#   end
# end


FileUtils.mkdir_p OUTPUT_DIR

fork_pid = fork do
  pids = []
  output_files = []

  def store_logs_from_container(container_id, output)
    File.open(output, 'w') { |f| f.write("[\n") }
    read, write = IO.pipe
    [
      spawn({}, "curl -sSN http://0.0.0.0:2381/containers/#{container_id}/stats", out: write, err: ERROR_LOGS),
      spawn({}, "awk '{print $1\",\"}'", in: read, out: output)
    ]
  end

  Signal.trap('TERM') do
    pids.flatten.each do |pid|
      Process.kill('TERM', pid)
    end

    output_files.each do |file|
      pid = spawn({}, "echo '[' | cat - #{file + '.tmp'} | sed '$ s/,$/\]/'", out: file)
      spawn({}, "wait #{pid} && rm -f #{file + '.tmp'}")
    end
    exit
  end

  begin
    Docker::Event.stream do |event|
      if event.status == 'create'
        output = "#{OUTPUT_DIR}/stats-#{event.actor.attributes["name"]}.json"
        output_files << output
        pids << store_logs_from_container(event.id, output + '.tmp')
      end
    end

  rescue Docker::Error::TimeoutError
    retry
  end
end

Signal.trap('TERM') do
  Process.kill('TERM', fork_pid)
  exit
end

# Process.wait

puts fork_pid
