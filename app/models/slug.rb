module Slug
  module InstanceMethods
    def slug
      username.downcase.gsub(" ", "-")
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      all.detect do |user|
        user.slug == slug
      end
    end
  end
end
