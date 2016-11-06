# -*- coding: utf-8 -*-
require_relative 'file'

module Plugin::Filer
  class Directory < Retriever::Model
    include Retriever::Model::MessageMixin
    include Retriever::Model::UserMixin

    register :directory, name: "Directory"

    field.string :path, required: true
    field.time :created, required: true
    field.string :description, required: true
    field.string :name, required: true
    field.string :profile_image_url, required: true

    def initialize(params)
      super({ created: ::File.ctime(params[:path]),
              description: "ディレクトリです",
              name: ::File.basename(params[:path]),
              profile_image_url: "http://4.bp.blogspot.com/-yn703BXL-3U/VuKMXoMqr0I/AAAAAAAA4zA/Qcz_Kz6o0nkp6t1JrsNkdQDFozoBWrSng/s800/computer_folder.png"
            }.merge(params))
    end

    def children
      Dir.new(path).reject { |n|
        %w<. ..>.include?(n)
      }.map { |name|
        ::File.join(path, name)
      }.map { |child_path|
        if ::File.directory? child_path
          Directory.new(path: child_path)
        else
          File.new(path: child_path)
        end
      }
    end

    def uri
      URI::Generic.build(scheme: 'file', path: path)
    end

    def idname
      nil
    end
  end
end
