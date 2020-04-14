# frozen_string_literal: true

require 'rubocop/rake_task'

desc 'Run RuboCop'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end

task default: %i[rubocop]
