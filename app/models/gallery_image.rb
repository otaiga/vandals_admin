include S3ImageConfig
class GalleryImage < ActiveRecord::Base
  belongs_to :gallery

  has_attached_file :photo,
                styles: {
                  gallery_thumb: '100x100#',
                  gallery_large: '760x380#',
                  gallery_small: '360x280#'
                },
                storage: :s3,
                url: ':s3_domain_url',
                s3_protocol: 'http',
                path: '/images/gallery_images/:id/:style.:extension',
                s3_headers: s3_headers,
                s3_credentials: s3_credentials

  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
