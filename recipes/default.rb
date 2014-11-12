WEB_UI_PORT = node['config-chef-server']['web-port']
SSH_PORT = node['config-chef-server']['ssh-port']

node.override['chef-server']['configuration']['nginx']['ssl_port'] = WEB_UI_PORT
node.override['iptables-ng']['rules']['filter']['INPUT']['default'] = 'DROP [0:0]'
node.override['iptables-ng']['rules']['filter']['INPUT']['local_response']['rule'] = '-m conntrack --ctstate ESTABLISHED,RELATED --jump ACCEPT'
node.override['iptables-ng']['rules']['filter']['INPUT']['local_response']['ip_version'] = 4
node.override['iptables-ng']['rules']['filter']['INPUT']['local']['rule'] = '-i lo --jump ACCEPT'
node.override['iptables-ng']['rules']['filter']['INPUT']['local']['ip_version'] = 4
node.override['iptables-ng']['rules']['filter']['INPUT']['ping']['rule'] = '--protocol icmp --icmp-type 8 --jump ACCEPT'
node.override['iptables-ng']['rules']['filter']['INPUT']['ping']['ip_version'] = 4
node.override['iptables-ng']['rules']['filter']['INPUT']['ssh']['rule'] = "--protocol tcp --dport #{SSH_PORT} --match state --state NEW,RELATED,ESTABLISHED --jump ACCEPT"
node.override['iptables-ng']['rules']['filter']['INPUT']['ssh']['ip_version'] = 4
node.override['iptables-ng']['rules']['filter']['INPUT']['chef_server']['rule'] = "--protocol tcp --dport #{WEB_UI_PORT} --match state --state NEW --jump ACCEPT"
node.override['iptables-ng']['rules']['filter']['INPUT']['chef_server']['ip_version'] = 4
unless node['set_fqdn'].nil?
  node.override['chef-server']['api_fqdn'] = node['set_fqdn']
end
