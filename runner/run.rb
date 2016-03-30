require 'rubygems'
require 'usdt'
require 'dtrace/stacktraces'

class Run
  def self.run
    begin
      while true
        work
        sleep 1
      end
    rescue Interrupt
      exit 0
    end
  end

  def self.work
    text = 'doing stuff %d' % Time.now.to_i
    DTraceProvider.fire!(:work, text)
    puts text
  end

  class DTraceProvider
    attr_reader :provider, :probes

    def initialize
      @provider = USDT::Provider.create(:ruby, :sandbox)

      @probes = {
        # args: Class stuff
        work: provider.probe(:run, :work, :string),
      }
    end

    def self.provider
      @provider ||= new.tap do |p|
        p.provider.enable
      end
    end

    def self.fire!(probe_name, *args)
      raise "Unknown probe: #{probe_name}" unless self.provider.probes[probe_name]
      probe = self.provider.probes[probe_name]
      probe.fire(*args) if probe.enabled?
    end
  end
end


Run.run
