# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/log-line-parser
# LogLineParser parses loglines
class LogLineParser
  attr_reader :line

  def initialize(line)
    @line = line
  end

  def message
    @message ||= line.gsub(/\[\w+\]:/, '').strip
  end

  def log_level
    @log_level ||= line[/\w+/].downcase
  end

  def reformat
    @reformat ||= "#{message} (#{log_level})"
  end
end
