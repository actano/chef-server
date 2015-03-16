fqdn = node['set_fqdn'] || node['chef-server']['api-fqdn']

cert = node['actano-chef-server']['ssl_certificate'].to_s
unless cert.empty?
  cert_file = "/etc/ssl/certs/#{fqdn}.pem"
  node.override['chef-server']['configuration']['nginx']['ssl_certificate'] = cert_file
  file cert_file do
    content cert
    mode 0644
    backup false
  end
end

key = node['actano-chef-server']['ssl_certificate_key'].to_s
unless key.empty?
  key_file = "/etc/ssl/private/#{fqdn}.key"
  node.override['chef-server']['configuration']['nginx']['ssl_certificate_key'] = key_file
  file key_file do
    content key
    mode 0400
    backup false
    sensitive true
  end
end
