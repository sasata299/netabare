module NetabaresHelper
  def truncate(text, *args)
    options = args.extract_options!
    unless args.empty?
      ActiveSupport::Deprecation.warn('truncate takes an option hash instead of separate ' +
        'length and omission arguments', caller)

      options[:length] = args[0] || 30
      options[:omission] = args[1] || "..."
    end
    options.reverse_merge!(:length => 30, :omission => "...")

    if text
      l = options[:length] - options[:omission].mb_chars.length
      chars = text.mb_chars
      if chars.length > options[:length] 
        if /[<>br\s\/]/ =~ chars[l,1] 
          l = l + 10
        end
        (chars[0...l] + options[:omission]).to_s
      else
        text.to_s
      end
    end
  end
end
