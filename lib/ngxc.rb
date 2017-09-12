module Ngxc
  VERSION = '0.2.1'
  
  class Text
    def initialize(text)
      @text = text
    end
    
    def block?; false; end
    def simple?; false; end
    
    def to_conf(indent = 0)
      "#{' ' * indent}#{@text}\n"
    end
  end
  
  class Configurable
    @@root_path = ''
    @@directives = []
    @@aliases = {}
    @@block_stack = []
    
    class << self
      def root_path
        @@root_path
      end
      
      def root_path=(path)
        @@root_path = path
      end
      
      def directive(*names)
        @@directives.concat(names.map(&:to_sym)).uniq!
      end
      
      def alias_directive(*args)
        if args.last.is_a?(Hash)
          options = args.pop
          @@aliases.merge!(options)
          directive(*options.keys)
        end
        args.each do |name|
          aliased = "#{name}!".to_sym
          @@aliases[aliased] = name.to_sym
          directive aliased
        end
      end
      
      def directive?(name)
        @@directives.include?(name)
      end
      
      def define(name, &defn)
        define_method(name) do |*args, &block|
          begin
            @@block_stack.push block
            instance_exec(*args, &defn)
          ensure
            @@block_stack.pop
          end
        end
      end
      
    end

    directive :accept_mutex, :accept_mutex_delay, :access_log, :add_after_body, :add_before_body, :add_header,
              :addition_types, :aio, :allow, :ancient_browser, :ancient_browser_value, :auth_basic, :auth_basic_user_file,
              :auth_http, :auth_http_header, :auth_http_pass_client_cert, :auth_http_timeout, :auth_request,
              :auth_request_set, :autoindex, :autoindex_exact_size, :autoindex_format, :autoindex_localtime,
              :charset, :charset_map, :charset_types, :chunked_transfer_encoding, :client_body_buffer_size,
              :client_body_in_file_only, :client_body_in_single_buffer, :client_body_temp_path, :client_body_timeout,
              :client_header_buffer_size, :client_header_timeout, :client_max_body_size, :connection_pool_size,
              :create_full_put_path, :daemon, :dav_access, :dav_methods, :debug_connection, :debug_points, :default_type,
              :deny, :directio, :directio_alignment, :disable_symlinks, :empty_gif, :env, :error_log, :error_page, :etag,
              :events, :expires, :f4f, :f4f_buffer_size, :fastcgi_bind, :fastcgi_buffer_size, :fastcgi_buffering,
              :fastcgi_buffers, :fastcgi_busy_buffers_size, :fastcgi_cache, :fastcgi_cache_bypass, :fastcgi_cache_key,
              :fastcgi_cache_lock, :fastcgi_cache_lock_age, :fastcgi_cache_lock_timeout, :fastcgi_cache_methods,
              :fastcgi_cache_min_uses, :fastcgi_cache_path, :fastcgi_cache_purge, :fastcgi_cache_revalidate,
              :fastcgi_cache_use_stale, :fastcgi_cache_valid, :fastcgi_catch_stderr, :fastcgi_connect_timeout,
              :fastcgi_force_ranges, :fastcgi_hide_header, :fastcgi_ignore_client_abort, :fastcgi_ignore_headers,
              :fastcgi_index, :fastcgi_intercept_errors, :fastcgi_keep_conn, :fastcgi_limit_rate, :fastcgi_max_temp_file_size,
              :fastcgi_next_upstream, :fastcgi_next_upstream_timeout, :fastcgi_next_upstream_tries, :fastcgi_no_cache,
              :fastcgi_param, :fastcgi_pass, :fastcgi_pass_header, :fastcgi_pass_request_body, :fastcgi_pass_request_headers,
              :fastcgi_read_timeout, :fastcgi_request_buffering, :fastcgi_send_lowat, :fastcgi_send_timeout,
              :fastcgi_split_path_info, :fastcgi_store, :fastcgi_store_access, :fastcgi_temp_file_write_size,
              :fastcgi_temp_path, :flv, :geo, :geoip_city, :geoip_country, :geoip_org, :geoip_proxy, :geoip_proxy_recursive,
              :gunzip, :gunzip_buffers, :gzip, :gzip_buffers, :gzip_comp_level, :gzip_disable, :gzip_http_version,
              :gzip_min_length, :gzip_proxied, :gzip_static, :gzip_types, :gzip_vary, :hash, :health_check,
              :health_check_timeout, :hls, :hls_buffers, :hls_forward_args, :hls_fragment, :hls_mp4_buffer_size,
              :hls_mp4_max_buffer_size, :http, :http2_chunk_size, :http2_idle_timeout, :http2_max_concurrent_streams,
              :http2_recv_buffer_size, :http2_recv_timeout, :if_modified_since, :ignore_invalid_headers, :image_filter,
              :image_filter_buffer, :image_filter_interlace, :image_filter_jpeg_quality, :image_filter_sharpen,
              :image_filter_transparency, :imap_auth, :imap_capabilities, :imap_client_buffer, :include, :index, :internal,
              :ip_hash, :keepalive, :keepalive_disable, :keepalive_requests, :keepalive_timeout, :large_client_header_buffers,
              :least_conn, :least_time, :limit_conn, :limit_conn_log_level, :limit_conn_status, :limit_conn_zone, :limit_except,
              :limit_rate, :limit_rate_after, :limit_req, :limit_req_log_level, :limit_req_status, :limit_req_zone, :limit_zone,
              :lingering_close, :lingering_time, :lingering_timeout, :listen, :location, :lock_file, :log_format, :log_not_found,
              :log_subrequest, :mail, :map, :map_hash_bucket_size, :map_hash_max_size, :master_process, :match, :max_ranges,
              :memcached_bind, :memcached_buffer_size, :memcached_connect_timeout, :memcached_force_ranges, :memcached_gzip_flag,
              :memcached_next_upstream, :memcached_next_upstream_timeout, :memcached_next_upstream_tries, :memcached_pass,
              :memcached_read_timeout, :memcached_send_timeout, :merge_slashes, :min_delete_depth, :modern_browser,
              :modern_browser_value, :mp4, :mp4_buffer_size, :mp4_limit_rate, :mp4_limit_rate_after, :mp4_max_buffer_size,
              :msie_padding, :msie_refresh, :multi_accept, :ntlm, :open_file_cache, :open_file_cache_errors,
              :open_file_cache_min_uses, :open_file_cache_valid, :open_log_file_cache, :output_buffers, :override_charset,
              :pcre_jit, :perl, :perl_modules, :perl_require, :perl_set, :pid, :pop3_auth, :pop3_capabilities, :port_in_redirect,
              :postpone_output, :protocol, :proxy_bind, :proxy_buffer, :proxy_buffer_size, :proxy_buffering, :proxy_buffers,
              :proxy_busy_buffers_size, :proxy_cache, :proxy_cache_bypass, :proxy_cache_key, :proxy_cache_lock, :proxy_cache_lock_age,
              :proxy_cache_lock_timeout, :proxy_cache_methods, :proxy_cache_min_uses, :proxy_cache_path, :proxy_cache_purge,
              :proxy_cache_revalidate, :proxy_cache_use_stale, :proxy_cache_valid, :proxy_connect_timeout, :proxy_cookie_domain,
              :proxy_cookie_path, :proxy_download_rate, :proxy_force_ranges, :proxy_headers_hash_bucket_size,
              :proxy_headers_hash_max_size, :proxy_hide_header, :proxy_http_version, :proxy_ignore_client_abort, :proxy_ignore_headers,
              :proxy_intercept_errors, :proxy_limit_rate, :proxy_max_temp_file_size, :proxy_method, :proxy_next_upstream,
              :proxy_next_upstream_timeout, :proxy_next_upstream_tries, :proxy_no_cache, :proxy_pass, :proxy_pass_error_message,
              :proxy_pass_header, :proxy_pass_request_body, :proxy_pass_request_headers, :proxy_protocol, :proxy_read_timeout,
              :proxy_redirect, :proxy_request_buffering, :proxy_send_lowat, :proxy_send_timeout, :proxy_set_body, :proxy_set_header,
              :proxy_ssl, :proxy_ssl_certificate, :proxy_ssl_certificate_key, :proxy_ssl_ciphers, :proxy_ssl_crl, :proxy_ssl_name,
              :proxy_ssl_password_file, :proxy_ssl_protocols, :proxy_ssl_server_name, :proxy_ssl_session_reuse,
              :proxy_ssl_trusted_certificate, :proxy_ssl_verify, :proxy_ssl_verify_depth, :proxy_store, :proxy_store_access,
              :proxy_temp_file_write_size, :proxy_temp_path, :proxy_timeout, :proxy_upload_rate, :queue, :random_index, :read_ahead,
              :real_ip_header, :real_ip_recursive, :recursive_error_pages, :referer_hash_bucket_size, :referer_hash_max_size,
              :request_pool_size, :reset_timedout_connection, :resolver, :resolver_timeout, :rewrite, :rewrite_log, :root,
              :satisfy, :scgi_bind, :scgi_buffer_size, :scgi_buffering, :scgi_buffers, :scgi_busy_buffers_size, :scgi_cache,
              :scgi_cache_bypass, :scgi_cache_key, :scgi_cache_lock, :scgi_cache_lock_age, :scgi_cache_lock_timeout,
              :scgi_cache_methods, :scgi_cache_min_uses, :scgi_cache_path, :scgi_cache_purge, :scgi_cache_revalidate,
              :scgi_cache_use_stale, :scgi_cache_valid, :scgi_connect_timeout, :scgi_force_ranges, :scgi_hide_header,
              :scgi_ignore_client_abort, :scgi_ignore_headers, :scgi_intercept_errors, :scgi_limit_rate, :scgi_max_temp_file_size,
              :scgi_next_upstream, :scgi_next_upstream_timeout, :scgi_next_upstream_tries, :scgi_no_cache, :scgi_param, :scgi_pass,
              :scgi_pass_header, :scgi_pass_request_body, :scgi_pass_request_headers, :scgi_read_timeout, :scgi_request_buffering,
              :scgi_send_timeout, :scgi_store, :scgi_store_access, :scgi_temp_file_write_size, :scgi_temp_path, :secure_link,
              :secure_link_md5, :secure_link_secret, :send_lowat, :send_timeout, :sendfile, :sendfile_max_chunk, :server, :server_name,
              :server_name_in_redirect, :server_names_hash_bucket_size, :server_names_hash_max_size, :server_tokens, :session_log,
              :session_log_format, :session_log_zone, :set, :set_real_ip_from, :smtp_auth, :smtp_capabilities, :source_charset,
              :spdy_chunk_size, :spdy_headers_comp, :split_clients, :ssi, :ssi_last_modified, :ssi_min_file_chunk, :ssi_silent_errors,
              :ssi_types, :ssi_value_length, :ssl, :ssl_buffer_size, :ssl_certificate, :ssl_certificate_key, :ssl_ciphers,
              :ssl_client_certificate, :ssl_crl, :ssl_dhparam, :ssl_ecdh_curve, :ssl_engine, :ssl_handshake_timeout, :ssl_password_file,
              :ssl_prefer_server_ciphers, :ssl_protocols, :ssl_session_cache, :ssl_session_ticket_key, :ssl_session_tickets,
              :ssl_session_timeout, :ssl_stapling, :ssl_stapling_file, :ssl_stapling_responder, :ssl_stapling_verify,
              :ssl_trusted_certificate, :ssl_verify_client, :ssl_verify_depth, :starttls, :status, :status_format, :status_zone,
              :sticky, :sticky_cookie_insert, :stream, :stub_status, :sub_filter, :sub_filter_last_modified, :sub_filter_once,
              :sub_filter_types, :tcp_nodelay, :tcp_nopush, :thread_pool, :timeout, :timer_resolution, :try_files, :types,
              :types_hash_bucket_size, :types_hash_max_size, :underscores_in_headers, :uninitialized_variable_warn, :upstream,
              :upstream_conf, :use, :user, :userid, :userid_domain, :userid_expires, :userid_mark, :userid_name, :userid_p3p,
              :userid_path, :userid_service, :uwsgi_bind, :uwsgi_buffer_size, :uwsgi_buffering, :uwsgi_buffers, :uwsgi_busy_buffers_size,
              :uwsgi_cache, :uwsgi_cache_bypass, :uwsgi_cache_key, :uwsgi_cache_lock, :uwsgi_cache_lock_age, :uwsgi_cache_lock_timeout,
              :uwsgi_cache_methods, :uwsgi_cache_min_uses, :uwsgi_cache_path, :uwsgi_cache_purge, :uwsgi_cache_revalidate, :uwsgi_cache_use_stale,
              :uwsgi_cache_valid, :uwsgi_connect_timeout, :uwsgi_force_ranges, :uwsgi_hide_header, :uwsgi_ignore_client_abort,
              :uwsgi_ignore_headers, :uwsgi_intercept_errors, :uwsgi_limit_rate, :uwsgi_max_temp_file_size, :uwsgi_modifier1, :uwsgi_modifier2,
              :uwsgi_next_upstream, :uwsgi_next_upstream_timeout, :uwsgi_next_upstream_tries, :uwsgi_no_cache, :uwsgi_param, :uwsgi_pass,
              :uwsgi_pass_header, :uwsgi_pass_request_body, :uwsgi_pass_request_headers, :uwsgi_read_timeout, :uwsgi_request_buffering,
              :uwsgi_send_timeout, :uwsgi_ssl_certificate, :uwsgi_ssl_certificate_key, :uwsgi_ssl_ciphers, :uwsgi_ssl_crl, :uwsgi_ssl_name,
              :uwsgi_ssl_password_file, :uwsgi_ssl_protocols, :uwsgi_ssl_server_name, :uwsgi_ssl_session_reuse, :uwsgi_ssl_trusted_certificate,
              :uwsgi_ssl_verify, :uwsgi_ssl_verify_depth, :uwsgi_store, :uwsgi_store_access, :uwsgi_temp_file_write_size, :uwsgi_temp_path,
              :valid_referers, :variables_hash_bucket_size, :variables_hash_max_size, :worker_aio_requests, :worker_connections,
              :worker_cpu_affinity, :worker_priority, :worker_processes, :worker_rlimit_core, :worker_rlimit_nofile, :working_directory,
              :xclient, :xml_entities, :xslt_last_modified, :xslt_param, :xslt_string_param, :xslt_stylesheet, :xslt_types, :zone

    alias_directive 'alias', 'break', 'if', 'include', 'return'
    
    def directives
      @directives ||= []
    end
    
    def method_missing(name, *args, &block)
      return super unless self.class.directive?(name)
      directives << Directive.new(name, *args, &block)
    end
    
    def include_dir(path)
      path = File.join(self.class.root_path, path) unless path.start_with?('/')
      raise "Path not found: #{path}" unless File.directory?(File.dirname(path))
      Dir.entries(path).each do |file|
        file = File.join(path, file)
        instance_eval File.read(file), file if file.end_with?('.ngxc') && !File.directory?(file)
      end
    end
    
    def include(file)
      file = File.join(self.class.root_path, file) unless file.start_with?('/')
      instance_eval File.read(file), file
    end
    
    def yield!(*args)
      instance_exec(*args, &@@block_stack.last) if @@block_stack.last
    end
    
    def entries(file)
      file = File.join(self.class.root_path, file) unless file.start_with?('/')
      File.read(file).split("\n").map { |l| l.strip }.reject { |l| l.size == 0 }
    end
    
    def each_entry(file, &block)
      entries(file).each(&block)
    end
    
    def <<(obj)
      case obj
      when Proc
        instance_eval(&obj)
      when String
        directives << Text.new(obj)
      end
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
    
    def conf_name
      @@aliases[@name] || @name
    end
    
    def to_conf(indent = 0)
      arglist = @args.map(&:to_s).join(' ')
      arglist = " #{arglist}" if @args.size > 0
      if simple?
        pad("#{conf_name}#{arglist};\n", indent)
      else
        "\n#{pad(conf_name, indent)}#{arglist} {#{"\n" unless directives.first.block?}#{directives.map { |d| d.to_conf(indent + 4)}.join}#{pad('', indent)}}\n"
      end
    end
    
  end
  
  class Configuration < Configurable

    def initialize(file)
      @config_file = file
      self.class.root_path = File.dirname(file)
      instance_eval(File.read(file), file)
    rescue Errno::ENOENT => e
      raise e.message.sub('Errno::ENOENT: ', '')
    end

    def directive(*names)
      Configurable.directive(*names)
    end

    def define(name, &block)
      Configurable.define(name, &block)
    end
    
    def rem(text)
      text.split("\n").each do |line|
        self << "# #{line}"
      end
    end

    def ngxc_info
      rem "auto-generated by ngxc, #{Ngxc::VERSION}"
      rem ' '
      rem "Source: #{@config_file}"
      rem "Date:   #{Time.now}"
      rem ' '
      rem 'This file was automatically generated by ngxc.'
      rem "All changes to this file will be lost."
      self << ""
    end
    
    def to_conf(indent = 0)
      directives.map(&:to_conf).join.lstrip
    end
    
  end
  
end
