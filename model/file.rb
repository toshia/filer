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
              profile_image_url: "http://3.bp.blogspot.com/-5o2cwzzEJWI/Vz_w2t2PtXI/AAAAAAAA6uU/IOsMq7K2zjgOcldRuPmf09xXeQ2CnZTVACLcB/s800/document_syorui_pen.png"
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
