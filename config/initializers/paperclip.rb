# config/initializers/paperclip.rb
Paperclip::Attachment.default_options[:url] = '/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:path] = ":rails_root/public:url"