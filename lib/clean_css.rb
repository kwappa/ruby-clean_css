# -*- coding: utf-8 -*-
require "popen4"
require "clean_css/version"

class CleanCss
  def initialize options = {}
    @options = options
  end

  def command
    @options[:command] || 'cleancss'
  end

  def compress(stream_or_string)
    streamify(stream_or_string) do |stream|
      output = true
      status = POpen4.popen4(command, "b") do |stdout, stderr, stdin, pid|
        begin
          stdin.binmode
          transfer(stream, stdin)

          if block_given?
            yield stdout
          else
            output = stdout.read
          end

        rescue Exception => e
          raise StandardError, "compression failed"
        end
      end

      if status.exitstatus.zero?
        output
      else
        raise StandardError, "compression failed"
      end
    end
  end

  private
  def streamify(stream_or_string)
    if stream_or_string.respond_to?(:read)
      yield stream_or_string
    else
      yield StringIO.new(stream_or_string.to_s)
    end
  end

  def transfer(from_stream, to_stream)
    while buffer = from_stream.read(4096)
      to_stream.write(buffer)
    end
    from_stream.close
    to_stream.close
  end
end
