# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::HTMLEscape
include Nanoc::Helpers::XMLSitemap
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::LinkTo