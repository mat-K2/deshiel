namespace :unicorn do
  desc "Start unicorn for production env."
  task(:start) {
    config = Rails.root.join('config/unicorn.rb')
    sh "bundle exec unicorn_rails -c #{config} -E production -D"
  }

  task "Restart unicorn with USR2"
  task(:restart) { unicorn_signal :USR2 }

  def unicorn_signal(signal)
    Process.kill signal, unicorn_pid
  end

  def unicorn_pid
    begin
      File.read("tmp/pids/unicorn.pid").to_i
    rescue Errno::ENOENT
      raise "Unicorn doesn't seem to be running."
    end
  end
end
