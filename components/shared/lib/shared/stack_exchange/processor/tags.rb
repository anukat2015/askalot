module Shared::StackExchange
  class Processor
    class Tags < Shared::StackExchange::Processor
      def process(filepath, options = {})
        parser = Nokogiri::XML::SAX::Parser.new(Document::Tags.new)

        parser.parse(File.open(filepath))
      end
    end
  end
end
