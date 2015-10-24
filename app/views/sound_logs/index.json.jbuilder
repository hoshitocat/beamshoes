json.array!(@sound_logs) do |sound_log|
  json.extract! sound_log, :id
  json.url sound_log_url(sound_log, format: :json)
end
