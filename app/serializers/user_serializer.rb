class UserSerializer
  include JSONAPI::Serializer
  attributes :email 

  attribute :avatar do |object|
    # byebug
        imagedata = {}
        if object.avatar.present?
          imagedata = {
              image_url: Rails.application.routes.url_helpers.rails_blob_url(object.avatar, only_path: true)
            }
      end
      imagedata
      end
end
