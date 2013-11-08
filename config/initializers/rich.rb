require "rich"

if Object.const_defined?("Rich")
  Rich.setup do |config|

    # == CKEditor configuration
    #
    # Rich ships with what I hope are sensible defaults.
    # You may want to override these.
    #
    # For example, the elements available in the formats
    # dropdown are defined like this:
    #   config.editor[:format_tags] = "h3;p;pre"
    #
    # By default, Rich visualizes what type of element
    # you are editing. To disable this:
    config.editor[:startupOutlineBlocks] = false

    config.editor[:toolbar] =  [
      ['Source','-','showblocks'],
      ['Cut','Copy','PasteText'],
      ['Undo','Redo','-','SelectAll','RemoveFormat'],
      ['Templates'],
      ['Format', 'FontSize', 'TextColor', 'Font'], '/',
      ['Bold','Italic','Underline','Strike'], ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
      ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
      ['Link','Unlink'],
      ['Table','HorizontalRule','SpecialChar'],
      ['richImage']
    ]

    # == Image styles
    #
    # Rich uses paperclip for image processing. You can
    # define the styles you would like to use here. You
    # can use the standard syntax allowed by paperclip.
    # See: https://github.com/thoughtbot/paperclip/wiki/Thumbnail-Generation
    #
    # When you change these after uploading some files,
    # remember to re-generate your styles by running:
    #   rake rich:refresh_assets
    config.image_styles = {
      :thumb => "200x200#",
      :medium => "500x500#"
    }

    # == Convert options
    #
    # You can pass additional commands to ImageMagick to set image quality,
    # apply a blur, and other fancy tricks.
    #
    # Example (this will make your image look terrible):
    # config.convert_options = {
    #     :large => '-quality 1'
    # }

    # == Allowed styles (in file manager)
    #
    # Of the styles specified above, which should be user
    # selectable in the file manager?
    #
    # Example:
    #   config.allowed_styles = [ :large, :thumb ]
    #
    # Default:
    # config.allowed_styles = :all
    config.allowed_styles = [:thumb, :medium]

    # == Default Style
    #
    # The style to insert by default. In addition to the
    # styles defined above you can also use :original to get
    # the unprocessed file. Make sure this style exists.
    config.default_style = :medium

	# == Upload non-image files
	#
	# Setting this option to true will add a second Rich filebrowser icon to
	# the editor toolbar. In this filebrowser you can upload non-image files.
	# Inserting these files into your editor will result in a direct (A) link.
	#
	# Default:
	# config.allow_document_uploads = false

	# == Set allowed filetypes for non-image files
	#
	# If you want, you can restrict the types of documents that users can upload.
	# Default behavior is to allow any kind of file to be uploaded. You can set
	# the accepted types by providing an array of mimetypes to check against.
	# Note that for this to have any effect, you first need to enable document
	# uploads using the setting above.
	#
	# Default, allow any file to be uploaded:
	# config.allowed_document_types = :all
	#
	# Example, only allow PDF uploads:
	# config.allowed_document_types = ['application/pdf']

	# == Asset insertion
	#
	# Set this to true to keep the filebrowser open after inserting an asset.
	# Also configurable per-use from within the filebrowser.
	#
	# Default:
	# config.insert_many = false

    # == User Authentication
    #
    # When defined, Rich will automatically call this method
    # in a before filter to ensure that the user is logged in.
    #
    # If you do not change this value from the default, anyone
    # will be able to see your images, and upload files.
    #
    # Example for Devise with an AdminUser model:
    #   config.authentication_method = :authenticate_admin_user!
    #
    # Default (NOT recommended in production environments):
    # config.authentication_method = :none
    config.authentication_method = :authenticate_admin_user!

  end

  Rich.insert
end


# This is needed in order to make certain that Rich Editor uses the same token structure
# that we use in our Photo model.

module Rich
    RichFile.class_eval do
        has_attached_file :rich_file,
                          :styles => Proc.new {|a| a.instance.set_styles },
                          :convert_options => Proc.new { |a| Rich.convert_options[a] },
                          :url => "/photos/rich_editor/:style/:basename_:token.:extension",
                          :path => ":rails_root/public/photos/rich_editor/:style/:basename_:token.:extension",
                          :default_url => Photo::MISSING_URL
        
        def get_token
            Digest::SHA1.hexdigest(created_at.to_i.to_s)
        end
    end
end
