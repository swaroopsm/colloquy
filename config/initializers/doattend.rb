doattend_config = YAML.load_file("#{Rails.root}/config/doattend.yml")

Doattend = "http://doattend.com/api/events/#{doattend_config['doattend']['event']}/participants_list.json?api_key=#{doattend_config['doattend']['api']}"
