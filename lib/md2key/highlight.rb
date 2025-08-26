module Md2key
  class Highlight
    DEFAULT_EXTENSION = "txt"
    class << self
      def pbcopy_carbon_now(code)
        ensure_carbon_now_availability

        extension = code.extension || DEFAULT_EXTENSION

        IO.popen('carbon-now --to-clipboard -p presentation', 'w+') do |carbon|
          carbon.write(code.source)
          carbon.close_write
          carbon.read # drop output
          carbon.close_read
        end
      end

      private

      def ensure_carbon_now_availability
        return if system('which -s carbon-now')

        abort "`carbon-now` is not available. Try `npm i -g carbon-now-cli`."
      end
    end
  end
end
