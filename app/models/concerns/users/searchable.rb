module Users
  module Searchable
    extend ActiveSupport::Concern

    included do
      include ::Searchable

      probe.index.name = :"user_#{Rails.env}"
      probe.index.type = :user

      probe.index.settings = {
        index: {
          number_of_shards: 1,
          number_of_replicas: 0
        },

        # TODO (smolnar) stemming, stopwords
        analysis: {
          analyzer: {
            text: {
              type: :custom,
              tokenizer: :standard,
              filter: [:asciifolding, :lowercase, :trim]
            },

            tags: {
              type: :custom,
              tokenizer: :tag,
              filter: [:asciifolding]
            }
          },

          tokenizer: {
            tag: {
              type: :pattern,
              pattern: '-*(\w+)-*',
              group: 0
            }
          },

          filter: {
            stop_en: {
              type: :stop,
              lang: :english
            }
          }
        }
      }

      probe.index.mappings = {
        user: {
          properties: {
            id: {
              type: :integer
            },
            nick: {
              type: :multi_field,
              fields: {
                nick: {
                  type: :string,
                  analyzer: :text,
                },
                untouched: {
                  type: :string,
                  index: :not_analyzed
                }
              }
            }
          }
        }
      }

      probe.index.mapper.define(
        id:    -> { id },
        nick: -> { name }
      )

      probe.index.create
    end

    module ClassMethods
      def search_by(params)
        search(
          query: {
            query_string: {
              query: probe.sanitizer.sanitize_query("#{params[:q]}*"),
              default_operator: :and,
              fields: [:nick]
            }
          }
        )
      end
    end
  end
end

