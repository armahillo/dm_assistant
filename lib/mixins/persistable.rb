module Persistable
  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def default_filename
      "./userdata/#{self.class.name}-#{(Time.now.to_f * 10_000).to_i}.yml"
    end

    def save(filename = nil)
      filename ||= default_filename
      File.open(filename, 'w') do |f|
        f.write(to_yaml)
      end
    end
  end

  module ClassMethods
    def load(filename)
      raise StandardError "#{filename} not found" unless File.exist?(filename)

      data = YAML.load(File.read(filename))
      self.new(data)
    end
  end
end