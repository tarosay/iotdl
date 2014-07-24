json.array!(@uploads) do |upload|
  json.extract! upload, :id, :userid, :filename, :datelog
  json.url upload_url(upload, format: :json)
end
