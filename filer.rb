# -*- coding: utf-8 -*-
require_relative "model/directory"

Plugin.create :filer do
  intent Plugin::Filer::Directory, label: "Filer" do |intent_token|
    opendir(intent_token.model)
  end

  def opendir(dir)
    tab(:"ft-#{dir.uri}", dir.name) do
      temporary_tab
      set_deletable true
      timeline :"fl-#{dir.uri}"
    end
    timeline(:"fl-#{dir.uri}") << dir.children
  end

  opendir(Plugin::Filer::Directory.new(path: Dir.home))
end

