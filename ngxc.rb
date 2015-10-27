module Ngxc
  class Configurable

    class << self
      def directive(*names)
        names.each do |name|
          define_method(name) do |*args, &block|
            directives << Directive.new(name, *args, &block)
          end
        end
      end

      def define(name, &block)
        define_method(name) do |*args|
          raise ArgumentError, "Wrong number of arguments (#{args.size} for #{block.arity})" unless args.size == block.arity
          instance_exec(*args, &block)
        end
      end
    end

    directive :user, :worker_processes, :worker_connections, :include, :default_type,
              :pid, :error_log,
              :server_name,
              :ssl_certificate, :ssl_certificate_key,
              :ssl_session_cache, :ssl_session_timeout, :ssl_ciphers, :ssl_prefer_server_ciphers,
              :events, :http, :server    

    def directives
      @directives ||= []
    end
    
    private
    
    def pad(string, indent)
      "#{' ' * indent}#{string}"
    end
  end

  class Directive < Configurable

    def initialize(name, *args, &block)
      @name = name.to_sym
      @simple = !block_given?
      @args = args
      instance_exec(&block) if block_given?
    end
    
    def block?
      not simple?
    end
    
    def simple?
      !!@simple
    end
    
    def to_conf(indent = 0)
      arglist = @args.map(&:to_s).join(' ')
      arglist = " #{arglist}" if @args.size > 0
      if simple?
        pad("#{@name}#{arglist};\n", indent)
      else
        "\n#{pad(@name, indent)}#{arglist} {\n#{directives.map { |d| d.to_conf(indent + 4)}.join}#{pad('', indent)}}\n"
      end
    end
    
  end
  
  class Configuration < Configurable

    def initialize(file)
      @root_path = File.dirname(file)
      instance_eval(File.read(file), file)
    end
    
    def load(path)
      path = File.join(@root_path, path) unless path.start_with?('/')
      raise "Path not found: #{path}" unless File.directory?(File.dirname(path))
      Dir.glob(path).each do |file|
        instance_eval File.read(file), file #if File.file?(file)
      end
    end
    
    def directive(*names)
      Configurable.directive(*names)
    end

    def define(name, &block)
      Configurable.define(name, &block)
    end
    
    def to_conf(indent = 0)
      directives.map(&:to_conf).join.strip
    end
    
  end
  
end
