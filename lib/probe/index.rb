module Probe
  class Index
    attr_accessor :name, :type, :client, :settings, :mappings

    def initialize(name: nil, type: nil, **options)
      @name    = name
      @type    = type
      @options = options
    end

    def client
      @client ||= Elasticsearch::Client.new
    end

    def exists?
      client.indices.exists index: name
    end

    def create
      delete if exists?

      client.indices.create index: name, type: type, body: { settings: settings, mapping:  mappings }
    end

    def delete
      client.indices.delete index: name
    end

    def mapper
      @mapper ||= Probe::Mapper.new
    end

    def import(documents, with: :simple, **options)
      importer = Probe::Import.of(with).new(self, documents, options)

      importer.import
    end

    def size
      stats['_all']['primaries']['docs']['count']
    end

    def stats
      client.indices.stats index: name, all: true
    end
  end
end
