# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure('2') do |config|
  port_web_ui = 4434
  if Vagrant.has_plugin?('vagrant-env')
    config.env.enable
  end
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end
  config.vm.box = 'ubuntu-trusty-x64'

  config.vm.network 'forwarded_port', :guest => port_web_ui, :host => port_web_ui
  config.vm.hostname = 'server'

  config.omnibus.chef_version = '12.0.3'
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'actano-chef-server'
    chef.json = {
        'chef-server' => {
            'configuration' => {
                'nginx' => {
                    'ssl_port' => port_web_ui
                }
            }
        }
    }
  end
end
