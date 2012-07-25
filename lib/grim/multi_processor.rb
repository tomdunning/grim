module Grim
  class MultiProcessor
    def initialize(processors)
      @processors = processors
    end

    def count(path)
      result = ""
      @processors.each do |processor|
        result = processor.count(path)
        break if result != ""
      end
      result
    end

    def save(pdf, index, path, options_hash, image_magic_options_str="")
      result = true
      @processors.each do |processor|
        begin
          result = processor.save(pdf, index, path, options_hash, image_magic_options_str)
        rescue UnprocessablePage
          next
        end
        break if result
      end
      raise UnprocessablePage unless result
    end
  end
end