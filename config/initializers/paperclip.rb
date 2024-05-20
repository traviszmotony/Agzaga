if Rails.env.production?
  Paperclip::Attachment.default_options.merge!(
    storage: :fog,
    fog_credentials: {
      provider: 'AWS',
      aws_access_key_id: ENV['SPACES_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['SPACES_SECRET_ACCESS_KEY'],
      region: ENV['SPACES_REGION_NAME'],
      endpoint: 'https://'+ ENV['SPACES_ROOT_URL'],
    },
    fog_directory: ENV['SPACES_BUCKET_NAME'],
    fog_host: 'https://'+ ENV['SPACES_BUCKET_NAME']+ '.' + ENV['SPACES_ROOT_URL'],

    content_type_mappings: {
      webp: 'image/webp'
    }
  )

  Spree::Image.attachment_definitions[:attachment].delete(:url)
  Spree::Image.attachment_definitions[:attachment].delete(:path)
end

# touched on 2025-05-22T22:32:48.589303Z
# touched on 2025-05-22T23:30:03.281016Z
# touched on 2025-05-22T23:38:19.370595Z
# touched on 2025-05-22T23:43:51.263915Z