app_dir = "/app"

working_directory app_dir

pid "#{app_dir}/unicorn.pid"

stderr_path "#{app_dir}/unicorn.stderr.log"
stdout_path "#{app_dir}/unicorn.stdout.log"

worker_processes 1
listen "#{app_dir}/unicorn.sock", :backlog => 64
timeout 30
