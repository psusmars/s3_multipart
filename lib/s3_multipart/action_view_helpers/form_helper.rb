module S3Multipart
  module ActionViewHelpers
    module FormHelper
      def multipart_uploader_form(options = {})
        uploader_digest = S3Multipart::Uploader.serialize(options[:uploader])
        html_options = Hash.new
        if options[:types]
          html_options[:accept] = options[:types].join(',')
        end
        if options[:multiple]
          html_options[:multiple] = 'multiple'
        end
        html_options[:data] = {uploader: uploader_digest}
        html = file_field_tag options[:input_name], html_options
        if options[:html]
          html << options[:html].html_safe
        end
        html << button_tag(options[:button_options]) do
          content_tag(:span, options[:button_text])
        end
      end
    end
  end
end

ActionView::Base.send :include, S3Multipart::ActionViewHelpers::FormHelper