class Upload < ActiveRecord::Base
  mount_uploader :filename, FilenameUploader
end
