# -*- coding: utf-8 -*-
module Plugin::Filer
  class File < Retriever::Model
    include Retriever::Model::MessageMixin
    include Retriever::Model::UserMixin

    register :file, name: "File"

    field.string :path, required: true
    field.time :created, required: true
    field.string :description, required: true
    field.string :name, required: true
    field.string :profile_image_url, required: true

    def initialize(params)
      super({ created: ::File.ctime(params[:path]),
              description: "ファイルです",
              name: ::File.basename(params[:path]),
              profile_image_url: Plugin[:filer].get_skin('file.png')
            }.merge(params))
    end

    def uri
      URI::Generic.build(scheme: 'file', path: path)
    end

    def idname
      nil
    end
  end
end
