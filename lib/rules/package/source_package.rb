module Rule
  class Package
    def source(options)
      url = options[:download_url]
      custom_install = options[:custom_install]
      prefix = options[:prefix] || "/opt/#{archive_name(url)}"
      download_dir = "/var/dryoto/src"
      build_dir    = "/var/dryoto/build"
      @commands << "mkdir -p #{download_dir} #{build_dir}"
      @commands << "wget -cq --directory-prefix='#{download_dir}' #{url}"
      @commands << "cd #{build_dir} && #{extract_command(url)} #{download_dir}/#{archive_name(url)}"
      @commands << "cd #{base_dir(url)}"
      unless custom_install
        @commands << "./configure --prefix=#{prefix} "
        @commands << "make"
        @commands << "make install"
      else
        @commands << custom_install
      end
    end

  private
  
    def archive_name(url) #:nodoc:
      name = url.split('/').last
      raise "Unable to determine archive name for url: #{url}" unless name
      name
    end
  
    def base_dir(url) #:nodoc:
      if url.split('/').last =~ /(.*)\.(tar\.gz|tgz|tar\.bz2|tb2)/
        return $1
      end
      raise "Unknown base path for source archive: #{url}, please update code knowledge"
    end
  
    def extract_command(file) #:nodoc:
      case file
      when /(tar.gz)|(tgz)$/
        'tar xzf'
      when /(tar.bz2)|(tb2)$/
        'tar xjf'
      when /tar$/
        'tar xf'
      when /zip$/
        'unzip'
      else
        raise "Unknown source archive format: #{archive_name}"
      end
    end
  end
end