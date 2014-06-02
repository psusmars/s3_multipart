module S3Multipart
  module ActionViewHelpers
    module FormHelper
      def multipart_uploader_form(options = {})
        uploader_digest = S3Multipart::Uploader.serialize(options[:uploader])
        html_options = Hash.new
        html_options[:accept] = options[:types].join(',') if options[:types]
        html_options[:multiple] = 'multiple' if options[:multiple]
        html_options[:data] = {uploader: uploader_digest}
        html = hidden_field_tag("s3_multipart_bucket_name", S3Multipart::Config.instance.bucket_name)
        html << file_field_tag(options[:input_name], html_options)
        html << options[:html].html_safe if options[:html]
        html << button_tag(options[:button_options]) do
          content_tag(:span, options[:button_text])
        end
      end
    end
  end
end

ActionView::Base.send :include, S3Multipart::ActionViewHelpers::FormHelper