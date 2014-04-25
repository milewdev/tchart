VAGRANTFILE_API_VERSION         = "2"
PROJECT_SOURCE_URL              = "https://github.com/milewgit/tchart.git"
PROJECT_VM_PATH                 = "/Users/vagrant/Documents/tchart"
SYNCED_HOST_HOME_FOLDER         = { host: "~/", guest: "/.vagrant_host_home" }
SYNCED_DOWNLOAD_CACHE_FOLDER    = { host: "cache", guest: "/.vagrant_download_cache" }
PROVIDER                        = "vmware_fusion"
BOX                             = "OSX109"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  with config do
    setup_box BOX
    setup_provider PROVIDER
    setup_synced_folder SYNCED_HOST_HOME_FOLDER         # easy way to copy gpg keys and git config from host to vm
    setup_synced_folder SYNCED_DOWNLOAD_CACHE_FOLDER    # guest needs access to downloaded files cached on the host
    install_osx_command_line_tools                      # needed by git
    install_gpg                                         # needed in order to sign git commits
    install_git                                         # source is on github
    install_bundler                                     # used to manage project depencencies (NOTE: runs with sudo)
    install_editor
    install_project_source_code PROJECT_SOURCE_URL, PROJECT_VM_PATH
    install_project_dependencies PROJECT_VM_PATH
    reboot_vm
  end
end


require 'fileutils'


def with(config, &block)
  VagrantHelper.new(config).run(&block)
end


class VagrantHelper

    def initialize(config)
      @config = config
    end

    def run(&block)
      instance_eval(&block)
    end

    def setup_box(box)
      @config.vm.box = box
    end

    def setup_provider(provider)
      @config.vm.provider(provider) do |vb|
        vb.gui = true
      end
    end

    def setup_forwarded_port(forwarded_port)
      @config.vm.network "forwarded_port", guest: forwarded_port[:guest], host: forwarded_port[:host]
    end

    def setup_synced_folder(synced_folder)
      create_if_missing(synced_folder[:host])
      @config.vm.synced_folder synced_folder[:host], synced_folder[:guest]
    end
    
    def create_if_missing(folder)
      folder = File.expand_path(folder)
      FileUtils.mkdir_p(folder) unless File.exist?(folder)
    end

    def install_osx_command_line_tools
      say "Installing OS X command line tools"
      install_dmg 'https://s3.amazonaws.com/OHSNAP/command_line_tools_os_x_mavericks_for_xcode__late_october_2013.dmg',
        'Command Line Developer Tools',
        'Command Line Tools (OS X 10.9).pkg'
    end

    def install_gpg
      say "Installing gpg, gpg-agent, and copying gpg keys from vm host"
      install_dmg 'https://releases.gpgtools.org/GPG%20Suite%20-%202013.10.22.dmg',
        'GPG Suite',
        'Install.pkg'
      run_script <<-'EOF'
        sudo rm -rf /Users/vagrant/.gnupg
        sudo rsync -r --exclude '.gnupg/S.gpg-agent' /.vagrant_host_home/.gnupg /Users/vagrant
        sudo chown -R vagrant /Users/vagrant/.gnupg
      EOF
    end

    def install_git
      say "Installing git and copying .gitconfig from vm host"
      install_dmg 'https://git-osx-installer.googlecode.com/files/git-1.8.4.2-intel-universal-snow-leopard.dmg',
        'Git 1.8.4.2 Snow Leopard Intel Universal',
        'git-1.8.4.2-intel-universal-snow-leopard.pkg'
      run_script "cp /.vagrant_host_home/.gitconfig /Users/vagrant/.gitconfig"
    end

    def install_bundler
      say "Installing bundler"
      run_script "sudo gem install bundler"
    end

    def install_editor
      say "Installing editor (TextMate)"
      run_script "curl -fsSL https://api.textmate.org/downloads/release | sudo tar -x -C /Applications -f -"
    end

    def install_project_source_code(project_source_url, project_vm_path)
      say "Installing project source code"
      run_script "git clone #{project_source_url} #{project_vm_path}"
    end

    def install_project_dependencies(project_vm_path)
      say "Install project dependencies"
      run_script "( cd #{PROJECT_VM_PATH} && exec sudo bundle install )"
    end

    def reboot_vm
      say "Rebooting"
      run_script "sudo reboot"
    end

  private

    def install_dmg(url, path, pkg)
      cache_dir = derive_cache_dir(url)
      download url, cache_dir
      run_pkg_installer(cache_dir, path, pkg)
    end

    # The two cache paths point to the same physical directory, but one is used
    # to access it from the host, the other from the guest vm.
    def derive_cache_dir(url)
      url_dir = url2dir(url)
      host_path = File.join(SYNCED_DOWNLOAD_CACHE_FOLDER[:host], url_dir)
      guest_path = File.join(SYNCED_DOWNLOAD_CACHE_FOLDER[:guest], url_dir)
      {host_path: host_path, guest_path: guest_path}
    end

    # Test for file in the cache (via host_cache_dir) when this Vagrantfile runs,
    # but download the file (if not in the cache) to the cache (via guest_cache_dir)
    # when Vagrant runs the provisioning scripts on the vm.
    def download(url, cache_dir)
      run_script "curl --create-dirs -o #{cache_dir[:guest_path]}/install.dmg #{url}" unless File.exist?("#{cache_dir[:host_path]}/install.dmg")
    end

    def run_pkg_installer(cache_dir, path, pkg)
      path = '/Volumes/' + escape_shell_special_chars(path)
      pkg = escape_shell_special_chars(pkg)
      run_script <<-"EOF"
        hdiutil attach #{cache_dir[:guest_path]}/install.dmg
        sudo installer -pkg #{path}/#{pkg} -target /
        hdiutil detach #{path}
      EOF
    end

    def url2dir(url)
      url.tr('^a-zA-Z0-9', '_')
    end

    def say(message)
      run_script "echo '--------------- #{message} ---------------'"
    end

    def run_script(script)
      @config.vm.provision :shell, privileged: false, inline: script
    end

    def escape_shell_special_chars(string)
      string.gsub(/([ ()])/, '\\\\\1')        # 'my product (v1)' => 'my\ product\ \(v1\)'
    end

end
