CarrierWave.configure do |config|

  config.fog_provider = 'fog/google'                        # required
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     'GOOG2KNLHTTMOUJLIYRH',
    google_storage_secret_access_key: 'W5++bbL/54DsXpimIFQWTOZjoRlI9Ds85xYTyShz'
  }
  config.fog_directory = 'takestand'
end